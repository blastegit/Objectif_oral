import 'package:flutter/material.dart';

import 'extraitsChoixPage.dart';
import 'grammairePage.dart';
import 'oeuvrePage.dart';
import 'examenPage.dart';
import 'ParametresPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NavigationExample(),
      theme: ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.settings_rounded),
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ParametresPage()));
              }),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
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
        extraitsPage(context),
        grammairePage(context),
        oeuvrePage(context),
        examenPage(context)
      ][currentPageIndex],
    );
  }
}
