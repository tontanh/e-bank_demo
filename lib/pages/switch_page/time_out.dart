import 'package:ebank_demo/pages/switch_page/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ErrorPages extends StatefulWidget {
  const ErrorPages({Key? key}) : super(key: key);

  @override
  _ErrorPagesState createState() => _ErrorPagesState();
}

class _ErrorPagesState extends State<ErrorPages> {
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
              "assets/icons/nowifi.svg",
              width: 130,
              height: 130,
            ),
            SizedBox(height: 5),
            Text(
              'Could not connect to server',
            ),
            TextButton(
              // style: TextButton.styleFrom(backgroundColor: Colors.grey[300]),
              onPressed: () {
                Get.off(() => SwitchScreen(), transition: Transition.zoom);
              },
              child: Text(
                'try again',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
