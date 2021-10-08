import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassLogin extends GetxController {
  RxString uid = 'unknown'.obs;
  RxString jwt = 'unknown'.obs;
}
