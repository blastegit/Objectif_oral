import 'package:flutter/material.dart';
import 'package:objectif_oral/data_reader.dart';

Widget extraitDetailPage(BuildContext context, ExtraitData data) {
  return Scaffold(
      appBar: AppBar(
        title: Text(data.shortTitle),
      ),
      body: SingleChildScrollView(
          child: MediaQuery.of(context).size.width < 640
              ? modeSimple(context, data)
              : modeDouble(context, data)));
}

Widget modeSimple(BuildContext context, ExtraitData data) {
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
              data.widgetTextCreator(context, "${data.fullTitle} | "),
              data.widgetTextCreator(context, "${data.bodyText} | "),
              data.widgetTextCreator(context, "##Analyse :## | "),
              data.widgetTextCreator(context, data.analyse),
            ],
          )),
      OutlinedButton.icon(
        icon: const Icon(Icons.done_rounded),
        label: const Text("Terminé"),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.focused)) {
                  return Colors.red;
                }
                return null; // Defer to the widget's default.
              }
          ),
        ),
        onPressed: () { },
      )
    ],
  );
}

Widget modeDouble(BuildContext context, ExtraitData data) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                  padding: const EdgeInsets.only(
                    right: 20,
                    bottom: 20,
                  ),
                  child: Hero(
                    tag: data.id,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          "assets/images/gargantua.png",
                          fit: BoxFit.cover,
                        )),
                  ))),
          Expanded(
              flex: 5,
              child: Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: data.widgetTextCreator(context, data.fullTitle))),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 5,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.widgetTextCreator(context, "##Texte :## | "),
                      data.widgetTextCreator(context, data.bodyText),
                    ],
                  ))),
          Expanded(
              flex: 5,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.widgetTextCreator(context, "##Analyse :## | "),
                      data.widgetTextCreator(context, data.analyse),
                    ],
                  ))),
        ],
      )
    ],
  );
}
