import 'package:flutter/material.dart';
import 'data_reader.dart';
import 'extrait_detail_page.dart';

class ExtraitsPage extends StatelessWidget {
  const ExtraitsPage(this.jsonData, {super.key});
  final Map<String, dynamic> jsonData;

  @override
  Widget build(BuildContext context) {
    return ExtraitGrid(jsonData);
  }
}

class ExtraitGrid extends StatelessWidget {
  const ExtraitGrid(this.jsonData, {super.key});
  final Map<String, dynamic> jsonData;

  @override
  Widget build(BuildContext context) {
    List<Widget> listCard = [const AvancementCard()];
    listCard.addAll(data2Card());
    return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: listCard,
        )));
  }

  List<ExtraitCard> data2Card() {
    List<ExtraitCard> r = [];
    //throw jsonData;
    for (ExtraitData extraitData in getAllExtraits(jsonData)) {
      r.add(ExtraitCard(extraitData));
    }
    return r;
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
                    children: [
                      Text('100 %',
                          style: Theme.of(context).textTheme.titleLarge),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: const LinearProgressIndicator(
                            minHeight: 8,
                            value: 0.5,
                          )),
                    ]))));
  }
}

class ExtraitCard extends StatefulWidget {
  final ExtraitData data;
  ExtraitCard(this.data);

  @override
  _ExtraitCardState createState() => _ExtraitCardState();
}

class _ExtraitCardState extends State<ExtraitCard> {
  double _elevation = 1.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _elevation = 8.0;
        });
      },
        onExit: (_) {
        setState(() {
          _elevation = 1.0;
        });
        },
        child: SizedBox(
            width: 150,
            height: 150,
            child: Card(
                elevation: _elevation,
                clipBehavior: Clip.hardEdge,
                child: Stack(children: [
                  Column(
                    children: [
                      Expanded(
                          child: Hero(
                              tag: widget.data.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  "assets/images/gargantua.png",
                                  fit: BoxFit.cover,
                                ),
                              ))),
                      Container(
                        alignment: Alignment.center,
                        child: Text(widget.data.shortTitle,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ],
                  ),
                  InkWell(
                    splashColor: Theme.of(context).colorScheme.primaryContainer,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              extraitDetailPage(context, widget.data),
                        ),
                      );
                    },
                  ),
                ]))));
  }
}
