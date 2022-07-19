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
    r.add(carte(context, dataCarte['title_court']));
  }
  return r;
}

Card carte(BuildContext context, String title) {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primaryContainer,
        onTap: () {
          debugPrint('Card tapped.');
        },
        ),
      ),
  );
}
