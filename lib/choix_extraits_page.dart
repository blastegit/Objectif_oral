import 'package:flutter/material.dart';
import 'data_reader.dart';
import 'extrait_detail_page.dart';

Widget extraitsPage(BuildContext context, Map<String, dynamic> jsonData) {
  return buildGrid(context, jsonData);
}

Widget buildAvancement(BuildContext context) {
  return SizedBox(
      width: 308, //ne pas oublier la largeur de l'espacement
      height: 150,
      child: Card(
          clipBehavior: Clip.hardEdge,
          child: Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('100 %',
                        style: Theme.of(context).textTheme.titleLarge),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          minHeight: 8,
                          value: 0.5,
                        )),
                  ]))));
}

Widget buildGrid(BuildContext context, Map<String, dynamic> jsonData) {
  List<Widget> listCard = buildCarte(context, jsonData);
  return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
          child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: listCard,
      )));
}

List<Widget> buildCarte(BuildContext context, Map<String, dynamic> jsonData) {
  List<Widget> r = [];
  for (ExtraitData extraitData in getAllExtraits(jsonData)) {
    r.add(carte(
      context,
      extraitData,
    ));
  }
  return r;
}

Widget carte(BuildContext context, ExtraitData data) {
  return SizedBox(
      width: 150,
      height: 150,
      child: Card(
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
          ])));
}
