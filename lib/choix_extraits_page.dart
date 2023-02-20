import 'package:flutter/material.dart';
import 'data_extraits.dart';
import 'extrait_detail_page.dart';

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
              dataCarte,
              dataCarte['title_court'],
              dataCarte['image']
              ));
  }
  return r;
}

Card carte(BuildContext context,
          Map data,
          String title, 
          String pathToImage
          ) {
  return Card(
    elevation: 1,
    clipBehavior: Clip.hardEdge,
    child:
        Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: title,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child : Image.asset(
                          pathToImage,
                          fit: BoxFit.cover,
                        ),
                      )
                    )
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                        title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style : const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        )
                    ),
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
            ]
        )
    );
}