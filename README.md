# Objectif_oral

Une appli simple et pratique pour réviser n'importe où codée en Dart.


## Donnés

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

### **Non Valide** Concernant les images:
**Non Valide** Les images sont inclus directement dans le fichier json encodée sous le format `base64`. Pour encoder facilement une image dans ce format, un simple code python suffit:

**Non Valide**
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