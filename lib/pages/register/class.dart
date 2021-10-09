import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassLoginData extends GetxController {
  RxString uid = 'unknown'.obs;
  RxString userinfo_firstname_la = 'unknown'.obs;
  RxString userinfo_lastname_la = 'unknown'.obs;
  RxString userinfo_firstname_en = 'unknown'.obs;
  RxString userinfo_lastname_en = 'unknown'.obs;
  RxString userinfo_tell = 'unknown'.obs;
  RxString email = 'unknown'.obs;
  RxString password = 'unknown'.obs;
  RxString accountNumber = 'unknown'.obs;
}
