// Barra de atalhos para o celular, painel "Sobre" e ajustes no campo de
// entrada do Parchment.

// Comando que cada botão envia ao jogo.
const COMANDOS = {
  norte: 'norte',
  sul: 'sul',
  leste: 'leste',
  oeste: 'oeste',
  subir: 'suba',
  descer: 'desça',
  olhar: 'olhe',
  inventario: 'inventário',
  pegar: 'pegue ',
  abrir: 'abra ',
  salvar: 'salvar',
  carregar: 'carregar',
  desfazer: 'desfazer',
}

const barra = document.getElementById('atalhos')
const janela = document.getElementById('windowport')
const sobre = document.getElementById('sobre')

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
  if (evento.target.closest('button[data-acao="sobre"]')) sobre.showModal()
})

// Painel "Sobre": fecha pelo botão (form method="dialog"), pelo Esc ou com um
// toque fora dele. O conteúdo fica num div interno, então um clique cujo alvo
// é o próprio <dialog> só pode ter sido no fundo escurecido.
sobre.addEventListener('click', evento => {
  if (evento.target === sobre) sobre.close()
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
