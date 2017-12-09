#!/bin/bash
verzindex="./pdf-index"

# --ignore-case kann nützlich sein, bringt aber viele falsch-positive Ergebnisse herein, z.B. bei der Suche nach "Atlantis"
#cd $verzindex && grep --with-filename --text --ignore-case --color=auto $@ *
cd $verzindex && grep --with-filename --text --color=auto $@ *
