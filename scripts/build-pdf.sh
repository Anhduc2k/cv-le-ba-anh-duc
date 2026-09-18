#!/usr/bin/env bash
# Regenerate the downloadable CVs.
#
# Renders straight from file:// — no local server needed; Chrome loads the
# stylesheet, the self-hosted Inter subsets and the portrait from disk.
# --no-pdf-header-footer is the whole point: it skips the print dialog, so
# the output never carries the date / tab-title / URL that Chrome stamps
# into the page margins when you print by hand.

set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

chrome=""
for c in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Chromium.app/Contents/MacOS/Chromium" \
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
  "$(command -v google-chrome 2>/dev/null || true)" \
  "$(command -v chromium 2>/dev/null || true)"
do
  [ -n "$c" ] && [ -x "$c" ] && { chrome="$c"; break; }
done

if [ -z "$chrome" ]; then
  echo "Khong tim thay Chrome/Chromium/Edge. Cai mot trinh duyet Chromium roi chay lai." >&2
  exit 1
fi

render() {  # render <source.html> <output.pdf>
  "$chrome" --headless=new --disable-gpu --no-pdf-header-footer \
    --print-to-pdf="$root/$2" "file://$root/$1" 2>/dev/null
  python3 - "$root/$2" <<'PY'
import re, sys, os
path = sys.argv[1]
data = open(path, 'rb').read()
pages = len(re.findall(rb'/Type\s*/Page[^s]', data))
print("  %-26s %d trang, %d KB" % (os.path.basename(path), pages, os.path.getsize(path) // 1024))
PY
}

echo "Xuat PDF tu $root"
render index.html CV-Le-Ba-Anh-Duc-EN.pdf
render vi.html    CV-Le-Ba-Anh-Duc-VI.pdf
echo "Xong. Nho commit ca file .pdf, neu khong nut Download tren ban live se 404."
