// Testa o site montado (_site/) num navegador headless simulando um celular.
// Serve o site em /zork1-ptbr/, como no GitHub Pages. Os testes não dependem do
// idioma do jogo: conferem que os comandos chegam ao jogo e que ele responde.
//
// Uso: node tools/testar-site.mjs
//   NAVEGADOR_CANAL=msedge  usa o Edge instalado (local, sem baixar o Chromium)
import { mkdirSync, readFileSync } from 'node:fs'
import { readFile } from 'node:fs/promises'
import { createServer } from 'node:http'
import { extname, join, normalize } from 'node:path'
import { fileURLToPath } from 'node:url'
import { chromium } from 'playwright'

process.chdir(fileURLToPath(new URL('..', import.meta.url)))

const BASE = '/zork1-ptbr/'
const TIPOS = {
  '.css': 'text/css',
  '.html': 'text/html; charset=utf-8',
  '.js': 'text/javascript',
  '.png': 'image/png',
  '.svg': 'image/svg+xml',
  '.webmanifest': 'application/manifest+json',
}

const servidor = createServer(async (pedido, resposta) => {
  const caminho = decodeURIComponent(new URL(pedido.url, 'http://x').pathname)
  if (!caminho.startsWith(BASE)) return resposta.writeHead(404).end()
  let arquivo = caminho.slice(BASE.length)
  if (arquivo === '' || arquivo.endsWith('/')) arquivo += 'index.html'
  try {
    const dados = await readFile(join('_site', normalize(arquivo)))
    resposta.writeHead(200, { 'content-type': TIPOS[extname(arquivo)] ?? 'application/octet-stream' })
    resposta.end(dados)
  } catch {
    resposta.writeHead(404).end()
  }
}).listen(0)
const url = `http://localhost:${servidor.address().port}${BASE}`

const navegador = await chromium.launch({ channel: process.env.NAVEGADOR_CANAL || undefined })
const contexto = await navegador.newContext({
  viewport: { width: 390, height: 844 },
  deviceScaleFactor: 2,
  hasTouch: true,
  isMobile: true,
})
const pagina = await contexto.newPage()
const errosDaPagina = []
pagina.on('pageerror', erro => errosDaPagina.push(String(erro)))

let falhas = 0
async function passo(nome, teste) {
  try {
    await teste()
    console.log(`ok     ${nome}`)
  } catch (erro) {
    falhas++
    console.log(`FALHOU ${nome}: ${erro.message.split('\n')[0]}`)
  }
}

const campo = pagina.locator('textarea.LineInput')
const textoDoJogo = () => pagina.locator('.BufferWindow').innerText()
const esperarTexto = (trecho, timeout = 10000) => pagina.waitForFunction(
  t => document.querySelector('.BufferWindow')?.innerText.includes(t), trecho, { timeout })

await pagina.goto(url)

await passo('o jogo carrega e espera um comando', async () => {
  await campo.waitFor({ timeout: 30000 })
  if ((await textoDoJogo()).length < 100) throw new Error('quase nenhum texto na tela')
})

await passo('a linha de status mostra o local', async () => {
  const status = (await pagina.locator('.GridWindow').innerText()).trim()
  if (status.length < 4) throw new Error(`status vazio: ${JSON.stringify(status)}`)
})

await passo('o campo de entrada está ajustado para teclado virtual', async () => {
  const atributos = await campo.evaluate(c => ({
    autocapitalize: c.getAttribute('autocapitalize'),
    autocorrect: c.getAttribute('autocorrect'),
    spellcheck: c.getAttribute('spellcheck'),
  }))
  const esperado = { autocapitalize: 'none', autocorrect: 'off', spellcheck: 'false' }
  if (JSON.stringify(atributos) !== JSON.stringify(esperado)) throw new Error(JSON.stringify(atributos))
})

const comandos = await pagina.evaluate(() => COMANDOS)

await passo('um botão da barra de atalhos envia o comando', async () => {
  const antes = (await textoDoJogo()).length
  await pagina.locator('#atalhos button[data-comando="norte"]').tap()
  await esperarTexto(`>${comandos.norte}`)
  await pagina.waitForFunction(n => document.querySelector('.BufferWindow').innerText.length > n + 30, antes)
})

await passo('digitar um comando e apertar Enter funciona', async () => {
  await campo.fill(comandos.inventario)
  await campo.press('Enter')
  await esperarTexto(`>${comandos.inventario}`)
})

await passo('um botão com "…" só começa o comando', async () => {
  await pagina.locator('#atalhos button[data-comando="pegar"]').tap()
  const valor = await campo.inputValue()
  if (valor !== comandos.pegar) throw new Error(`campo com ${JSON.stringify(valor)}`)
  await campo.fill('')
})

await passo('o service worker guarda o jogo para uso offline', async () => {
  const arquivos = await pagina.evaluate(async () => {
    const registro = await navigator.serviceWorker.ready
    for (let i = 0; i < 50 && !registro.active; i++) await new Promise(r => setTimeout(r, 100))
    const nomes = await caches.keys()
    return nomes.length ? (await (await caches.open(nomes[0])).keys()).length : 0
  })
  if (arquivos < 10) throw new Error(`só ${arquivos} arquivos no cache`)
})

mkdirSync('build', { recursive: true })
await pagina.screenshot({ path: 'build/site-celular.png' })

await passo('o jogo abre sem internet', async () => {
  await contexto.setOffline(true)
  await pagina.reload()
  await campo.waitFor({ timeout: 30000 })
  await contexto.setOffline(false)
})

await passo('a página não teve erros de JavaScript', async () => {
  if (errosDaPagina.length) throw new Error(errosDaPagina.join(' | '))
})

await navegador.close()
servidor.close()

const manifesto = JSON.parse(readFileSync('_site/manifest.webmanifest', 'utf8'))
console.log(falhas ? `\n${falhas} teste(s) falharam` : `\nSite ok (${manifesto.short_name})`)
process.exit(falhas ? 1 : 0)
