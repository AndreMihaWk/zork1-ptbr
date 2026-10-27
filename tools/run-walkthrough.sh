#!/usr/bin/env bash
# Joga um roteiro de comandos no jogo compilado e compara a transcrição com
# a referência salva no repositório.
#
# Uso: tools/run-walkthrough.sh [roteiro] [--atualizar]
#   roteiro      padrão: tests/walkthrough.txt
#   --atualizar  grava a transcrição nova como referência em vez de comparar
#
# A referência fica ao lado do roteiro, com extensão .transcricao.txt.
# Para o roteiro completo, também exige a pontuação máxima.
set -euo pipefail
cd "$(dirname "$0")/.."

roteiro=tests/walkthrough.txt
atualizar=false
for arg in "$@"; do
  case "$arg" in
    --atualizar) atualizar=true ;;
    *) roteiro="$arg" ;;
  esac
done

historia=build/zork1-ptbr.z5
referencia="${roteiro%.txt}.transcricao.txt"
saida="build/$(basename "${roteiro%.txt}").transcricao.txt"

[[ -f "$historia" ]] || { echo "ERRO: $historia não existe; rode tools/build.sh antes" >&2; exit 1; }

dotnet build tools/zrunner -c Release -nologo -v q > /dev/null
# O número de série é a data da compilação; zera para a comparação ser estável.
dotnet tools/zrunner/bin/Release/net9.0/zrunner.dll "$historia" "$roteiro" \
  | sed -E 's/([Ss]erial number|[Nn]úmero de série) [0-9]{6}/\1 000000/' > "$saida"

if [[ "$roteiro" == tests/walkthrough.txt ]] &&
   ! grep -qE "(Your score is|Sua pontuação é de) 350 " "$saida"; then
  echo "ERRO: o roteiro completo não chegou aos 350 pontos. Final da transcrição:" >&2
  tail -n 25 "$saida" >&2
  exit 1
fi

if $atualizar; then
  cp "$saida" "$referencia"
  echo "Referência atualizada: $referencia"
elif [[ -f "$referencia" ]]; then
  if ! diff -u "$referencia" "$saida" > build/transcricao.diff; then
    echo "ERRO: a transcrição mudou em relação a $referencia" >&2
    head -n 80 build/transcricao.diff >&2
    echo "Se a mudança for esperada, rode: bash tools/run-walkthrough.sh $roteiro --atualizar" >&2
    exit 1
  fi
  echo "OK: $roteiro bate com $referencia"
else
  echo "ERRO: falta a referência $referencia (rode com --atualizar)" >&2
  exit 1
fi
