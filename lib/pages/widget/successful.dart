import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/login_root/root.dart';
import 'package:ebank_demo/pages/register/class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AllDone extends StatelessWidget {
  AllDone({Key? key}) : super(key: key);
  final regisController = Get.put(ClassLoginData());
  // get appColor => null;
  String youHave = 'you have'.tr;
  String kip = 'kip'.tr;
  String youAc = 'Your Account'.tr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kMainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: 100,
                child: Image.asset('assets/images/good.png')),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Register Done'.tr,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            Text(
              '$youAc ${regisController.accountNumber}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              '$youHave 5,000,000 $kip',
              style: const TextStyle(fontSize: 18),
            ),
            Container(
                width: 120,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextButton(
                  onPressed: () {
                    Get.offAll(() => const HomePage(),
                        transition: Transition.zoom);
                  },
                  child: Text(
                    'Login'.tr,
                    style: const TextStyle(color: appColor, fontSize: 16),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
