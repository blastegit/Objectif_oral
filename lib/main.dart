import 'package:flutter/material.dart';

import 'choix_extraits_page.dart';
import 'grammaire_page.dart';
import 'oeuvre_page.dart';
import 'location_page.dart';
import 'settings_page.dart';
import 'data_reader.dart';

const tailleLimiteRail = 640;

void main() {
  runApp(const ObjectifOralApp());
}

class ObjectifOralApp extends StatelessWidget {
  const ObjectifOralApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(colorSchemeSeed: Colors.black, useMaterial3: true),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  final bool useMaterial3 = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFileText("assets/yearData/yearData2223.json"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> extraitsInfoData =
                getJsonDataFromText(snapshot.data);
            return createApp(context, extraitsInfoData);
          } else if (snapshot.hasError) {
            // Affichage d'un message d'erreur
            return Container(//TODO: Donner la possibilité changer la source de donnés depuis l'erreur
                color: Theme.of(context).colorScheme.errorContainer,
                child: Center(
                    child: Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Icon(
                          Icons.error_outline_rounded,
                          size: 100,
                          color: Theme.of(context).colorScheme.error,
                        )),
                    Expanded(
                        flex: 7,
                        child: Container(
                            margin: const EdgeInsets.all(20),
                            child: Text(
                              "Une erreur s'est produite lors du chargement des données :\n${snapshot.error}",
                              style: Theme.of(context).textTheme.titleMedium,
                              softWrap: true,
                              textAlign: TextAlign.justify,
                            ))),
                  ],
                )));
          } else {
            return const Center(
                child: CircularProgressIndicator()); //Chargement
          }
        });
  }

  //TODO: Style erreur de fond
  Widget createApp(
      BuildContext context, Map<String, dynamic> extraitsInfoData) {
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
        bottomNavigationBar:
            MediaQuery.of(context).size.width < tailleLimiteRail
                ? NavigationBar(
                    onDestinationSelected: (int index) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    },
                    selectedIndex: currentPageIndex,
                    labelBehavior:
                        NavigationDestinationLabelBehavior.onlyShowSelected,
                    destinations: const <NavigationDestination>[
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
                  )
                : null,
        body: Row(children: [
          if (MediaQuery.of(context).size.width >= tailleLimiteRail)
            NavigationRail(
                labelType: NavigationRailLabelType.selected,
                backgroundColor: Theme.of(context).colorScheme.surface,
                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(Icons.library_books_rounded),
                    label: Text('extraits'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.text_format_rounded),
                    label: Text('grammaire'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.menu_book_rounded),
                    label: Text('œuvre'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.place_rounded),
                    label: Text('examen'),
                  ),
                ],
                selectedIndex: currentPageIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                }),
          Expanded(
            child: <Widget>[
              extraitsPage(context, extraitsInfoData),
              grammairePage(context),
              oeuvrePage(context),
              examenPage(context)
            ][currentPageIndex],
          ),
        ]));
  }
}
