// Testa o site montado (_site/) num navegador headless simulando um celular.
// Serve o site em /zork1-ptbr/, como no GitHub Pages. Os testes não dependem do
// idioma do jogo: conferem que os comandos chegam ao jogo e que ele responde.
//
// Uso: node tools/testar-site.mjs
//   NAVEGADOR_CANAL=msedge  usa o Edge instalado (local, sem baixar o Chromium)
import { mkdirSync, readFileSync, readdirSync } from 'node:fs'
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

// O Bocfel pode abrir uma segunda janela de texto para avisos; a do jogo é a primeira.
const campo = pagina.locator('textarea.LineInput')
const campoLivre = pagina.locator('textarea.LineInput:not([disabled])')
const textoDoJogo = () => pagina.locator('.BufferWindow').first().innerText()
const linhaDeStatus = async () => (await pagina.locator('.GridWindow').innerText()).trim()
const esperarTexto = (trecho, timeout = 10000) => pagina.waitForFunction(
  t => document.querySelector('.BufferWindow')?.innerText.includes(t), trecho, { timeout })
const esperarResposta = antes => pagina.waitForFunction(
  n => document.querySelector('.BufferWindow').innerText.length > n + 10, antes)
const dialogoDeArquivos = pagina.locator('dialog.asyncglk_file_dialog[open]')

await pagina.goto(url)

await passo('o jogo carrega e espera um comando', async () => {
  await campo.waitFor({ timeout: 30000 })
  if ((await textoDoJogo()).length < 100) throw new Error('quase nenhum texto na tela')
})

