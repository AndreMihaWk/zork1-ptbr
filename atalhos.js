// Barra de atalhos para o celular e ajustes no campo de entrada do Parchment.

// Comando que cada botão envia ao jogo. Enquanto o jogo ainda está em inglês,
// são os comandos ingleses; quando o parser em português entrar, basta trocar
// os valores aqui.
const COMANDOS = {
  norte: 'north',
  sul: 'south',
  leste: 'east',
  oeste: 'west',
  subir: 'up',
  descer: 'down',
  olhar: 'look',
  inventario: 'inventory',
  pegar: 'take ',
  abrir: 'open ',
  salvar: 'save',
  carregar: 'restore',
}

const barra = document.getElementById('atalhos')
const janela = document.getElementById('windowport')

function campoDeEntrada() {
  return janela.querySelector('textarea.LineInput:not([disabled])')
}

// Botões com "…" só escrevem o começo do comando para o jogador completar.
function enviar(texto, completar) {
  const campo = campoDeEntrada()
  if (!campo) return
  campo.value = texto
  if (completar) {
    campo.focus()
    campo.setSelectionRange(texto.length, texto.length)
    return
  }
  // O Parchment envia a linha num handler jQuery de keypress com which === 13.
  const $ = window.jQuery
  $(campo).trigger($.Event('keypress', { which: 13, keyCode: 13 }))
}

// Tocar num botão não tira o foco do campo, então o teclado virtual não abre
// nem fecha sozinho.
barra.addEventListener('pointerdown', evento => {
  if (evento.target.closest('button')) evento.preventDefault()
})

barra.addEventListener('click', evento => {
  const botao = evento.target.closest('button[data-comando]')
  if (botao) enviar(COMANDOS[botao.dataset.comando], botao.hasAttribute('data-completar'))
})

// Teclado virtual: sem corretor, sem maiúscula automática e sem sugestões.
// O Parchment recria o campo de entrada, então os atributos são reaplicados.
const ATRIBUTOS = {
  autocapitalize: 'none',
  autocomplete: 'off',
  autocorrect: 'off',
  enterkeyhint: 'send',
  spellcheck: 'false',
}

function ajustarCampos() {
  for (const campo of janela.querySelectorAll('.Input')) {
    for (const [nome, valor] of Object.entries(ATRIBUTOS)) {
      if (campo.getAttribute(nome) !== valor) campo.setAttribute(nome, valor)
    }
  }
}

new MutationObserver(ajustarCampos).observe(janela, { childList: true, subtree: true })

if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('sw.js').catch(() => {})
  })
}
