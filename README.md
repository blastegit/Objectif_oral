# Objectif_oral

Une appli simple et pratique pour réviser n'importe où codée en Dart.


## Donnés

### Exemple de json :

```json
{ "year" : 2021,
  "extraits":  [
    {
      "id": "2021.GdR",
      "full_title": "Gargantua de François Rabelais, CHAPITRE 1 (INCIPIT), De la généalogie et des anciennes origines de Gargantua",
      "short_title": "Gargantua de Rabelais",
      "body_text": "Je vous renvoie à la grande chronique pantagruéline pour retrouver la généalogie et l’ancien temps dont nous est venu Gargantua. Vous y apprendrez plus longuement comment les géants naquirent en ce monde et comment, en ligne directe, en est descendu Gargantua, père de Pantagruel ; vous ne vous fâcherez pas si, pour l’heure, je m’en abstiens ; et pourtant la chose est si belle que, plus on la répéterait, plus elle plairait à vos Seigneuries : vous avez la caution de Flaccus, qui déclare que certains propos tels que ceux-ci sont d’autant plus délectables qu’on les redit plus souvent.\\n     Plût à Dieu que tout le monde connût aussi certainement sa généalogie depuis l’arche de Noé jusqu’à notre époque ! Je crois qu’il y a aujourd’hui beaucoup d’empereurs, de rois, de ducs, de princes et de papes ici-bas, qui descendent de quelques porteurs de reliquailles et de hottes, et qu’à l\\'inverse nombreux sont les gueux de l’hospice, souffreteux et misérables, qui descendent du sang et de la lignée de grands rois et empereurs [...].",
      "analyse" : "",
      "image_key" : "gargantua_img"
    }
  ],
  "images64" : {
    "gargantua_img" : "image codée en base64"
  }
}
```

### Mise en page
Les donnés des différents extraits sont encodés au format `json`.
A l'intérieur du `full_title`, du `body_text` ou de l'`analyse`, des titres peuvent êtres créés en les encadrant par des `##`.
Les sauts de ligne sont représentés par des symboles ` | ` et l'italique par `//`.
On peut rajouter des balise `[0]`, `[1]`, ect pour faire scroller le texte au même niveau

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

### Concernant les images: 
Les images sont inclus directement dans le fichier json encodée sous le format `base64`. Pour encoder facilement une image dans ce format, un simple code python suffit:

**Important :** les images doivent être des png
```python
import base64
 
def encode_img(image_path):
    with open(image_path, "rb") as img_file:
        return base64.b64encode(img_file.read()).decode('utf-8')


if __name__ == "__main__":
    string = encode_img(r"path\to\image")
    with open(r"path\to\fichier où sauver (trop grand pour printer)", "w") as file:
        file.write(string)
```