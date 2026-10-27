#!/usr/bin/env bash
# Compila src/zork1.zil para build/zork1-ptbr.z5 com o ZILF.
# Usa $ZILF se estiver definido; senão procura em .tools/zilf ou no PATH.
set -euo pipefail
cd "$(dirname "$0")/.."

if [[ -z "${ZILF:-}" ]]; then
  for candidato in .tools/zilf/bin/zilf .tools/zilf/bin/zilf.exe; do
    [[ -x "$candidato" ]] && ZILF="$PWD/$candidato" && break
  done
fi
ZILF="${ZILF:-zilf}"

rm -rf build
mkdir -p build
cp src/*.zil build/
(cd build && "$ZILF" zork1.zil zork1-ptbr.z5)

# Limite da Z-machine V5: 256 KB
tamanho=$(wc -c < build/zork1-ptbr.z5)
limite=262144
echo "build/zork1-ptbr.z5: $tamanho bytes ($((tamanho * 100 / limite))% do limite da V5)"
if (( tamanho > limite )); then
  echo "ERRO: o arquivo passou do limite de $limite bytes da V5" >&2
  exit 1
fi
