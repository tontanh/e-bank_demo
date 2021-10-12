import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';

class ClassLoginUsers extends GetxController {
  RxString notiToken = 'unknown'.obs;
}

class DataUserLogins with ChangeNotifier {
  // ignore: prefer_final_fields
  int? _uid;
  int? get uIdGet => _uid;
  set uIdSet(int? newName) {
    _uid = newName;
    notifyListeners();
  }

  String? _jwt;
  String? get jwtGet => _jwt;
  set jwtSet(String? newName) {
    _jwt = newName;
    notifyListeners();
  }

  // String? _notiToken;
  // String? get notiTokenGet => _notiToken;
  // set notiTokenSet(String? newName) {
  //   _notiToken = newName;
  //   notifyListeners();
  // }
}
