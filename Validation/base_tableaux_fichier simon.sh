#!/usr/bin/env bash

#===============================================================================
# VOUS DEVEZ MODIFIER CE BLOC DE COMMENTAIRES.
# Ici, on décrit le comportement du programme.
# Indiquez, entre autres, comment on lance le programme et quels sont
# les paramètres.
# La forme est indicative, sentez-vous libres d'en changer !
# Notamment pour quelque chose de plus léger, il n'y a pas de norme en bash.
#===============================================================================

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie

if [[ $# -ne 2 ]]
then
	echo "Ce programme demande exactement deux arguments."
	exit
fi

mot="discrimination raciale" # à modifier

echo $urls_Tannina;
basename=$(basename -s .txt $urls_Tannina)

echo "<html><body>" > $fichier_tableau
echo "<h2>Tableau $basename :</h2>" >> $fichier_tableau
echo "<br/>" >> $fichier_tableau
echo "<table>" >> $fichier_tableau
echo "<tr><th>ligne</th><th>code</th><th>URL</th><th>Encodage</th><th>Concordances</th></tr>" >> $fichier_tableau
#<th>dump html</th><th>dumt text</th></tr>
lineno=1;
while read -r URL; do
	echo -e "\tURL : $URL";
	# la façon attendue, sans l'option -w de cURL
	code=$(curl -ILs $URL | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | tail -n 1)
	charset=$(curl -Ls $URL | grep -Eo "charset=(\w|-)+" |tail | cut -d= -f2)
	concordance=$(w3m -cookie $URL | egrep "discrimination raciale" -wc)


	# autre façon, avec l'option -w de cURL
	# code=$(curl -Ls -o /dev/null -w "%{http_code}" $URL)
	# charset=$(curl -ILs -o /dev/null -w "%{content_type}" $URL | grep -Eo "charset=(\w|-)+" | cut -d= -f2)

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
		if [[ $charset -ne "UTF-8" && -n "$dump" ]] #command1 && command2  只有前面命令执行成功，后面命令才继续执行    -n  表示if [ -n str1 ]　　　　　　 当串的长度大于0时为真(串非空) 
		then
			dump=$(echo $dump | iconv -f $charset -t UTF-8//IGNORE)  #也就是说，如果检查出其编码信息不为空，且不等于utf8时，就要把它转成utf8
		fi
	else
		echo -e "\tcode différent de 200 utilisation d'un dump vide"
		dump=""
		charset=""
	fi
	# echo "$dump" > ""fich-$lineno.txt" 
	echo "<tr><td>$lineno</td><td>$code</td><td><a href=\"$URL\">$URL</a></td><td>$charset</td><td>$concordance</td></tr>" >> $fichier_tableau
	echo -e "\t----------------------------------------------------------------"
	lineno=$((lineno+1));
done < $urls_Tannina
echo "</table>" >> $fichier_tableau
echo "</body></html>" >> $fichier_tableau
