#!/usr/bin/env bash
# Atualiza um cask ou formula deste tap para uma versão nova.
#
#   scripts/bump.sh <cask|formula> <name> <version>
#
# - cask:    lê o template da linha `url` do cask (com #{version}), baixa o
#            artefato, calcula o sha256 e atualiza `version` + `sha256`.
# - formula: consulta o PyPI JSON, pega a sdist (url + sha256) e atualiza
#            `url` + `sha256`. A versão do formula é derivada do nome do arquivo.
#
# Idempotente: se o arquivo já estiver na versão pedida, o resultado é o mesmo
# conteúdo (o caller decide se há o que commitar via `git diff`).
set -euo pipefail

kind="${1:?uso: bump.sh <cask|formula> <name> <version>}"
name="${2:?falta o name}"
version="${3:?falta a version}"
version="${version#v}" # tira prefixo v, se vier

# Edição in-place portável (BSD/GNU) via arquivo temporário.
sub() { # sub <file> <sed-extended-expr>
  local f="$1" expr="$2" tmp
  tmp="$(mktemp)"
  sed -E "$expr" "$f" >"$tmp" && mv "$tmp" "$f"
}

# sha256 do stdin, portável (Linux runner tem sha256sum; macOS tem shasum).
sha256() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum; else shasum -a 256; fi
}

case "$kind" in
  cask)
    file="Casks/${name}.rb"
    [ -f "$file" ] || { echo "não achei $file"; exit 1; }
    tmpl="$(sed -n -E 's/^[[:space:]]*url "([^"]+)".*/\1/p' "$file" | head -1)"
    [ -n "$tmpl" ] || { echo "não achei a linha url em $file"; exit 1; }
    dl="${tmpl//\#\{version\}/$version}"
    echo "· baixando $dl"
    sha="$(curl -fsSL "$dl" | sha256 | awk '{print $1}')"
    [ -n "$sha" ] || { echo "falhou ao calcular o sha256"; exit 1; }
    sub "$file" "s|^([[:space:]]*version )\"[^\"]*\"|\\1\"${version}\"|"
    sub "$file" "s|^([[:space:]]*sha256 )\"[^\"]*\"|\\1\"${sha}\"|"
    ;;
  formula)
    file="Formula/${name}.rb"
    [ -f "$file" ] || { echo "não achei $file"; exit 1; }
    # O publish do PyPI pode levar alguns segundos pra indexar o JSON da versão.
    meta=""
    for i in 1 2 3 4 5 6; do
      if meta="$(curl -fsSL "https://pypi.org/pypi/${name}/${version}/json" 2>/dev/null)"; then break; fi
      echo "PyPI ainda não indexou ${name} ${version} (tentativa $i)…"; sleep 15
    done
    [ -n "$meta" ] || { echo "PyPI não retornou ${name} ${version}"; exit 1; }
    url="$(echo "$meta" | jq -r '.urls[] | select(.packagetype=="sdist") | .url' | head -1)"
    sha="$(echo "$meta" | jq -r '.urls[] | select(.packagetype=="sdist") | .digests.sha256' | head -1)"
    { [ -n "$url" ] && [ "$url" != "null" ]; } || { echo "sdist não encontrada no PyPI para ${name} ${version}"; exit 1; }
    sub "$file" "s|^([[:space:]]*url )\"[^\"]*\"|\\1\"${url}\"|"
    sub "$file" "s|^([[:space:]]*sha256 )\"[^\"]*\"|\\1\"${sha}\"|"
    ;;
  *)
    echo "kind inválido: '$kind' (use cask ou formula)"; exit 1 ;;
esac

echo "· $file atualizado para ${version}"
