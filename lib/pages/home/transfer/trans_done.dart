import 'package:ebank_demo/main.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/root_page/root_home.dart';
import 'package:ebank_demo/pages/switch_page/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TransDone extends StatefulWidget {
  const TransDone({Key? key}) : super(key: key);

  @override
  _ErrorPagesState createState() => _ErrorPagesState();
}

class _ErrorPagesState extends State<TransDone> {
  @override
  Widget build(BuildContext context) {
    return errorWidget();
  }

  errorWidget() {
    return Scaffold(
      // backgroundColor: kMainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/boom.svg",
              width: 130,
              height: 130,
              color: appColor,
            ),
            const SizedBox(height: 5),
            const Text(
              'Transfer Successful',
            ),
            TextButton(
              // style: TextButton.styleFrom(backgroundColor: Colors.grey[300]),
              onPressed: () {
                Get.offAll(() => RootHomePage(),
                    transition: Transition.noTransition);
              },
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
