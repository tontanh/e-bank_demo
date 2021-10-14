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

  String? _email;
  String? get emailGet => _email;
  set emailSet(String? newName) {
    _email = newName;
    notifyListeners();
  }

  String? _card;
  String? get cardGet => _card;
  set cardSet(String? newName) {
    _card = newName;
    notifyListeners();
  }
}
