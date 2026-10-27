// Monta o site em _site/: a página e o PWA (web/), o Parchment (.tools/parchment)
// e o jogo compilado (build/zork1-ptbr.z5, publicado em base64 em interpreter/).
// Uso: node tools/build-site.mjs [--versao <texto>]   (padrão: commit atual)
import { execSync } from 'node:child_process'
import { cpSync, existsSync, mkdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs'
import { fileURLToPath } from 'node:url'

process.chdir(fileURLToPath(new URL('..', import.meta.url)))

const PARCHMENT = '.tools/parchment/Parchment'
const HISTORIA = 'build/zork1-ptbr.z5'
const ARQUIVOS_PARCHMENT = ['parchment.js', 'parchment.css', 'jquery.min.js', 'bocfel-noz6.js']

function versaoPadrao() {
  try {
    return execSync('git rev-parse --short HEAD', { encoding: 'utf8' }).trim()
  } catch {
    return 'local'
  }
}

const indice = process.argv.indexOf('--versao')
const versao = indice > 0 ? process.argv[indice + 1] : versaoPadrao()

for (const [caminho, comoObter] of [
  [PARCHMENT, 'bash tools/baixar-ferramentas.sh'],
  [HISTORIA, 'bash tools/build.sh'],
]) {
  if (!existsSync(caminho)) {
    console.error(`ERRO: falta ${caminho}; rode ${comoObter}`)
    process.exit(1)
  }
}

rmSync('_site', { recursive: true, force: true })
mkdirSync('_site/interpreter', { recursive: true })
cpSync('web', '_site', { recursive: true })
for (const arquivo of ARQUIVOS_PARCHMENT) {
  cpSync(`${PARCHMENT}/${arquivo}`, `_site/interpreter/${arquivo}`)
}
// O Parchment para Inform 7 carrega tudo por JSONP: a história vai em base64
// dentro de uma chamada ParchmentResource(...).
const base64 = readFileSync(HISTORIA).toString('base64')
writeFileSync('_site/interpreter/zork1-ptbr.z5.js', `ParchmentResource({base64: 1, data: '${base64}'})`)

const sw = readFileSync('_site/sw.js', 'utf8')
writeFileSync('_site/sw.js', sw.replaceAll('__VERSAO__', versao))
// Sem isto o GitHub Pages passa os arquivos pelo Jekyll.
writeFileSync('_site/.nojekyll', '')

console.log(`_site/ montado (versão ${versao})`)
