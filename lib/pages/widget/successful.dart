import 'package:ebank_demo/pages/login_root/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AllDone extends StatelessWidget {
  const AllDone({Key? key}) : super(key: key);

  get appColor => null;

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
            Container(
                width: 120,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: TextButton(
                  onPressed: () {
                    Get.offAll(() => const HomePage(),
                        transition: Transition.zoom);
                  },
                  child: Text(
                    'Login'.tr,
                    style: TextStyle(color: appColor, fontSize: 16),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
