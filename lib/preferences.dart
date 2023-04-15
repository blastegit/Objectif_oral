import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter/material.dart';

class UserPrefs {
  final String validatedExtracts = "validatedExtracts";

  //validated Extracts
  Future<List<String>> getValidatedExtracts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(validatedExtracts)!;
  }
  void setValidatedExtracts(List<String> newValidatedExtracts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(validatedExtracts, newValidatedExtracts);
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
}