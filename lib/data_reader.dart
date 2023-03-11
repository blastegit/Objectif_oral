import 'dart:convert';
import 'package:flutter/services.dart';


Future<Map<String, dynamic>> getJsonData(String pathToFile) async {
  String contents = await rootBundle.loadString(pathToFile);
  return await json.decode(contents);
}

Future<String> getFileText(String pathToFile) async {
  return await rootBundle.loadString(pathToFile);
}

Map<String, dynamic> getJsonDataFromText(String? text) {
  if (text == null) {
    throw "text null pas possible à lire en json";
  } else {
    return json.decode(text);
  }
}

List<ExtraitData> getAllExtraits(Map<String, dynamic> jsonData) {
  List<ExtraitData> liste = [];
  for (Map<String, dynamic> tExtrait in jsonData['extraits']) {
    liste.add(ExtraitData.fromJsonExtrait(tExtrait));
  }
  return liste;
}

/*
List<String> getAllId(jsonData) {
  List<String> ids = [];
  for (Map extrait in jsonData['extraits']) {
    ids.add(extrait[])
  }
  return ids;
}*/

class ExtraitData {
  final String id;
  final String fullTitle;
  final String shortTitle;
  final String bodyText;
  final String analyse;
  final String imageKey;

  ExtraitData(this.id, this.fullTitle, this.shortTitle, this.bodyText, this.analyse, this.imageKey);

  factory ExtraitData.fromJsonAndId(Map<String, dynamic> jsonData, String id) {
    Map<String, dynamic>? extrait;
    for (Map<String, dynamic> tExtrait in jsonData['extraits']) {
      if (tExtrait['id'] == id) {
        extrait = tExtrait;
      }
    }

    if (extrait == null) {
      throw "id $id non trouvé";
    } else {
      return ExtraitData.fromJsonExtrait(extrait);
    }
  }

  factory ExtraitData.fromJsonExtrait(Map<String, dynamic> jsonDataExtrait) {
      // note the explicit cast to String
      // this is required if robust lint rules are enabled
      final id = jsonDataExtrait['id'] as String;
      final fullTitle = jsonDataExtrait['full_title'] as String;
      final shortTitle = jsonDataExtrait['short_title'] as String;
      final bodyText = jsonDataExtrait['body_text'] as String;
      final analyse = jsonDataExtrait['analyse'] as String;
      final imageKey = jsonDataExtrait['image_key'] as String;
      return ExtraitData(id,
          fullTitle,
          shortTitle,
          bodyText,
          analyse,
          imageKey
          );
    }
  }

void main() async {
  Map<String, dynamic> data = await getJsonData("assets/yearData/yearData2021.json");
  ExtraitData extraitClass = ExtraitData.fromJsonAndId(data, '2021.GdR');
  print(extraitClass.shortTitle);
}