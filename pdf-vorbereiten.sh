#!/bin/bash
verzeingang="./pdf-eingang"
verzindex="./pdf-index"
# Anmerkung: Dateiname ist schwer steuerbar mit "find -exec"-Lösung, auch mit "find|xargs"-Lösung -> bräuchte find und darüber eine bash-Schleife
echo -n "Extrahiere Text aus PDF-Dokumenten..." && cd "$verzeingang" && find -type f -iname "*.pdf" -print -exec pdftotext -enc UTF-8 -nopgbrk \{\} ../$verzindex/\{\}.txt \; && echo "OK"
