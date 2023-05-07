import 'dart:developer'; //TODO

import 'package:flutter/material.dart';
import 'package:objectif_oral/preferences.dart';
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
    return SizedBox(
        width: 308, //ne pas oublier la largeur de l'espacement
        height: 150,
        child: Card(
            clipBehavior: Clip.hardEdge,
            child: Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      PourcentageText(),
                      BarreDeProgres(),
                    ]))));
  }
}

class BarreDeProgres extends StatefulWidget {
  const BarreDeProgres({Key? key}) : super(key: key);

  @override
  _BarreDeProgresState createState() => _BarreDeProgresState();
}

class _BarreDeProgresState extends State<BarreDeProgres>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double progres = 0.0;
  bool needInitialisation = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: progres,
      end: progres,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuad,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _refresh(UserData userData) {
    double nouvProgres =
        (userData.nbrValidatedExtraits()) / (userData.nbrExtrait());
    _controller.reset();
    setState(() {
      progres = nouvProgres;
      _animation = Tween<double>(
        begin: progres,
        end: nouvProgres,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuad,
      ));
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (needInitialisation) {
      setState(() {
        needInitialisation = false;
        progres = UserData.of(context).nbrValidatedExtraits() /
            UserData.of(context).nbrExtrait();
      });
    }
    UserData.of(context).notifyMeIfValidatedChange(_refresh);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        minHeight: 8,
        value: _animation.value,
      ),
    );
  }
}

class PourcentageText extends StatefulWidget {
  const PourcentageText({Key? key}) : super(key: key);

  @override
  _PourcentageTextState createState() => _PourcentageTextState();
}

class _PourcentageTextState extends State<PourcentageText> {
  double progres = 0.0;
  bool needInitialisation = true;

  void _refresh(UserData userData) {
    setState(() {
      progres = UserData.of(context).nbrValidatedExtraits() /
          UserData.of(context).nbrExtrait();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (needInitialisation) {
      setState(() {
        needInitialisation = false;
        progres = UserData.of(context).nbrValidatedExtraits() /
            UserData.of(context).nbrExtrait();
      });
    }
    UserData.of(context).notifyMeIfValidatedChange(_refresh);
    return Text('${progres * 100} %',
        style: Theme.of(context).textTheme.titleLarge);
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
  final GlobalKey _globalKey = GlobalKey();
  double _coinsRonds = 17.5;
  double _elevation = 1.0;

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
          if (!UserData.of(context).isValidated(widget.id)) {
          _changerCoinsRonds(30.0);
          }
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
                      elevation: _elevation,
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
                        UserData.of(context).isValidated(widget.id) == true
                            ? Stack(
                          children: [
                            Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer
                                  .withAlpha(220),
                            ),
                            Center(
                                child: Icon(
                                  Icons.done_rounded,
                                  size: 80,
                                  color: Theme.of(context).colorScheme.secondary,
                                )),
                          ],
                        )
                            : Container(),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ExtraitDetailPage(
                                    id: widget.id,
                                  ),
                                ),
                              );
                            },
                            onLongPressStart:
                                (LongPressStartDetails details) async {
                              final screenSize = MediaQuery.of(context).size;
                              await showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(
                                  details.globalPosition.dx,
                                  details.globalPosition.dy,
                                  screenSize.width - details.globalPosition.dx,
                                  screenSize.height - details.globalPosition.dy,
                                ),
                                items: [
                                  PopupMenuItem(
                                      onTap: () {
                                        if (UserData.of(context)
                                            .isValidated(widget.id)) {
                                          UserData.of(context)
                                              .removeValidatedExtraits(
                                                  widget.id);
                                          log("${widget.id} enlevé des extraits lus");
                                          setState(() {});
                                        } else {
                                          UserData.of(context)
                                              .addValidatedExtraits(widget.id);
                                          log("${widget.id} ajouté aux extraits lus");
                                          setState(() {});
                                        }
                                      },
                                      child: UserData.of(context)
                                                  .isValidated(widget.id) ==
                                              true
                                          ? const Text("Dé-valider l'extrait")
                                          : const Text("Valider l'extrait")),
                                ],
                                elevation: 8.0,
                              );
                            },
                            child: InkWell(
                              key: _globalKey,
                              splashColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            )),
                      ])));
            }));
  }
}
