#!/bin/bash
downloads="periodika/bulletin periodika/sonder-bulletin periodika/offene-briefe periodika/zeitzeichen periodika/figu-in-bezug periodika/figu-offene-worte buecher books books/leseproben books/korrigenda figu-ratgeber schriften schriften/infoschriften schriften/kleinschriften sonstiges/sonstiges"
urlstamm="http://www.figu.org/ch/index/downloads"
verzeingang="./pdf-eingang"

for download in $downloads; do
	echo "Hole neue Dateien für $download..."
	# --no-verbose
	pdfurls=$(wget -O - --quiet $urlstamm/$download | xmllint --html --xpath "//a[contains(@href,'.pdf')]/@href" -)
	#echo $pdfurls

	for pdfurl in $pdfurls; do
		pdfurl=${pdfurl:6:-1}
		#echo $pdfurl
		#--timestamping für korrektes Erkennen neuerer Dateien, setzt aber partielle Downloads nicht fort
		#--continue für korrektes Fortsetzen, aber bei normal geänderter Datei -> korrupte Datei, weil nur der größere Abschnitt heruntergeladen wird
		# kann nur eines der beiden angeben
		# -> FIGU ändert Dokumente nicht ab -> --continue
		wget --no-verbose --directory-prefix="$verzeingang" --continue "$pdfurl"
	done
done

# Kontrolle auf halb-heruntergeladene Dateien
echo -n "Dokumente überprüfen..." && find "$verzeingang" -type f -print -exec pdfinfo \{\} >/dev/null \; && echo "OK"

echo "Fertig."
