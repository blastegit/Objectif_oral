import 'package:flutter/material.dart';

import 'choix_extraits_page.dart';
import 'grammaire_page.dart';
import 'oeuvre_page.dart';
import 'location_page.dart';
import 'settings_page.dart';
import 'data_reader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NavigationExample(),
      theme: ThemeData(colorSchemeSeed: Colors.black, useMaterial3: true),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  final bool useMaterial3 = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFileText("assets/yearData/yearData2021.json"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> extraitsInfoData =
                getJsonDataFromText(snapshot.data);
            return Scaffold(
              appBar: AppBar(
                title: const Text('Bienvenue'),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.update),
                    tooltip: "Changer d'année",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return Scaffold(
                            appBar: AppBar(
                              title: const Text('Next page'),
                            ),
                            body: const Center(
                              child: Text(
                                'This is the next page',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          );
                        },
                      ));
                    },
                  ),
                  IconButton(
                      icon: const Icon(Icons.settings),
                      tooltip: 'Paramètres',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ParametresPage()));
                      }),
                ],
              ),
              bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                selectedIndex: currentPageIndex,
                destinations: const <Widget>[
                  NavigationDestination(
                    icon: Icon(Icons.library_books_rounded),
                    label: 'extraits',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.text_format_rounded),
                    label: 'grammaire',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.menu_book_rounded),
                    label: 'œuvre',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.place_rounded),
                    label: 'examen',
                  )
                ],
              ),
              body: <Widget>[
                extraitsPage(context, extraitsInfoData),
                grammairePage(context),
                oeuvrePage(context),
                examenPage(context)
              ][currentPageIndex],
            );
          } else if (snapshot.hasError) {
            // Affichage d'un message d'erreur
            return Center(
              child: Text("Une erreur s'est produite lors du chargement des données. ${snapshot.error}"),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator()); //Chargement
          }
        });
  }
}
