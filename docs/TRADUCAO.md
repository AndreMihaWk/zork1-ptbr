# Guia de tradução

Regras para traduzir o código ZIL de `src/`. Os termos fixos (nomes de lugares,
objetos e personagens) estão no [GLOSSARIO.md](../GLOSSARIO.md).

## Estilo

- **Narração em "você"**: "Você está em um campo aberto a oeste de uma casa
  branca."
- **Respostas com o objeto**: "Você pegou a lanterna." em vez de "Pegou.".
  Em listas ("pegue tudo"), o jogo escreve o nome antes: "espada: Você pegou a
  espada."
- **Termos clássicos ficam como no original**: grue, zorkmid, Frobozz,
  Dungeon Master, Flathead, Zork. O resto é traduzido, inclusive trocadilhos,
  adaptados quando a tradução literal perde a graça.
- **Português do Brasil**, tom igual ao do original: irônico e direto.

## Comandos que o jogador pode digitar

- Verbos em qualquer forma comum: imperativo (pegue), infinitivo (pegar) ou
  3ª pessoa (pega).
- Com ou sem acento, em maiúsculas ou minúsculas: `LÂMPADA` = `lampada`.
- Artigos e contrações: `coloque o ovo na caixa`, `tire a moeda do saco`,
  `dê o lanche ao ciclope`.
- Adjetivo antes ou depois do nome: `pequena caixa`, `caixa pequena`.
- Pronomes: `pegue-o`, `abra-a`, `examine isso`, `largue ele`.
- Direções: `norte`/`n`, `sul`/`s`, `leste`/`l`, `oeste`/`o`, `nordeste`/`ne`,
  `noroeste`/`no`, `sudeste`/`se`, `sudoeste`/`so`, `cima`/`c`/`suba`,
  `baixo`/`b`/`desça`. As abreviações do jogo original (`e`, `w`, `u`, `d`,
  `nw`, `sw`) também valem. `o` e `no` só são direção sozinhos, porque no meio
  da frase são artigo e preposição. Frases também funcionam:
  `vá para o norte`.
- `tudo`, `exceto`, `e` (conjunção), `depois` (encadear comandos), `de novo`
  (`g`), `ops` (corrigir a última palavra).

## Regras técnicas

### Vocabulário (SYNONYM e ADJECTIVE)

- **Sem acento** e em maiúsculas: `LAMPADA`, `ALCAPAO`. A entrada do jogador
  perde os acentos antes da leitura (`NORMALIZA-ENTRADA` em
  `src/pt-parser.zil`).
- O dicionário guarda **9 letras**: `INVENTARIO` e `INVENTARI` são a mesma
  palavra.
- Inclua **singular e plural** quando fizer sentido: `VELA VELAS`.
- **Nome composto com "de"** (caixa de correio, lanterna de latão): o núcleo
  vai em `SYNONYM` e o complemento em `ADJECTIVE`
  (`(SYNONYM CAIXA) (ADJECTIVE CORREIO PEQUENA)`). Quando o "de" vem antes de
  um adjetivo, o parser o descarta (`AJUSTA-LEXV`). Quando vem antes de um
  substantivo, ele vira a preposição "de" (`tire a moeda do saco`). Por isso,
  um complemento de nome **não pode** ser substantivo de outro objeto que
  costuma ser alvo de "de".
- Quando o complemento também serve sozinho (`pegue o alho`, `pegue as
  folhas`), ele entra **nas duas listas**: `(SYNONYM ALHO DENTE)
  (ADJECTIVE ALHO)`. Assim `dente de alho` e `alho` funcionam.
- Construções do português que o inglês não tem (`entre pela janela`,
  `suba na árvore`) ganham `SYNTAX` própria no fim de `src/gsyntax.zil`.
  "Pela/pelo" valem como `WITH`.
- Adjetivos com flexão de gênero: use a forma que concorda com o objeto
  (`ESPADA` → `ELFICA`).
- Verbos novos entram como `SYNONYM` do verbo original em `src/gsyntax.zil`.
  Só crie `SYNTAX` nova quando o português precisa de uma construção que o
  inglês não tem.
- **Nada de palavras inglesas** no vocabulário. As que o código ainda usa
  por dentro (os verbos e as preposições das `SYNTAX`, as direções por
  extenso, `W?ALL`, `W?IT`...) estão na tabela `INGLESAS` de
  `src/pt-parser.zil` e valem como palavra desconhecida quando digitadas. Se
  uma palavra da tabela também for português (como `examine`, `move` e
  `come`), ela não pode estar lá.
- Palavras que o parser compara por endereço (`W?ALL`, `W?IT`, `W?THEN`...)
  não funcionam como `SYNONYM`. Elas entram na tabela `EQUIVALENTES` de
  `src/pt-parser.zil`.

