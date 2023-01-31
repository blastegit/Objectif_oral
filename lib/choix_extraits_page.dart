import 'package:flutter/material.dart';
import 'data_extraits.dart';
/*
Widget extraitsPage(BuildContext context) {
  return Container(
    color: Colors.red,
    alignment: Alignment.center,
    child: const Text('Page des extraits'),
  );*/

Widget extraitsPage(BuildContext context) {
  return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: buildCarte(context));
}

List<Card> buildCarte(BuildContext context) {
  List<Card> r = [];
  for (var dataCarte in extraitsData) {
    r.add(carte(context, 
              dataCarte['title_court'],
              dataCarte['image']
              ));
  }
  return r;
}

Card carte(BuildContext context,
          String title, 
          String pathToImage
          ) {
  return Card(
    elevation: 1,
    clipBehavior: Clip.hardEdge,
    child:
        Stack(
            children: [
              InkWell(
                splashColor: Theme.of(context).colorScheme.primaryContainer,
                onTap: () {
                debugPrint('Card tapped.');
                },
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style : const TextStyle(fontWeight: FontWeight.bold),
              ),
              Image.asset('assets/images/gargantua.png'),
            ]
        )
    )
  );
}