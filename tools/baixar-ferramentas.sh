#!/usr/bin/env bash
# Baixa as versões fixadas do ZILF e do Parchment em .tools/, conferindo o
# SHA-256 de cada arquivo. Funciona no Linux (CI) e no Git Bash do Windows.
set -euo pipefail
cd "$(dirname "$0")/.."

ZILF_VERSAO=1.9
PARCHMENT_VERSAO=2026.8.23
PARCHMENT_ARQUIVO=parchment-for-inform7-2026-08-23.zip
PARCHMENT_SHA256=535ab48a30414270d84bec58c7ab8733732e2d5a1bf15730ab637a074d7116a9

case "$(uname -s)" in
  Linux)
    ZILF_ARQUIVO=zilf-1.9.0-linux-x64.tar.gz
    ZILF_SHA256=06ff0e59eff6e6896fd9ce71d16c100365abbc537cf030f2bd31beb9384d0155
    ;;
  MINGW* | MSYS* | CYGWIN*)
    ZILF_ARQUIVO=zilf-1.9.0-win-x64.zip
    ZILF_SHA256=664b1e84a94def0ef67d5007e3a94ce720d546919d24cd5a19fc08d619a157a1
    ;;
  *)
    echo "Sistema não suportado: $(uname -s)" >&2
    exit 1
    ;;
esac

mkdir -p .tools

baixar() { # url arquivo sha256
  if [[ ! -f ".tools/$2" ]]; then
    curl -fsSL -o ".tools/$2" "$1"
  fi
  echo "$3  .tools/$2" | sha256sum -c --quiet
}

if [[ ! -x .tools/zilf/bin/zilf && ! -x .tools/zilf/bin/zilf.exe ]]; then
  baixar "https://github.com/taradinoc/zilf/releases/download/$ZILF_VERSAO/$ZILF_ARQUIVO" \
    "$ZILF_ARQUIVO" "$ZILF_SHA256"
  rm -rf .tools/zilf && mkdir -p .tools/zilf
  case "$ZILF_ARQUIVO" in
    *.zip) unzip -q ".tools/$ZILF_ARQUIVO" -d .tools/zilf ;;
    *) tar -xzf ".tools/$ZILF_ARQUIVO" -C .tools/zilf --strip-components=1 ;;
  esac
fi

if [[ ! -f .tools/parchment/Parchment/parchment.js ]]; then
  baixar "https://github.com/curiousdannii/parchment/releases/download/$PARCHMENT_VERSAO/$PARCHMENT_ARQUIVO" \
    "$PARCHMENT_ARQUIVO" "$PARCHMENT_SHA256"
  rm -rf .tools/parchment && mkdir -p .tools/parchment
  unzip -q ".tools/$PARCHMENT_ARQUIVO" -d .tools/parchment
fi

echo "Ferramentas prontas em .tools/ (ZILF $ZILF_VERSAO, Parchment $PARCHMENT_VERSAO)"
