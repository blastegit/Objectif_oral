import 'package:flutter/material.dart';
import 'package:objectif_oral/data_reader.dart';
import 'package:objectif_oral/preferences.dart';

class ExtraitDetailPage extends StatelessWidget {
  const ExtraitDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(UserData.of(context).id(id).shortTitle),
        ),
        body: SingleChildScrollView(
            child: MediaQuery.of(context).size.width < 640
                ? ModeSimple(id: id)
                : ModeDouble(id: id)));
  }
}

class ModeSimple extends StatelessWidget {
  const ModeSimple({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: id,
          child: Image.asset(
            "assets/images/gargantua.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                ExtraitData.widgetTextCreator(
                    context, "${UserData.of(context).id(id).fullTitle} | "),
                ExtraitData.widgetTextCreator(
                    context, "${UserData.of(context).id(id).bodyText} | "),
                ExtraitData.widgetTextCreator(context, "##Analyse :## | "),
                ExtraitData.widgetTextCreator(
                    context, UserData.of(context).id(id).analyse),
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
            }),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}

class ModeDouble extends StatelessWidget {
  const ModeDouble({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 20.0),
            padding: const EdgeInsets.only(
              right: 20,
              bottom: 20,
              top: 20,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                        padding: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: Hero(
                          tag: id,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
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
                        ),
                        child: ExtraitData.widgetTextCreator(
                            context, UserData.of(context).id(id).fullTitle))),
              ],
            )),
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
                        ExtraitData.widgetTextCreator(
                            context, "##Texte :## | "),
                        ExtraitData.widgetTextCreator(
                            context, UserData.of(context).id(id).bodyText),
                      ],
                    ))),
            Expanded(
                flex: 5,
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExtraitData.widgetTextCreator(
                            context, "##Analyse :## | "),
                        ExtraitData.widgetTextCreator(
                            context, UserData.of(context).id(id).analyse),
                      ],
                    ))),
          ],
        )
      ],
    );
  }
}
