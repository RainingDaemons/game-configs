#!/usr/bin/env bash
# Download Quake Live map preview images.
#
# Reads extra_pages/quakelive/maps.txt, where each line is: map|gametype|id
#   - id == 0       : vanilla map -> download from http://epsy46.free.fr/qlmaps/levelshots/<map>.jpg
#   - id == <number>: Steam Workshop item -> download its first preview image
# Images are saved to extra_pages/quakelive/images/<map>.jpg

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAPS_FILE="${SCRIPT_DIR}/extra_pages/quakelive/maps.txt"
IMAGES_DIR="${SCRIPT_DIR}/extra_pages/quakelive/images"

VANILLA_URL="http://epsy46.free.fr/qlmaps/levelshots"
WORKSHOP_URL="https://steamcommunity.com/sharedfiles/filedetails"
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Safari/537.36"

mkdir -p "${IMAGES_DIR}"

download_image() {
    local map="$1" url="$2" out="$3"
    if curl -fsSL -A "${UA}" -o "${out}" "${url}"; then
        echo "[+] ${map} -> ${out}"
    else
        echo "[-] ${map}: download failed (${url})" >&2
        rm -f "${out}"
    fi
}

while IFS='|' read -r map gametype wid || [ -n "${map}" ]; do
    map="${map%$'\r'}"
    wid="${wid%$'\r'}"
    [ -z "${map}" ] && continue

    out="${IMAGES_DIR}/${map}.jpg"

    if [ "${wid}" = "0" ]; then
        download_image "${map}" "${VANILLA_URL}/${map}.jpg" "${out}"
    else
        html="$(curl -sSL -A "${UA}" "${WORKSHOP_URL}/?id=${wid}")" || {
            echo "[-] ${map}: failed to fetch workshop page (id ${wid})" >&2
            continue
        }
        url="$(printf '%s' "${html}" \
            | sed -n 's/.*property="og:image" content="\([^"]*\)".*/\1/p' \
            | head -n1 \
            | sed 's/&amp;/\&/g')"
        if [ -z "${url}" ]; then
            echo "[-] ${map}: no preview image found (id ${wid})" >&2
            continue
        fi
        download_image "${map}" "${url}" "${out}"
    fi
done < "${MAPS_FILE}"
