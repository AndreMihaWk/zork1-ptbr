# Zork I em português (tradução não oficial)

Tradução para o português do Brasil de **Zork I: The Great Underground Empire**
(Infocom, 1980), feita a partir do código-fonte original em ZIL que a Microsoft
liberou sob licença MIT em novembro de 2025. Dá para jogar no navegador do
celular ou do computador, e o jogo pode ser instalado como aplicativo (PWA)
para funcionar offline.

> **Status:** em andamento. Por enquanto o jogo ainda está em inglês. A
> tradução entra por região do mapa, um Pull Request por vez.

## Como jogar

- **No navegador:** abra o link do GitHub Pages deste repositório.
- **Em um app de ficção interativa:** baixe o arquivo `.z5` da página de
  [Releases](../../releases) e abra-o em um interpretador Z-machine, como
  Fabularium ou Frotz no Android, ou Gargoyle no computador.

Os comandos serão digitados em português, com ou sem acento. Exemplos:
`norte` (ou `n`), `pegue a lâmpada`, `abra a caixa de correio`, `inventário`
(ou `i`).

## Como compilar localmente

Você precisa do [ZILF](https://github.com/taradinoc/zilf/releases) 1.9 e,
para rodar os testes, do `dfrotz` (pacote `frotz` no Ubuntu/WSL).

```bash
bash tools/build.sh              # gera build/zork1-ptbr.z5
bash tools/run-walkthrough.sh    # joga o roteiro completo e confere os 350 pontos
```

## Estrutura

| Pasta | Conteúdo |
|---|---|
| `original/` | Código ZIL original, intacto (referência) |
| `src/` | Código ZIL que é compilado (porte para Z-machine V5 + tradução) |
| `tests/` | Roteiro completo (walkthrough) e testes do parser |
| `tools/` | Scripts de compilação, teste e montagem do site |
| `web/` | Página do jogo (Parchment), barra de atalhos e PWA |
| `.github/workflows/` | CI/CD: compilação, testes, GitHub Pages, previews e releases |

## Créditos

- **Zork I** foi criado por Marc Blank, Dave Lebling, Bruce Daniels e Tim
  Anderson e publicado pela Infocom. O código-fonte foi liberado pela Microsoft
  sob licença MIT ([historicalsource/zork1](https://github.com/historicalsource/zork1)).
- O compilador é o [ZILF](https://foss.heptapod.net/zilf/zilf), de Tara McGrew.
  O roteiro de testes foi adaptado da suíte de testes do ZILF.
- O jogo roda no navegador com o [Parchment](https://github.com/curiousdannii/parchment),
  de Dannii Willis.

"Zork" é marca registrada de seus respectivos donos. Este projeto não tem
afiliação com a Microsoft, a Activision ou a Infocom.