await passo('a linha de status mostra o local', async () => {
  const status = await linhaDeStatus()
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

await passo('o botão Desfazer envia o comando', async () => {
  const antes = (await textoDoJogo()).length
  await pagina.locator('#atalhos button[data-comando="desfazer"]').tap()
  await esperarTexto(`>${comandos.desfazer}`)
  await esperarResposta(antes)
})

// No teclado ABNT2, "^" e "~" são teclas mortas: a tecla morta abre uma
// composição e a vogal seguinte a fecha com a letra acentuada. Aqui isso é
// simulado pelo protocolo do Chromium, como faz o sistema operacional.
await passo('acentos com tecla morta (ABNT2) e histórico com as setas', async () => {
  const cdp = await contexto.newCDPSession(pagina)
  const morta = { key: 'Dead', code: 'Quote', windowsVirtualKeyCode: 222, modifiers: 8 }
  await campo.fill('')
  await campo.focus()
  await pagina.keyboard.type('l')
  await cdp.send('Input.dispatchKeyEvent', { type: 'rawKeyDown', ...morta })
  await cdp.send('Input.imeSetComposition', { text: '^', selectionStart: 1, selectionEnd: 1 })
  await cdp.send('Input.dispatchKeyEvent', { type: 'keyUp', ...morta })
  await cdp.send('Input.insertText', { text: 'â' })
  await pagina.keyboard.type('mpada')
  await cdp.detach()
  const digitado = await campo.inputValue()
  if (digitado !== 'lâmpada') throw new Error(`campo com ${JSON.stringify(digitado)}`)
  await campo.press('Enter')
  await esperarTexto('>lâmpada')
  await campo.press('ArrowUp')
  const anterior = await campo.inputValue()
  if (anterior !== 'lâmpada') throw new Error(`a seta para cima trouxe ${JSON.stringify(anterior)}`)
  await campo.press('ArrowDown')
  const depois = await campo.inputValue()
  if (depois !== '') throw new Error(`a seta para baixo deixou ${JSON.stringify(depois)}`)
})

await passo('o painel Sobre abre com os créditos e fecha', async () => {
  const sobre = pagina.locator('#sobre')
  await pagina.locator('#atalhos button[data-acao="sobre"]').tap()
  await sobre.waitFor()
  const texto = await sobre.innerText()
  for (const trecho of ['Tim Anderson', 'Marc Blank', 'Bruce Daniels', 'Dave Lebling', 'Microsoft', 'MIT', 'não oficial', 'marca registrada']) {
    if (!texto.includes(trecho)) throw new Error(`falta "${trecho}"`)
  }
  if (!await sobre.locator('a[href="https://github.com/AndreMihaWk/zork1-ptbr"]').count()) throw new Error('falta o link do repositório')
  await sobre.locator('form button').tap()
  await sobre.waitFor({ state: 'hidden' })
  // Também fecha com um toque fora do painel.
  await pagina.locator('#atalhos button[data-acao="sobre"]').tap()
  await sobre.waitFor()
  await pagina.touchscreen.tap(5, 5)
  await sobre.waitFor({ state: 'hidden' })
})

await passo('nenhum botão da barra corta o rótulo, de 320 a 430 px', async () => {
  for (const largura of [320, 360, 390, 430]) {
    await pagina.setViewportSize({ width: largura, height: 844 })
    const cortados = await pagina.evaluate(() => [...document.querySelectorAll('#atalhos button')]
      .filter(b => b.scrollWidth > b.clientWidth).map(b => b.textContent.trim()))
    if (cortados.length) throw new Error(`${largura} px: ${cortados.join(', ')}`)
  }
  await pagina.setViewportSize({ width: 390, height: 844 })
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

await passo('todo script, estilo e página do site está no cache do service worker', async () => {
  const esperados = [
    ...readdirSync('_site').filter(nome => /\.(js|css|html)$/.test(nome) && nome !== 'sw.js'),
    ...readdirSync('_site/interpreter').map(nome => `interpreter/${nome}`),
  ]
  const guardados = await pagina.evaluate(async () => {
    const cache = await caches.open((await caches.keys())[0])
    return (await cache.keys()).map(pedido => new URL(pedido.url).pathname)
  })
  const faltando = esperados.filter(arquivo => !guardados.includes(`${BASE}${arquivo}`))
  if (faltando.length) throw new Error(`fora da lista de web/sw.js: ${faltando.join(', ')}`)
})

mkdirSync('build', { recursive: true })
await pagina.screenshot({ path: 'build/site-celular.png' })

await passo('o jogo abre sem internet', async () => {
  await contexto.setOffline(true)
  await pagina.reload()
  await campo.waitFor({ timeout: 30000 })
  await contexto.setOffline(false)
})

// Salvar e Carregar abrem o diálogo de arquivos do Parchment, traduzido por
// web/dialogos.js. "Baixar" exporta o save e "Importar" o traz de volta.
const SAVE_BAIXADO = 'build/save-teste.glksave'

async function enviarPelaBarra(comando) {
  const antes = (await textoDoJogo()).length
  await pagina.locator(`#atalhos button[data-comando="${comando}"]`).tap()
  await esperarTexto(`>${comandos[comando]}`)
  await esperarResposta(antes)
  await campoLivre.waitFor()
}

let statusSalvo = ''
await passo('salvar pelo diálogo, em português', async () => {
  await enviarPelaBarra('norte')
  statusSalvo = await linhaDeStatus()
  await pagina.locator('#atalhos button[data-comando="salvar"]').tap()
  await dialogoDeArquivos.waitFor()
  const botao = (await dialogoDeArquivos.locator('button.submit').innerText()).trim()
  if (botao !== 'Salvar') throw new Error(`o diálogo não foi traduzido (botão "${botao}")`)
  await pagina.locator('#filename_input').fill('teste')
  await dialogoDeArquivos.locator('button.submit').click()
  await dialogoDeArquivos.waitFor({ state: 'hidden' })
  await campoLivre.waitFor()
  await enviarPelaBarra('norte')
  if (await linhaDeStatus() === statusSalvo) throw new Error('o jogador não saiu do lugar depois de salvar')
})

await passo('exportar o save com o botão Baixar', async () => {
  await pagina.locator('#atalhos button[data-comando="carregar"]').tap()
  await dialogoDeArquivos.waitFor()
  await dialogoDeArquivos.locator('#filelist button[data-fullpath$="teste.glksave"]').click()
  const [baixado] = await Promise.all([
    pagina.waitForEvent('download', { timeout: 10000 }),
    dialogoDeArquivos.getByRole('button', { name: 'Baixar' }).click(),
  ])
  await baixado.saveAs(SAVE_BAIXADO)
  if (readFileSync(SAVE_BAIXADO).length < 100) throw new Error('arquivo baixado vazio')
  await dialogoDeArquivos.locator('.foot button.close').click()
  await dialogoDeArquivos.waitFor({ state: 'hidden' })
})

await passo('importar o save depois de apagar o armazenamento e carregar', async () => {
  await pagina.evaluate(() => localStorage.clear())
  await pagina.reload()
  await campo.waitFor({ timeout: 30000 })
  await pagina.locator('#atalhos button[data-comando="carregar"]').tap()
  await dialogoDeArquivos.waitFor()
  if (await dialogoDeArquivos.locator('#filelist button[data-fullpath]').count()) {
    throw new Error('o armazenamento não foi apagado')
  }
  await dialogoDeArquivos.locator('#add_file').setInputFiles(SAVE_BAIXADO)
  const arquivo = dialogoDeArquivos.locator('#filelist button[data-fullpath$="save-teste.glksave"]')
  await arquivo.waitFor()
  await arquivo.click()
  await dialogoDeArquivos.locator('button.submit').click()
  await dialogoDeArquivos.waitFor({ state: 'hidden' })
  await pagina.waitForFunction(s => document.querySelector('.GridWindow')?.innerText.trim() === s, statusSalvo)
})

await passo('a página não teve erros de JavaScript', async () => {
  if (errosDaPagina.length) throw new Error(errosDaPagina.join(' | '))
})

await navegador.close()
servidor.close()

const manifesto = JSON.parse(readFileSync('_site/manifest.webmanifest', 'utf8'))
console.log(falhas ? `\n${falhas} teste(s) falharam` : `\nSite ok (${manifesto.short_name})`)
process.exit(falhas ? 1 : 0)
