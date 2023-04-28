import 'dart:developer'; //TODO

import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter/material.dart';
import 'data_reader.dart';
/*
class UserPrefs {
  final String validatedExtrait = "validatedExtracts";

  //validated Extracts
  Future<List<String>> getValidatedExtrais() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(validatedExtrait)!;
  }
  void setValidatedExtraits(List<String> newValidatedExtracts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(validatedExtrait, newValidatedExtracts);
  }
  void addValidatedExtraits(String addString) async {
    List<String> actualValidatedExtracts = await getValidatedExtrais();
    actualValidatedExtracts.add(addString);
    setValidatedExtracts(actualValidatedExtracts);
  }
  void removeValidatedExtraits(String removeString) async {
    List<String> actualValidatedExtracts = await getValidatedExtrais();
    actualValidatedExtracts.remove(removeString);
    setValidatedExtracts(actualValidatedExtracts);
  }

  //validated Extracts
  Future<List<String>> getValidatedExtracts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(validatedExtrait)!;
  }
  void setValidatedExtracts(List<String> newValidatedExtracts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(validatedExtrait, newValidatedExtracts);
  }
  void addValidatedExtracts(String addString) async {
    List<String> actualValidatedExtracts = await getValidatedExtracts();
    actualValidatedExtracts.add(addString);
    setValidatedExtracts(actualValidatedExtracts);
  }
  void removeValidatedExtracts(String removeString) async {
    List<String> actualValidatedExtracts = await getValidatedExtracts();
    actualValidatedExtracts.remove(removeString);
    setValidatedExtracts(actualValidatedExtracts);
  }
}*/

class UserData extends InheritedWidget {
  UserData({
    super.key,
    required super.child,
  });

  static const validatedExtrait = "validatedExtracts";
  static const activatedExtrait = "activatedExtracts";
  static const listExtraits = "listExtraits";

  final Map<String, ExtraitData> _cacheExtraits = {};

  static UserData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserData>();
  }

  static UserData of(BuildContext context) {
    final UserData? result = maybeOf(context);
    assert(result != null, 'No UserData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(UserData oldWidget) => false; //TODO

  ////validated Extraits
  Future<List<String>> getValidatedExtrais() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(validatedExtrait)!;
  }

  void setValidatedExtraits(List<String> newValidatedExtracts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(validatedExtrait, newValidatedExtracts);
  }

  void addValidatedExtraits(String addString) async {
    List<String> actualValidatedExtracts = await getValidatedExtrais();
    actualValidatedExtracts.add(addString);
    setValidatedExtraits(actualValidatedExtracts);
  }

  void removeValidatedExtraits(String removeString) async {
    List<String> actualValidatedExtracts = await getValidatedExtrais();
    actualValidatedExtracts.remove(removeString);
    setValidatedExtraits(actualValidatedExtracts);
  }

  Future<int> nbrValidatedExtraits() async {
    log("ESSAI R2CUPERATION EXTRAITS VALID2S");
    List<String> actualValidatedExtracts = await getValidatedExtrais();
    log("EXTRAITS VALID2S R2CUP2R2S");
    return actualValidatedExtracts.length;
  }

  ////activated Extraits
  Future<List<String>> getActivatedExtrais() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(activatedExtrait)!;
  }

  void setActivatedExtraits(List<String> newValidatedExtracts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(activatedExtrait, newValidatedExtracts);
  }

  void addActivatedExtraits(String addString) async {
    List<String> actualValidatedExtracts = await getActivatedExtrais();
    actualValidatedExtracts.add(addString);
    setActivatedExtraits(actualValidatedExtracts);
  }

  void removeActivatedExtraits(String removeString) async {
    List<String> actualValidatedExtracts = await getActivatedExtrais();
    actualValidatedExtracts.remove(removeString);
    setActivatedExtraits(actualValidatedExtracts);
  }

  ////listExtraits
  Future<List<String>> getListStringExtraits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(listExtraits)!;
  }

  void setListStringExtraits(List<String> newValidatedExtracts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(listExtraits, newValidatedExtracts);
  }

  void addListStringExtraits(String addString) async {
    List<String> actualValidatedExtracts = await getListStringExtraits();
    actualValidatedExtracts.add(addString);
    setListStringExtraits(actualValidatedExtracts);
  }

  void removeListStringExtraits(String removeString) async {
    List<String> actualValidatedExtracts = await getListStringExtraits();
    actualValidatedExtracts.remove(removeString);
    setListStringExtraits(actualValidatedExtracts);
  }

  ExtraitData getExtraitById(String id, [bool load = true]) {
    assert(_cacheExtraits.isNotEmpty,
        "You must load the extraits before calling this function");
    return _cacheExtraits[id]!;
  }

  ExtraitData id(String id) {
    return getExtraitById(id);
  }

  Iterable<String> getAllExtraitId() {
    assert(_cacheExtraits.isNotEmpty,
        "You must load the extraits before calling this function");
    return _cacheExtraits.keys;
  }

  int nbrExtrait() {
    return getAllExtraitId().length;
  }

  Future<void> loadEverything() async {
    await loadExtraitsModifier();
  }

  Future<void> loadExtraitsModifier() async {
    List<ExtraitData> listExtraitData = await loadAllExtraits();
    _cacheExtraits.clear();
    for (ExtraitData extrait in listExtraitData) {
      _cacheExtraits[extrait.id] = extrait;
    }
  }

  Future<List<ExtraitData>> loadAllExtraits() async {
    List<ExtraitData> listExtraitData = [];
    List<String> listYearData = await getListStringExtraits();
    assert(listYearData.isNotEmpty,
        "There is no json in the preferences (listYearData is empty)");
    for (String stringYearData in listYearData) {
      Map<String, dynamic> jsonYearData = getJsonDataFromText(stringYearData);
      listExtraitData.addAll(getAllExtraits(jsonYearData));
    }
    log("extraits loaded (long ${listExtraitData.length.toString()})");
    assert(listExtraits.isNotEmpty,
        "There is no extraitData in all the json YearData given (listExtraits is empty)");
    return listExtraitData;
  }
}

/*
class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<List<String>> validatedExtrait;

  @override
  void initState() {
    super.initState();

  }
}*/
