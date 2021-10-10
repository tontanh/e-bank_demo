import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class ClassLoginUsers extends GetxController {
//   RxString uid = 'unknown'.obs;
//   RxString jwt = 'unknown'.obs;

//   @override
//   void onClose() {
//     print("onClose testttt");

//     super.onClose();
//   }
// }

import 'package:flutter/material.dart';

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
}
