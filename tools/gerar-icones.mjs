// Gera os ícones do PWA (web/icones/) a partir de uma lanterna em pixel art.
// Uso: node tools/gerar-icones.mjs
import { mkdirSync, writeFileSync } from 'node:fs'
import { deflateSync } from 'node:zlib'

const DESENHO = [
  '................',
  '......kkkk......',
  '.....k....k.....',
  '.....k....k.....',
  '....kkkkkkkk....',
  '...kbbbbbbbbk...',
  '....kbggggbk....',
  '....kbgffgbk....',
  '....kbfwwfbk....',
  '....kbfwwfbk....',
  '....kbgffgbk....',
  '....kbggggbk....',
  '...kbbbbbbbbk...',
  '...kddddddddk...',
  '....kkkkkkkk....',
  '................',
]

const CORES = {
  '.': '13261b', // fundo
  k: '0b140e', // contorno
  b: 'd9a441', // latão
  d: '9a6a22', // latão escuro
  g: '5b4a1e', // vidro
  f: 'ffb52e', // chama
  w: 'fff1b8', // centro da chama
}

const rgb = hex => [0, 2, 4].map(i => parseInt(hex.slice(i, i + 2), 16))

const TABELA_CRC = Array.from({ length: 256 }, (_, n) => {
  let c = n
  for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1
  return c >>> 0
})

function crc32(dados) {
  let c = 0xffffffff
  for (const byte of dados) c = TABELA_CRC[(c ^ byte) & 0xff] ^ (c >>> 8)
  return (c ^ 0xffffffff) >>> 0
}

function bloco(tipo, dados) {
  const tamanho = Buffer.alloc(4)
  tamanho.writeUInt32BE(dados.length)
  const corpo = Buffer.concat([Buffer.from(tipo, 'ascii'), dados])
  const crc = Buffer.alloc(4)
  crc.writeUInt32BE(crc32(corpo))
  return Buffer.concat([tamanho, corpo, crc])
}

// PNG RGB quadrado de `lado` pixels, com o desenho ampliado `escala` vezes e centralizado.
function png(lado, escala) {
  const margem = Math.floor((lado - 16 * escala) / 2)
  const fundo = rgb(CORES['.'])
  const linhas = []
  for (let y = 0; y < lado; y++) {
    const linha = Buffer.alloc(1 + lado * 3)
    for (let x = 0; x < lado; x++) {
      const px = Math.floor((x - margem) / escala)
      const py = Math.floor((y - margem) / escala)
      const dentro = x >= margem && y >= margem && px < 16 && py < 16
      const cor = dentro ? rgb(CORES[DESENHO[py][px]]) : fundo
      linha.set(cor, 1 + x * 3)
    }
    linhas.push(linha)
  }
  const cabecalho = Buffer.alloc(13)
  cabecalho.writeUInt32BE(lado, 0)
  cabecalho.writeUInt32BE(lado, 4)
  cabecalho.set([8, 2, 0, 0, 0], 8)
  return Buffer.concat([
    Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]),
    bloco('IHDR', cabecalho),
    bloco('IDAT', deflateSync(Buffer.concat(linhas), { level: 9 })),
    bloco('IEND', Buffer.alloc(0)),
  ])
}

function svg() {
  const retangulos = []
  DESENHO.forEach((linha, y) => {
    for (let x = 0; x < 16;) {
      let fim = x
      while (fim < 16 && linha[fim] === linha[x]) fim++
      if (linha[x] !== '.') {
        retangulos.push(`<rect x="${x}" y="${y}" width="${fim - x}" height="1" fill="#${CORES[linha[x]]}"/>`)
      }
      x = fim
    }
  })
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" shape-rendering="crispEdges">
<rect width="16" height="16" fill="#${CORES['.']}"/>
${retangulos.join('\n')}
</svg>
`
}

const pasta = new URL('../web/icones/', import.meta.url)
mkdirSync(pasta, { recursive: true })
writeFileSync(new URL('icone-180.png', pasta), png(180, 9))
writeFileSync(new URL('icone-192.png', pasta), png(192, 10))
writeFileSync(new URL('icone-512.png', pasta), png(512, 26))
// Ícone "maskable": o Android pode cortar até 20% da borda, então o desenho fica menor.
writeFileSync(new URL('icone-maskable-512.png', pasta), png(512, 20))
writeFileSync(new URL('icone.svg', pasta), svg())
console.log('ícones gerados em web/icones/')
