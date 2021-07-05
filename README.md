# TaBGO <img src="https://github.com/truillet/tabgo_be/blob/main/documentation/images/tabgo.png" width=150 alt="TaBGO">

## Informations générales
Le projet TaBGO a pour objectif de permettre à des personnes non-voyantes d'utiliser le langage de programmation [Scratch](https://scratch.mit.edu) par utilisation de blocs tangibles.
Le logiciel TaBGO permet la reconnaissance des blocs tangibles grâce à des [TopCodes](https://github.com/truillet/TopCodes) ainsi que des cubarithmes et créer un fichier **sb3** exécutable par [Scratch](https://scratch.mit.edu).

<img src="https://github.com/truillet/tabgo_be/blob/main/documentation/images/blocks.jpg" width=400 alt="différents prototypes">

Vous pouvez consulter la documentation pour construire vos blocs au format **[docx](https://github.com/truillet/tabgo/blob/main/documentation/TaBGO_blocs_Scratch.docx)** ou **[pdf](https://github.com/truillet/tabgo/blob/main/documentation/TaBGO_blocs_Scratch.pdf)**

Des exemples d'algorithmes sont disponibles *ici* (à venir)

Le code disponible ici a principalement été développé par des étudiants de L3 informatique de l'université Toulouse 3 dans le cadre de leur TER 2020/2021 et fait suite à 3 "PoC" précédents.
https://github.com/truillet/tabgo/blob/main/documentation/TaBGO_blocs_Scratch.docx
## Technologies utilisées
Le logiciel utilise [processing.org](https://www.processing.org) et les librairies *[OpenCV](https://github.com/truillet/tabgo/blob/main/code/opencv_processing4.52.jar)* recompilé avec la version OpenCV 4.52, *[Video](https://github.com/processing/processing-video)* (pour la reconnaissance optique) et *[gson](https://github.com/google/gson)* (pour la création des fichiers **sb3**).
Enfin, la librairie *[TTSLib](https://www.local-guru.net/blog/pages/ttslib)* pour Processing est utilisée pour un feedback sonore.

## Installation (à n'effectuer qu'une fois)
* Téléchargement du logiciel [Processing.org](https://processing.org/download)
* Importation des librairies *[Video](https://github.com/processing/processing-video)* et *[TTSLib](https://www.local-guru.net/blog/pages/ttslib)* : 

`Sketch -> Importer une librairie... -> Ajouter une librairie...`
* Les librairise [gson](https://github.com/google/gson). Normalement la librairie *[gson](https://github.com/google/gson)* et *[OpenCV](https://github.com/truillet/tabgo/blob/main/code/opencv_processing4.52.jar)* se trouvent dans le sous-dossier **code** et seront chargées automatiquement. Si cela ne fonctionne pas, glissez-déposez les fichiers *.jar* dans la fenêtre Processing lors de l'ouverture du programme.

## Exécution
Après avoir appuyé sur *"lancer le programme Processing"* (bouton *"Play"*), vous pouvez scanner votre environnement de travail et commencer l'exécution du programme en appuyant sur la touche *"espace"*.

Si vous voulez lancer un script de test, appuyez sur *"t*" ou "*T*". Les fichiers de tests (images **.png**) se trouvent dans le sous-dossier **data**. Modifiez le fichier à tester dans la classe "*tabgo_be.pde*", dans la méthode "*creation*".
Le fichier **.sb3** obtenu se trouve dans le dossier "**data/sb3/Programme_scratch.sb3**" et peut ensuite être chargé et exécuté sur le site web [Scratch](https://scratch.mit.edu) : 

`Bouton Créer puis menu  File -> Load from your computer`

## Financement
Ce projet a été partiellement financé via un appel à projets de l'[UNADEV](https://www.unadev.com/nos-missions/appel-a-projets) - Financement **2019.49** 
