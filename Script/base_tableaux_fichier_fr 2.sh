#!/usr/bin/env bash

#===============================================================================
# Ce script traite mes URLs et ensuite, crée un tableau HTML avec chacun des URLs en sortie. J'utilise ce script dans le terminal afin de créer mon tableau.html. Pour mes URLs anglais, je vérifie bien de mettre "en" dans les lignes 78 à 81 pour que ces fichiers apparaissent dans le fichier anglais et non ceux de mes camarades. Voici la ligne de commande : 
# bash base_tableaux_fichier_en.sh fichier_urls fichier_tableau.html
#==============================================================================

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie

if [[ $# -ne 2 ]]
then
	echo "Ce programme demande exactement deux arguments."
	exit
fi

mot="discrimination raciale" # à modifier

echo $fichier_urls;
basename=$(basename -s .txt $fichier_urls)

echo "<html><body>" > $fichier_tableau
echo "<h2>Tableau $basename :</h2>" >> $fichier_tableau
echo "<br/>" >> $fichier_tableau
echo "<table>" >> $fichier_tableau
echo "<tr>
	<th>ligne</th>
	<th>code</th>
	<th>URL</th>
	<th>Encodage</th>
	<th>Occurrences</th>
	<th>DumpText</th>
	<th>HTML</th>
	<th>Contexte</th>
	<th>Concordances</th>
	</tr>" >> $fichier_tableau
	
lineno=1;
while read -r URL; do
	echo -e "\tURL : $URL";
	# la façon attendue, sans l'option -w de cURL
	code=$(curl -ILs $URL | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | tail -n 1)
	charset=$(curl -ILs $URL | grep -Eo "charset=(\w|-)+" | cut -d= -f2 | tail -n 1)
	Occurences=$(lynx -accept_all_cookies -dump $URL | egrep "discrimination raciale" -wc)
	echo -e "\tURL : $URL";
	echo -e "\tcode : $code";


	if [[ ! $charset ]]
	then
		echo -e "\tencodage non détecté, on prendra UTF-8 par défaut.";
		charset="UTF-8";
	else
		echo -e "\tencodage : $charset";
	fi

	if [[ $code -eq 200 ]]
	then
		dump=$(lynx -dump -nolist -assume_charset=$charset -display_charset=$charset $URL)
		if [[ $charset -ne "UTF-8" && -n "$dump" ]]
		then
			dump=$(echo $dump | iconv -f $charset -t UTF-8//IGNORE)
		fi
	else
		echo -e "\tcode différent de 200 utilisation d'un dump vide"
		dump=""
		charset=""
	fi

	echo "$dump" > "dumps-text/$basename-$lineno.txt"

	echo "<tr>
	<td>$lineno</td>
	<td>$code</td>
	<td><a href=\"$URL\">$URL</a></td>
	<td>$charset</td><td>$Occurences</td>
	<td><a href=\"../dumps-text/fr-$lineno.txt\">text</a></td>
	<td><a href=\"../aspirations/fr-$lineno.html\">html</a></td>
	<td><a href=\"../contextes/fr-$lineno.txt\">contexte</a></td>
	<td><a href=\"../concordances/concordance_fr-$lineno.html\">concordance</a></td>
	</tr>" >> $fichier_tableau
	echo -e "\t--------------------------------"
	lineno=$((lineno+1));
done < $fichier_urls
echo "</table>" >> $fichier_tableau
echo "</body></html>" >> $fichier_tableau