import 'package:flutter/material.dart';

class ParametresPage extends StatelessWidget {
  const ParametresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        restorationId: 'list_settings',
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: const [
          Credits(),
        ],
      )
    );
  }
}


class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        """Programmation : Thomas Diot\nIdée : Clément Marrast\nDonnées : contributeurs du repository Github""",
        style: Theme.of(context).textTheme.titleMedium,
      )
    );
  }
}