import 'package:flutter/material.dart';

Widget extraitDetailPage(BuildContext context, Map data) {
  String analyseTexte = "";
  for (String t in data["analyse"]) {
    analyseTexte = analyseTexte + t;
  }
  TextStyle textFormatTitle = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  TextStyle textFormatNormal = const TextStyle(
    fontSize: 20,
  );
  //MediaQuery.of(context).size TODO:changer affichage selon taille et orientation
  return Scaffold(
      appBar: AppBar(
        title: Text(data["title_court"]),
      ),
      body: SingleChildScrollView(
        child: modePortrait(
            context, data, analyseTexte, textFormatTitle, textFormatNormal),
      ));
}

/*
OrientationBuilder(
builder: (context, orientation) {
*/
Widget modePortrait(BuildContext context, Map data, String analyseTexte,
    TextStyle textFormatTitle, TextStyle textFormatNormal) {
  return Column(
    children: [
      Hero(
        tag: data["title_court"],
        child: Image.asset(
          data["image"],
          fit: BoxFit.cover,
        ),
      ),
      Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                data["title"],
                style: textFormatTitle,
                textAlign: TextAlign.start,
              ),
              Text(
                data["texte"],
                style: textFormatNormal,
                textAlign: TextAlign.justify,
              ),
              Text(
                "Analyse :",
                style: textFormatTitle,
                textAlign: TextAlign.start,
              ),
              Text(
                analyseTexte,
                style: textFormatNormal,
                textAlign: TextAlign.justify,
              ),
            ],
          )),
    ],
  );
}
