import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TransferClass extends GetxController {
  RxString uidReceiver = '0'.obs;
  // ignore: non_constant_identifier_names
  RxString cardNumber = '0'.obs;
  RxString moneys = '0'.obs;
  RxString namRe = '0'.obs;
  RxString lastRe = '0'.obs;
  RxString namMe = '0'.obs;
  RxString lastMe = '0'.obs;
  RxString tokenNotiMe = '0'.obs;
  RxString tokenNotiYou = '0'.obs;
}
