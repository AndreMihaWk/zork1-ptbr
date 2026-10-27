// Detector de texto em inglês: compara os textos (strings) de src/*.zil com os
// de original/*.zil. Um texto idêntico ao original ainda não foi traduzido.
//
// Uso: node tools/check-strings.mjs [--estrito] [--listar]
//   --estrito  falha (código 1) se sobrar algum texto sem tradução
//   --listar   mostra cada texto sem tradução
//
// Textos que devem continuar iguais ao original (nomes próprios etc.) ficam em
// tests/textos-iguais.txt, um por linha.
import { appendFileSync, existsSync, readdirSync, readFileSync } from 'node:fs'
import { fileURLToPath } from 'node:url'

process.chdir(fileURLToPath(new URL('..', import.meta.url)))

const estrito = process.argv.includes('--estrito')
const listar = process.argv.includes('--listar')

// Extrai os textos visíveis de um arquivo ZIL. Ignora comentários (o que vem
// depois de ";"), caracteres literais (!\") e nomes de arquivo de INSERT-FILE.
function textos(codigo) {
  const encontrados = []
  let i = 0

  function lerTexto() { // i aponta para a aspa de abertura
    let texto = ''
    for (i++; i < codigo.length && codigo[i] !== '"'; i++) {
      if (codigo[i] === '\\') i++
      texto += codigo[i]
    }
    i++
    return texto
  }

  function pularObjeto() { // pula um objeto ZIL inteiro (comentado)
    while (/\s/.test(codigo[i])) i++
    const abre = codigo[i]
    if (abre === '"') return lerTexto()
    const fecha = { '<': '>', '(': ')', '[': ']' }[abre]
    if (!fecha) {
      while (i < codigo.length && !/[\s<>()[\]"]/.test(codigo[i])) i++
      return
    }
    let nivel = 0
    for (; i < codigo.length; i++) {
      const c = codigo[i]
      if (c === '"') { lerTexto(); i-- }
      else if (c === '\\') i++
      else if ('<(['.includes(c)) nivel++
      else if ('>)]'.includes(c) && --nivel === 0) { i++; return }
    }
  }

  while (i < codigo.length) {
    const c = codigo[i]
    if (c === ';') { i++; pularObjeto() }
    else if (c === '\\') i += 2
    else if (c === '"') {
      const antes = codigo.slice(Math.max(0, i - 20), i)
      const texto = lerTexto()
      if (/[A-Za-z]/.test(texto) && !/INSERT-FILE\s+$/.test(antes)) encontrados.push(texto)
    } else i++
  }
  return encontrados
}

const normalizar = texto => texto.replace(/\s+/g, ' ').trim()

const originais = new Set()
for (const arquivo of readdirSync('original').filter(a => a.endsWith('.zil'))) {
  for (const texto of textos(readFileSync(`original/${arquivo}`, 'utf8'))) originais.add(normalizar(texto))
}

const permitidos = new Set(
  existsSync('tests/textos-iguais.txt')
    ? readFileSync('tests/textos-iguais.txt', 'utf8').split('\n').map(normalizar).filter(Boolean)
    : [],
)

let total = 0
let semTraducao = 0
const linhas = []
for (const arquivo of readdirSync('src').filter(a => a.endsWith('.zil')).sort()) {
  const doArquivo = textos(readFileSync(`src/${arquivo}`, 'utf8')).map(normalizar)
  const pendentes = doArquivo.filter(t => originais.has(t) && !permitidos.has(t))
  total += doArquivo.length
  semTraducao += pendentes.length
  const feito = doArquivo.length ? Math.floor(100 * (1 - pendentes.length / doArquivo.length)) : 100
  linhas.push(`| ${arquivo} | ${doArquivo.length} | ${pendentes.length} | ${feito}% |`)
  if (listar) for (const t of pendentes) console.log(`${arquivo}: ${t.slice(0, 100)}`)
}

const porcentagem = total ? Math.floor(100 * (1 - semTraducao / total)) : 100
const relatorio = [
  `### Tradução: ${porcentagem}% (${total - semTraducao} de ${total} textos)`,
  '',
  '| Arquivo | Textos | Sem tradução | Traduzido |',
  '|---|---:|---:|---:|',
  ...linhas,
  '',
].join('\n')

console.log(relatorio)
if (process.env.GITHUB_STEP_SUMMARY) appendFileSync(process.env.GITHUB_STEP_SUMMARY, relatorio)

if (estrito && semTraducao > 0) {
  console.error(`ERRO: ${semTraducao} textos ainda iguais ao original (rode com --listar para ver)`)
  process.exit(1)
}
