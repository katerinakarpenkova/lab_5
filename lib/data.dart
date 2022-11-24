import 'package:flutter/cupertino.dart';

class Data with ChangeNotifier{
  String _name = "Кати";
  String get getName => _name;

  String _date = "27.12.2022";
  String get getDate => _date;

  String _about = "Кати";
  String get getAbout => _about;
  void changeString(String newString){
    _name = newString;
    _date = newString;
    _about = newString;
    notifyListeners();
  }
}