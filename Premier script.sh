# traitement de l'année 2016, on crée on écrane le fichier soirtie.txt

echo "pour l'année 2016" > sortie.txt
grep "Location" 2016*.ann | wc -1 >> sortie.txt

#traitement de l'année 2017, on écrit à la suite du fichier
echo "pour l'année 2017" >> sortie.txt
grep"Location 2017*.ann| wc -1 >> sortie.txt

#traitement de l'année 2018, on écrit à la suite du fichier
echo "pour l'année 2018" >> sorties.txt
grep"Location" 2018*.ann | wc -1 >> sortie.txt
