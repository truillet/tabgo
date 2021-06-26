# TaBGO
***

## Informations générales
***
Le projet TABGO a pour objectif de permettre à des personnes non-voyantes d'utiliser la langage de programmation Scratch par utilisation de blocs tangibles. 
Un logiiciel permet la reconnaissance des blocs tangibles grâce à des TopCodes ainsi que des cubarithmes et
créer un fichier **sb3** exécutable par Scratch.

## Technologies utilisées
***
Le logiciel utilise [processing.org](https://www.processing.org) et les librairies *OpenCV*, *video* (pour la reconnaissance optique) et *GSON* (pour la création des fichiers sb3).
Enfin, la librairie *TTSLib* pour Processing est utilisée pour un feedback sonore.

## Installation
***
Téléchargement du logiciel Processing : https://processing.org/download/
Importation des librairies OpenCV, Video et TTSLib : Sketch -> Importer une librairie -> Ajouter une librairie
Importation de la librairie gson : Normalement la librairie (gson.jar) se trouve dans le sous-dossier "code" et sera
chargée automatiquement. Si cela ne fonctionne pas, glissez-déposez le .jar dans la fenêtre Processing lors de l'ouverture
du programme sur Processing.

## Exécution
***
Après avoir appuyé sur lancer le programme Processing (bouton "Play"), vous pouvez scanner votre
environnement de travail et commencer l'exécution du programme en appuyant sur la touche "espace".
Si vous voulez lancer un script de test, appuyé sur "t" ou "T".
Les fichiers de tests (.png) se trouvent dans le sous-dossier "data". Vous modifiez le fichier à tester dans
la classe "tabgo_be", dans la méthode "creation".
Le fichier .sb3 obtenu se trouve dans le dossier "data/sb3/Programme_scratch.sb3" et peut ensuite être chargé
dans le logiciel Scratch : Créer -> File -> Load from your computer
