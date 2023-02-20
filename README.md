# Objectif_oral

Une appli simple et pratique pour réviser n'importe où codée en Dart.


##Donnés

Les donnés des différents extraits sont encodés au format `json`.
A l'intérieur du `full_title`, du `body_text` ou de l'`analyse`, des titres peuvent êtres créés en les encadrant par des `##`.
Les sauts de ligne sont représentés par des symboles ` | ` et l'italique par `//`.

Exemple :
```json
{
  "full_title" : "##Gargantua de François Rabelais,## | CHAPITRE 1 (INCIPIT), | //De la généalogie et des anciennes origines de Gargantua//"
}
```
Sera rendu :

<u>**Gargantua de François Rabelais,**</u>
CHAPITRE 1 (INCIPIT),
***De la généalogie et des anciennes origines de Gargantua***