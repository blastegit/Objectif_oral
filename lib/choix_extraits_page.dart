import 'package:flutter/material.dart';
import 'data_reader.dart';
import 'extrait_detail_page.dart';

Widget extraitsPage(BuildContext context, Map<String, dynamic> jsonData) {
  List<Card> listCard = buildCarte(context, jsonData);
  listCard = List.filled(15, listCard[0]);//TODO:Attention multiplie artificiellemnt le nombre d'éléments
  //Calcul du nombre de colonne optimal
  double screenWidth = MediaQuery.of(context).size.width;
  double itemWidth = 150; //largeur du widget souhaité
  int crossAxisCount = (screenWidth / itemWidth).floor();
  return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: crossAxisCount,
      children: listCard);
}

List<Card> buildCarte(BuildContext context, Map<String, dynamic> jsonData) {
  List<Card> r = [];
  for (ExtraitData extraitData in getAllExtraits(jsonData)) {
    r.add(carte(
      context,
      extraitData,
    ));
  }
  return r;
}

Card carte(BuildContext context, ExtraitData data) {
  return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      child: Stack(children: [
        Column(
          children: [
            Expanded(
                child: Hero(
                    tag: data.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        "assets/images/gargantua.png",
                        fit: BoxFit.cover,
                      ),
                    ))),
            Container(
              alignment: Alignment.center,
              child: Text(data.shortTitle,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ],
        ),
        InkWell(
          splashColor: Theme.of(context).colorScheme.primaryContainer,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => extraitDetailPage(context, data),
              ),
            );
          },
        ),
      ]));
}
