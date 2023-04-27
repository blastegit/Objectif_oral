import 'dart:developer'; //TODO

import 'package:flutter/material.dart';
import 'package:objectif_oral/preferences.dart';
import 'data_reader.dart';
import 'extrait_detail_page.dart';

class ExtraitsChoixPage extends StatelessWidget {
  const ExtraitsChoixPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExtraitGrid();
  }
}

class ExtraitGrid extends StatelessWidget {
  const ExtraitGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> listCard = [const AvancementCard()];
    log("UserData.of(context).getAllExtraitId() : ${UserData.of(context).getAllExtraitId()}");
    for (String id in UserData.of(context).getAllExtraitId()) {
      listCard.add(ExtraitCard(id));
    }
    return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: listCard,
        )));
  }
}

class AvancementCard extends StatelessWidget {
  const AvancementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: UserData.of(context).nbrValidatedExtraits(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text("erreur lors de UserData.of(context).nbrValidatedExtraits() erreur : ${snapshot.error}"),
              );
            } else {
              if (snapshot.data == null) {
                throw "UserData.of(context).nbrValidatedExtraits() return null";
              } else {
                double pourcentage =
                    snapshot.data! / UserData.of(context).nbrExtrait();
                return SizedBox(
                    width: 308, //ne pas oublier la largeur de l'espacement
                    height: 150,
                    child: Card(
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('${pourcentage * 100} %',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: LinearProgressIndicator(
                                        minHeight: 8,
                                        value: pourcentage,
                                      )),
                                ]))));
              }
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class ExtraitCard extends StatefulWidget {
  final String id;
  const ExtraitCard(this.id, {super.key});

  @override
  _ExtraitCardState createState() => _ExtraitCardState();
}

class _ExtraitCardState extends State<ExtraitCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _coinsRonds = 17.5;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: _coinsRonds,
      end: _coinsRonds,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changerCoinsRonds(double coinsRonds) {
    _controller.reset();
    _animation = Tween<double>(
      begin: _coinsRonds,
      end: coinsRonds,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuad,
      ),
    );
    _controller.forward();
    setState(() {
      _coinsRonds = coinsRonds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) {
          _changerCoinsRonds(30.0);
        },
        onExit: (_) {
          _changerCoinsRonds(17.5);
        },
        child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return SizedBox(
                  width: 150,
                  height: 150,
                  child: Card(
                      elevation: 1,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17.5),
                      ),
                      child: Stack(children: [
                        Column(
                          children: [
                            Expanded(
                                child: Hero(
                                    tag: widget.id,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          _animation.value),
                                      child: Image.asset(
                                        "assets/images/gargantua.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ))),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                  UserData.of(context).id(widget.id).shortTitle,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                            ),
                          ],
                        ),
                        InkWell(
                          splashColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ExtraitDetailPage(
                                  id: widget.id,
                                ),
                              ),
                            );
                          },
                        ),
                      ])));
            }));
  }
}
