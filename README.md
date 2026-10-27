# Zork I em português (tradução não oficial)

Tradução para o português do Brasil de **Zork I: The Great Underground Empire**
(Infocom, 1980), feita a partir do código-fonte original em ZIL que a Microsoft
liberou sob licença MIT em novembro de 2025. Dá para jogar no navegador do
celular ou do computador, e o jogo pode ser instalado como aplicativo (PWA)
para funcionar offline.

> **Status:** em andamento. O jogo já entende comandos em português
> (`pegue a lanterna`, `abra a caixa de correio`, `vá para o norte`), mas os
> textos ainda estão em inglês. A tradução entra aos poucos, um Pull Request
> por vez. Veja o [glossário](GLOSSARIO.md) e o
> [guia de tradução](docs/TRADUCAO.md).

## Como jogar

- **No navegador:** abra o link do GitHub Pages deste repositório. No celular,
  use "Adicionar à tela inicial" para instalar e jogar sem internet.
- **Em um app de ficção interativa:** baixe o arquivo `.z5` da página de
  [Releases](../../releases) e abra-o em um interpretador Z-machine, como
  Fabularium ou Frotz no Android, ou Gargoyle no computador.

A barra de atalhos embaixo da tela tem as direções e os comandos mais usados.
Os botões com "…" só começam o comando, para você completar (por exemplo,
"Pegar…" e depois o nome do objeto).

**Salvar o jogo:** use o botão **Salvar** (ou o comando correspondente) e dê um
nome ao arquivo. Para continuar depois, use **Carregar**. Os saves ficam no
navegador. No diálogo de arquivos, **Download** baixa um save para guardar ou
passar para outro aparelho, e **Add file** importa um save baixado.

## Desenvolvimento

Ferramentas: Git, Bash (Git Bash no Windows), Node.js 22 e .NET 9 SDK. O
compilador [ZILF](https://github.com/taradinoc/zilf/releases) e o
[Parchment](https://github.com/curiousdannii/parchment) são baixados, em
versões fixas, pelo próprio script.

```bash
bash tools/baixar-ferramentas.sh   # ZILF 1.9 e Parchment em .tools/
bash tools/build.sh                # compila src/ em build/zork1-ptbr.z5
bash tools/run-walkthrough.sh      # joga o roteiro completo e confere a transcrição
node tools/check-strings.mjs       # mostra quanto do texto já foi traduzido
node tools/build-site.mjs          # monta o site em _site/
npm ci && node tools/testar-site.mjs   # testa o site num navegador de celular
```

No Windows, o teste do site pode usar o Edge instalado em vez de baixar o
Chromium: `NAVEGADOR_CANAL=msedge node tools/testar-site.mjs`.

### Testes

- **Parser em português:** `tests/smoke-pt.txt` testa artigos, contrações,
  pronomes com hífen, acentos, abreviações e frases como `vá para o norte`.
- **Roteiro completo:** `tests/walkthrough.txt` joga o jogo inteiro até os 350
  pontos, com aleatoriedade previsível (o mesmo modo da suíte de testes do
  ZILF). A saída é comparada com `tests/walkthrough.transcricao.txt`. Quando
  um texto do jogo muda de propósito (numa tradução, por exemplo), rode
  `bash tools/run-walkthrough.sh --atualizar` e confira o diff da transcrição
  no Pull Request: ele mostra exatamente o que mudou na tela do jogador.
- **Detector de texto em inglês:** `tools/check-strings.mjs` compara os textos
  de `src/` com os de `original/` e mostra o progresso da tradução no resumo
  de cada execução do CI.
- **Site:** `tools/testar-site.mjs` abre o site num navegador simulando um
  celular e confere o jogo, a barra de atalhos, o teclado virtual e o modo
  offline.

### CI/CD (GitHub Actions)

| Workflow | Quando roda | O que faz |
|---|---|---|
| `ci.yml` | chamado pelos outros | compila, roda os testes e monta o site |
| `pull-request.yml` | em cada Pull Request | CI + preview jogável em `…/pr-preview/pr-<número>/`, com o link comentado no PR |
| `publicar.yml` | push na `main` | CI + publica o site na branch `gh-pages` (GitHub Pages) |
| `release.yml` | tag `v*` | CI + cria uma Release com o `.z5` e a transcrição |

Para lançar uma versão: `git tag v0.1.0 && git push --tags`.

## Estrutura

| Pasta | Conteúdo |
|---|---|
| `original/` | Código ZIL original, intacto (referência) |
| `src/` | Código ZIL que é compilado: porte para Z-machine V5 (mudanças marcadas com `V5:`) e tradução |
| `tests/` | Roteiro completo, teste do parser em português e as transcrições de referência |
| `docs/` | Guia de tradução |
| `tools/` | Scripts de compilação, teste e montagem do site; `zrunner` é o executor de testes |
| `web/` | Página do jogo (Parchment), barra de atalhos e PWA |
| `.github/workflows/` | CI/CD |

## Pendências conhecidas

- O autosave do Parchment (continuar de onde parou ao reabrir) não está
  funcionando com o interpretador Bocfel. Por enquanto, use Salvar/Carregar.
- O diálogo de arquivos do Parchment está em inglês.

## Créditos

- **Zork I** foi criado por Marc Blank, Dave Lebling, Bruce Daniels e Tim
  Anderson e publicado pela Infocom. O código-fonte foi liberado pela Microsoft
  sob licença MIT ([historicalsource/zork1](https://github.com/historicalsource/zork1)).
- O compilador é o [ZILF](https://foss.heptapod.net/zilf/zilf), de Tara McGrew.
  O roteiro de testes foi adaptado da suíte de testes do ZILF, e os testes
  rodam no interpretador [ZLR](https://foss.heptapod.net/zilf/zlr).
- O jogo roda no navegador com o [Parchment](https://github.com/curiousdannii/parchment),
  de Dannii Willis.

"Zork" é marca registrada de seus respectivos donos. Este projeto não tem
afiliação com a Microsoft, a Activision ou a Infocom.
