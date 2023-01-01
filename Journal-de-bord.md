# Journal de bord du projet encadré

## Slide Git : introduction / slide exercice Github I
Création d'un compte github:
* création d'un dossier plurital dans le dossier Sorbonne qui regroupe les différents cours de la Sorbonne, dans ce dossier je vais cloner le git de Monsieur Dupont.
* Par la suite, je créer un dépôt sur mon github portant le nom PPE1 celui-ci me servira à réaliser tous les exercices donnés. Je vais le cloner dans un dossier github_perso créer préalablement dans le dossier Sorbonne.
* Dans ce dossier, j'ai crée le fichier en mardown journal de bord qui me permet d'expliciter mes avancements et problèmes rencontrés durant les séances.
Lors de la création de mon github le fichier DS.store c'est créer tout seul.
Je l'ai enlevé manuellement mais il est revient constamment.

## Slide Git : un peu plus loin / slide exercice Git II : mise en pratique
* Mon fichier j'ai du le cloner deux fois: la première fois je n'ai rencontré aucun problème mais je n'avais pas créer correctement la clé Ed25519, la deuxième fois j'ai pu créer celle-ci. Cependant, j'ai rencontré quelques problèmes pour cloner car je n'avais pas les accès: j'ai du retrouver ma clé avec le commande .ssh dans le terminal pour récupérer ma clé publique terminant par .pub. Après j'ai ajouté la clé publique à mon Github et j'ai pu cloner mon dossier sans soucis. Le fichier DS.store revient toujours.
Je n'arrive pas à réaliser de commit ni dans mon github perso ni sur celui de groupe.
J'ai essayé d'effectuer un tag avec la commande fourni dans les slides, incapacité à la réaliser. Après quelques recherches sur le net, je réussis à faire un tag sur un commit sur mon journal de bord appelé "good version", ce tag a été effectué avec la commande: git tag -a v1.4 -m 'good version'. Si je souhaite observer tous les tag effectuer je fais la commande : git tag, elle me permettra d'énumérer tous les tags réalisés.


## Slide Git : Web: HTML, HTTP, récupérer des pages
* Téléchargement des différentes commandes : lynx, brew, curl ainsi que le commande wget. J'ai réalisé les différentes manipulations avec la commande curl, qui me permet de visualiser les différentes informations entre le serveur et la commande. Cependant, certaines commande m'indique: zsh: parse error near '\n'. Je ne comprends pas le problème, malgrès plusieurs recherches.
* Ces différentes commandes permettent l'extraction de plusieurs informations concernant les sites tels que : l'encodage, le code HTTP des sites, le nombre d'occurrences du terme.
* Premières réflexions sur la construction du script permettant l'extraction de ces différentes informations.

## Slide : Pages GitHub
* Premiers pas d'une création d'un dépot d'une page Github, pour ce faire il faut tout d'abord récupérer le fichier: index.html déposé sur le github YoannDupont//PPE, je l'ai télécharger et pushé sur mon dépot perso. À présent, je dois dire à GitHub de déployer le site depuis le dépot. Pour ce faire, il faut aller dans settings--> général --> pages --> section Build And Deployment --> Source → Deploy from a branch --> Branch → main. Cela créera le dépot contenant le site pour modifier le corps du texte du site, il faut aller dans le fichier et le modifier manuellement. Pour visualiser, le changement il faut attendre quelques minutes.

## Slide  Shell Unix
* Création d'un document non déposé dans le git permettant l'énumération des nombreuses commandes tels que cd, ls,rm...
