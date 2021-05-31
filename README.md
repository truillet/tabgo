# TabGO
***

## Infos générales
***
Le projet TAbGO permet aux personnes non-voyantes d'utiliser le logiciel en ligne Scratch par bloc tangibles.
Le programme permet la reconnaissance des blocs tangibles grâce à des TopCodes ainsi que des cubarithmes et
créer un fichier sb3 reconnu par Scratch.

## Technologies
***
Logiciel utilisant Processing et les librairies OpenCV et Video (pour la reconnaissance optiques) et GSON (pour la
création du fichier JSON).
Ajout de la librairie TTSLib de Processing pour le feedback sonor.

## Installation
***
Téléchargement du logiciel Processing: https://processing.org/download/
Importation des librairies OpenCV, Video et TTSLib:
Sketch -> Importer une librairie -> Ajouter une librairie
Importation de la librairie gson: Normalement la librairie (gson.jar) se trouve dans le dossier "code" et sera
chargée automatiquement. Si cela ne marche pas, glissez-déposez le .jar dans la fenêtre Processing lors de l'ouverture
du programme sur Processing.

## Exécution
***
Après avoir appuyé sur lancer le programme sur Processing (le bouton "Play"), vous pouvez scanner votre
environnement de travail et commencer l'exécution du programme en appuyant sur la touche "espace".
Si vous voulez lancer un script de test, appuyé sur "t" ou "T".
Les fichiers de tests (.png) se trouvent dans le dossier "data". Vous modifiez le fichier à tester dans
la classe "tabgo_be", dans la méthode "creation".
Le fichier .sb3 obtenu se trouve dans le dossier "data/sb3/Programme_scratch.sb3" et peut ensuite être chargée
dans le logiciel Scratch : Créer -> File -> Load from your computer
