#!/usr/bin/zsh

if  [[ $# -ne 2 ]]
then 
    echo "Deux arguments attendus: <dossier> <langue>"
    exit
fi


dossier=$1
langue_abr=$2     # en, fr, ru, pl, it, jp, etc ......

echo "<lang=\"$langue_abr\">" > contexte.txt
     # dossier c'est dumptext    "itrameur/$contexte-$lang.txt" 

for filepath in $(ls -Utr $dossier/$langue_abr-*.txt)
do
    # filepath == dumps-text/fr-1.txt
    #  == > pagename =fr-1
    echo "$filepath"
    pagename="$(basename -s .txt $filepath)"  #ch-1
    echo "<page=\"$pagename\">" >> contexte.txt
    echo "<text>"  >> contexte.txt

    #on récupère les dumps ou contextes
    # et on écrit à l'intérieur de la base text
    content=$(cat $filepath)
    # ordre important : & en premier
    # sinon : < => &lt ; => &amp;lt: 
    content=$(echo "$content" | sed 's/&/&amp;/g')
    content=$(echo "$content" | sed 's/</&lt;/g')
    content=$(echo "$content" | sed 's/>/&gt;/g')  #on fait deux groupes
    echo "$content" >> contexte.txt
    echo "</text>" >> contexte.txt
    echo "</page> §" >> contexte.txt
done

echo "</lang>" >> contexte.txt