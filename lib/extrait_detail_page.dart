import 'package:flutter/material.dart';
import 'package:objectif_oral/data_reader.dart';

Widget extraitDetailPage(BuildContext context, ExtraitData data) {
  return Scaffold(
      appBar: AppBar(
        title: Text(data.shortTitle),
      ),
      body: SingleChildScrollView(
        child: modeSimple(context, data),
      ));
}

/* anc extrait detail page
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
  //MediaQuery.of(context).size
  return Scaffold(
      appBar: AppBar(
        title: Text(data["title_court"]),
      ),
      body: SingleChildScrollView(
        child: modePortrait(
            context, data, analyseTexte, textFormatTitle, textFormatNormal),
      ));
}
*/

Widget modeSimple(BuildContext context, ExtraitData data) {
  TextStyle textFormatTitle = const TextStyle(//TODO: remplacer ça
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  TextStyle textFormatNormal = const TextStyle(
    fontSize: 20,
  );
  return Column(
    children: [
      Hero(
        tag: data.id,
        child: Image.asset(
          "assets/images/gargantua.png",
          fit: BoxFit.cover,
        ),
      ),
      Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                data.fullTitle,
                style: textFormatTitle,
                textAlign: TextAlign.start,
              ),
              Text(
                data.bodyText,
                style: textFormatNormal,
                textAlign: TextAlign.justify,
              ),
              Text(
                "Analyse :",
                style: textFormatTitle,
                textAlign: TextAlign.start,
              ),
              Text(
                data.analyse,
                style: textFormatNormal,
                textAlign: TextAlign.justify,
              ),
            ],
          )),
    ],
  );
}
