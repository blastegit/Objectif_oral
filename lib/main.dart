import 'dart:developer'; //TODO

import 'package:flutter/material.dart';

import 'choix_extraits_page.dart';
import 'grammaire_page.dart';
import 'oeuvre_page.dart';
import 'location_page.dart';
import 'settings_page.dart';
import 'data_reader.dart';
import 'preferences.dart';

//TODO à enlever
import "package:shared_preferences/shared_preferences.dart";

const tailleLimiteRail = 640;

void main() {
  runApp(const ObjectifOralApp());
}

class ObjectifOralApp extends StatelessWidget {
  const ObjectifOralApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataAdder(
      child: UserData(
        child: MaterialApp(
          home: const AppLoader(
            child: HomePage(),
          ),
          theme: ThemeData(colorSchemeSeed: Colors.black, useMaterial3: true),
        ),
      ),
    );
  }
}

//TODO ce code sert à ajouter un json avec des donnés en attendant qu'une interface utilisateur ne puisse le faire A SUPPRIMER
class DataAdder extends StatelessWidget {
  final Widget child;

  const DataAdder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      log("contenue de getpreferences : $value");
    });
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences
            .getInstance(),
        builder: (BuildContext context,
            AsyncSnapshot<SharedPreferences> snapshotSharedPreferences) {
          if (snapshotSharedPreferences.connectionState ==
              ConnectionState.done) {
            if (snapshotSharedPreferences.hasError) {
              throw "erreur lors de l'ajout court circuité de donnés json, récupération des préférences erreur : ${snapshotSharedPreferences.error}";
            } else {
              if (snapshotSharedPreferences.data == null) {
                throw "erreur lors de l'ajout court circuité de donnés json, SharedPreferences.getInstance() return null";
              }
              return FutureBuilder<String>(
                  future: getFileText("assets/yearData/yearData2223.json"),
                  builder: (BuildContext context,
                      AsyncSnapshot<String> snapshotJsonStringData) {
                    if (snapshotJsonStringData.connectionState ==
                        ConnectionState.done) {
                      if (snapshotJsonStringData.hasError) {
                        throw "erreur lors de l'ajout court circuité de donnés json, lecture du fichier json erreur : ${snapshotJsonStringData.error}";
                      } else {
                        if (snapshotJsonStringData.data == null) {
                          getFileText("assets/yearData/yearData2223.json")
                              .then((value) {
                            log("value of file is $value but returned value is null");
                          });
                          throw "erreur lors de l'ajout court circuité de donnés json, getFileText('path/to/file') return null";
                        }
                        snapshotSharedPreferences.data!.setStringList(
                            UserData.listExtraits, [snapshotJsonStringData.data!]);
                        snapshotSharedPreferences.data!.setStringList(UserData.validatedExtrait, []);
                        snapshotSharedPreferences.data!.setStringList(UserData.activatedExtrait, []);
                        return child;
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class AppLoader extends StatelessWidget {
  final Widget child;

  const AppLoader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: UserData.of(context).loadEverything(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                  //TODO: Donner la possibilité changer la source de donnés depuis l'erreur
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
              return child;
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
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
              const ExtraitsChoixPage(),
              grammairePage(context),
              oeuvrePage(context),
              examenPage(context)
            ][currentPageIndex],
          ),
        ]));
  }
}