### Gênero e artigos

- `DESC` sem artigo e em minúsculas: `(DESC "lanterna de latão")`.
- Marque o gênero e o número nas `FLAGS`: `FEMBIT` (feminino), `PLURALBIT`
  (plural), `SEMARTIGOBIT` (nome próprio, sem artigo), `PARTITIVOBIT` (o que
  não se conta: com `(DESC "água")`, `T-UM` escreve "um pouco de água").
- Verbo que concorda com o objeto, fora de "estar" e "ser": escreva a forma
  com `PRINT-PLURAL` entre dois `TELL`:
  `<TELL T-CO ,PRSO " "> <PRINT-PLURAL ,PRSO "cai" "caem"> <TELL " no chão." CR>`.
- Nas mensagens, use os marcadores do `TELL`, que escrevem o artigo certo:

| Marcador | Masculino | Feminino | Plural (fem.) |
|---|---|---|---|
| `T-O ,obj` / `T-CO ,obj` | o lampião / O lampião | a lanterna | as velas |
| `T-UM ,obj` / `T-CUM ,obj` | um lampião | uma lanterna | umas velas |
| `T-DO ,obj` | do lampião | da lanterna | das velas |
| `T-NO ,obj` | no lampião | na lanterna | nas velas |
| `T-AO ,obj` | ao lampião | à lanterna | às velas |
| `T-PELO ,obj` | pelo lampião | pela lanterna | pelas velas |
| `T-G ,obj` (terminação) | o | a | as |
| `T-ELE ,obj` / `T-CELE ,obj` | ele | ela | elas |
| `T-SEU ,obj` / `T-CSEU ,obj` | seu lampião / Seu lampião | sua lanterna | suas velas |
| `T-ESTA ,obj` / `T-SER ,obj` | está / é | está / é | estão / são |

Exemplo: `<TELL T-CO ,PRSO " já " T-ESTA ,PRSO " fechad" T-G ,PRSO "." CR>`
escreve "A caixa já está fechada." ou "Os sapatos já estão fechados.".

### Texto

- **Caracteres permitidos**: ASCII e os acentos da tabela padrão da
  Z-machine (á é í ó ú â ê ô ã õ à ç ü e maiúsculas). **Proibidos**: aspas
  curvas “ ” ‘ ’, travessão —, reticências …, º e ª. Use aspas retas `\"`,
  hífen `-`, três pontos `...` e `n.` ou `#`. O detector
  (`tools/check-strings.mjs`) bloqueia os proibidos, porque eles mudariam a
  tabela de caracteres do jogo e quebrariam a leitura dos acentos digitados.
- **Tabelas de mensagens aleatórias** (`PICK-ONE`, `LTABLE`) mantêm **o mesmo
  número de entradas** do original. O teste do roteiro completo usa
  aleatoriedade previsível, e uma tabela de outro tamanho muda os sorteios
  seguintes.
- **Não mude a lógica do jogo** junto com a tradução. Se algo precisar mudar,
  faça em um commit separado e explique.

## Fluxo de trabalho

1. Uma branch e um Pull Request por lote (por região do mapa, na Fase 3).
2. Traduza o texto e o vocabulário do lote. Migre para português os comandos
   do trecho correspondente em `tests/walkthrough.txt`.
3. Rode `bash tools/build.sh`, `bash tools/run-walkthrough.sh --atualizar` e
   `bash tools/run-walkthrough.sh tests/smoke-pt.txt --atualizar`. Confira o
   diff das transcrições: ele mostra o texto novo como o jogador vai ver.
4. Com o CI verde, o PR é mesclado. O preview do PR fica em
   `https://andremihawk.github.io/zork1-ptbr/pr-preview/pr-<número>/`.

### Mensagens de combate

As mensagens de luta (`HERO-MELEE`, `TROLL-MELEE`, `THIEF-MELEE`,
`CYCLOPS-MELEE` em `src/1actions.zil`) são listas de pedaços que a rotina
`REMARK` junta. `F-WEP` e `F-DEF` escrevem só o nome da arma e do defensor;
para a concordância, use os marcadores com artigo:

| Marcador | Escreve |
|---|---|
| `F-O-WEP` / `F-CO-WEP` / `F-DO-WEP` | a espada / A espada / da espada |
| `F-SEU-WEP` / `F-CSEU-WEP` | sua espada / Sua espada (seu estilete) |
| `F-O-DEF` / `F-CO-DEF` | o troll / O troll |
| `F-DO-DEF` / `F-NO-DEF` / `F-AO-DEF` | do troll / no troll / ao troll |

Exemplo: `<LTABLE (PURE) F-CSEU-WEP " erra " F-O-DEF " por um triz.">`.
Cada grupo de mensagens mantém o mesmo número de mensagens do original (o
sorteio escolhe uma delas).
