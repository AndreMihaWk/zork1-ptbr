// Service worker: guarda o jogo no aparelho para jogar sem internet.
// 4da43ab é trocado pelo commit no build (tools/build-site.mjs), então cada
// publicação cria um cache novo e apaga os antigos. Os caches são do domínio
// inteiro (inclusive dos previews de PR), por isso o nome leva o escopo.
const PREFIXO = `zork1-ptbr ${self.registration.scope} `
const CACHE = `${PREFIXO}4da43ab`

const ARQUIVOS = [
  './',
  'index.html',
  'estilo.css',
  'atalhos.js',
  'manifest.webmanifest',
  'interpreter/zork1-ptbr.z5.js',
  'interpreter/parchment.css',
  'interpreter/parchment.js',
  'interpreter/jquery.min.js',
  'interpreter/bocfel-noz6.js',
  'icones/icone.svg',
  'icones/icone-180.png',
  'icones/icone-192.png',
  'icones/icone-512.png',
]

self.addEventListener('install', evento => {
  evento.waitUntil(
    caches.open(CACHE).then(cache => cache.addAll(ARQUIVOS)).then(() => self.skipWaiting()),
  )
})

self.addEventListener('activate', evento => {
  evento.waitUntil(
    caches.keys()
      .then(nomes => Promise.all(
        nomes.filter(nome => nome.startsWith(PREFIXO) && nome !== CACHE)
          .map(nome => caches.delete(nome)),
      ))
      .then(() => self.clients.claim()),
  )
})

// Primeiro o cache; o que não estiver lá vem da rede e é guardado.
// Os previews de Pull Request têm o próprio service worker e ficam de fora.
self.addEventListener('fetch', evento => {
  const url = new URL(evento.request.url)
  if (evento.request.method !== 'GET' || url.origin !== self.location.origin) return
  if (url.pathname.includes('/pr-preview/') && !self.location.pathname.includes('/pr-preview/')) return

  evento.respondWith(
    caches.match(evento.request, { ignoreSearch: true }).then(resposta => resposta ||
      fetch(evento.request).then(daRede => {
        if (daRede.ok) {
          const copia = daRede.clone()
          caches.open(CACHE).then(cache => cache.put(evento.request, copia))
        }
        return daRede
      })),
  )
})
