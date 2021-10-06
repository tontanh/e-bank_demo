import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ScreenLoadingPage extends StatelessWidget {
  const ScreenLoadingPage({Key? key}) : super(key: key);

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
                child: Image.asset('assets/images/nbb.png')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'NAYOBY BANK'.tr,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Container(
              width: 120,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: LinearProgressIndicator(
                color: appColor,
                backgroundColor: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
