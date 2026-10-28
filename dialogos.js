// Traduz os diálogos do Parchment (salvar, carregar, baixar e importar saves),
// que vêm em inglês. Os diálogos são componentes Svelte acrescentados ao
// <body>; aqui só trocamos o texto dos nós, sem mexer na estrutura, então o
// Parchment continua funcionando igual. Um texto que não estiver na lista
// (numa versão nova do Parchment, por exemplo) só fica em inglês.

const TEXTOS = {
  'Save a savefile': 'Salvar o jogo',
  'Open a savefile': 'Carregar um jogo salvo',
  'Save a log': 'Salvar a transcrição',
  'Open a log': 'Abrir uma transcrição',
  'Save a data file': 'Salvar um arquivo de dados',
  'Open a data file': 'Abrir um arquivo de dados',
  'Add file': 'Importar',
  'New Folder': 'Nova pasta',
  'New folder': 'Nova pasta',
  'My files': 'Meus arquivos',
  'Download': 'Baixar',
  'Rename': 'Renomear',
  'Delete': 'Apagar',
  'Open': 'Abrir',
  'Save': 'Salvar',
  'Cancel': 'Cancelar',
  'Ok': 'OK',
  'Last modified:': 'Modificado em:',
  'File name:': 'Nome:',
  'File type:': 'Tipo:',
  'Save file': 'Jogo salvo',
  'Data file': 'Arquivo de dados',
  'Transcript or log': 'Transcrição',
  'All files': 'Todos',
  'Overwrite file': 'Substituir arquivo',
  'Delete file': 'Apagar arquivo',
  'Rename file': 'Renomear arquivo',
  'Rename folder': 'Renomear pasta',
  'Enter new file name': 'Novo nome do arquivo',
  'Enter new folder name': 'Nome da pasta',
  'Cannot save': 'Não foi possível salvar',
  'Cannot open': 'Não foi possível abrir',
  'localStorage full': 'Armazenamento cheio',
  'Note: Files saved in this browser may be lost by clearing cookies, or depending on your browser settings.':
    'Atenção: o navegador pode apagar os saves ao limpar os cookies ou conforme as configurações dele. Use Baixar para guardar uma cópia.',
  'Warning: Files saved in this browser will be lost if you don\'t visit again within a week.':
    'Atenção: este navegador apaga os saves se você ficar uma semana sem abrir o jogo. Use Baixar para guardar uma cópia.',
  'Parchment could not find a valid storage method in this browser.':
    'O Parchment não encontrou onde guardar arquivos neste navegador.',
  'LocalStorage is not currently supported in this browser. You should be able to enable it in your browser settings; it may be under a setting about cookies.':
    'Este navegador não permite guardar arquivos. Dá para liberar nas configurações dele, provavelmente nas opções de cookies.',
}

// Data do arquivo, no formato de Date.toDateString() ("Tue Oct 27 2026").
const DATA = /^[A-Z][a-z]{2} [A-Z][a-z]{2} \d{2} \d{4}$/

function traduzirData(data) {
  const quando = new Date(data)
  return Number.isNaN(quando.getTime()) ? data : quando.toLocaleDateString('pt-BR')
}

// Textos com uma parte variável (nome de arquivo, data).
const PADROES = [
  [/^Are you sure you want to overwrite (.+)\?$/s, (_, nome) => `Substituir ${nome}?`],
  [/^Are you sure you want to delete the folder (.+)\?$/s, (_, nome) => `Apagar a pasta ${nome}?`],
  [/^Are you sure you want to delete (.+)\?$/s, (_, nome) => `Apagar ${nome}?`],
  [/^The file (.+) could not be written as your browser's localStorage is full! Please delete some files, and then try again\.$/s,
    (_, nome) => `Não foi possível gravar ${nome}: o armazenamento do navegador está cheio. Apague alguns arquivos e tente de novo.`],
  [/^Last modified: (.+)$/s, (_, data) => `Modificado em: ${traduzirData(data)}`],
  [DATA, traduzirData],
]

const ROTULOS = { Close: 'Fechar' }

function traduzirTexto(texto) {
  const [, antes, miolo, depois] = /^(\s*)(.*?)(\s*)$/s.exec(texto)
  if (!miolo) return texto
  let traduzido = TEXTOS[miolo]
  if (traduzido === undefined) {
    for (const [padrao, troca] of PADROES) {
      if (padrao.test(miolo)) {
        traduzido = miolo.replace(padrao, troca)
        break
      }
    }
  }
  return traduzido === undefined ? texto : antes + traduzido + depois
}

function traduzirNo(no) {
  if (no.nodeType === Node.TEXT_NODE) {
    // Nome de arquivo ou de pasta fica como está, mesmo que seja "Save".
    if (no.parentElement?.closest('.name, #dirtree span:not(:first-child)')) return
    const traduzido = traduzirTexto(no.data)
    if (traduzido !== no.data) no.data = traduzido
    return
  }
  if (no.nodeType !== Node.ELEMENT_NODE) return
  for (const elemento of [no, ...no.querySelectorAll('[aria-label]')]) {
    const rotulo = ROTULOS[elemento.getAttribute('aria-label')]
    if (rotulo) elemento.setAttribute('aria-label', rotulo)
  }
  const nos = document.createTreeWalker(no, NodeFilter.SHOW_TEXT)
  while (nos.nextNode()) traduzirNo(nos.currentNode)
}

// Cada diálogo ganha um observador próprio, para pegar o texto que o Svelte
// troca depois (o título muda entre salvar e carregar, a lista de arquivos é
// refeita etc.). Trocar o texto de novo não entra em laço: o texto traduzido
// não está na lista.
const observados = new WeakSet()

function observarDialogo(dialogo) {
  if (observados.has(dialogo)) return
  observados.add(dialogo)
  traduzirNo(dialogo)
  new MutationObserver(mudancas => {
    for (const mudanca of mudancas) {
      if (mudanca.type === 'characterData' || mudanca.type === 'attributes') traduzirNo(mudanca.target)
      else mudanca.addedNodes.forEach(traduzirNo)
    }
  }).observe(dialogo, {
    attributeFilter: ['aria-label'],
    characterData: true,
    childList: true,
    subtree: true,
  })
}

function procurarDialogos() {
  for (const dialogo of document.querySelectorAll('body > .asyncglk_ui')) observarDialogo(dialogo)
}

procurarDialogos()
new MutationObserver(procurarDialogos).observe(document.body, { childList: true })
