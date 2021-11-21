import 'dart:convert';

import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/register/back_button.dart';
import 'package:ebank_demo/pages/register/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pin_put/pin_put.dart';

import 'class.dart';
import 'reset_pass.dart';

class PhoneCodeForget extends StatefulWidget {
  const PhoneCodeForget({Key? key}) : super(key: key);

  @override
  _PhoneCodesState createState() => _PhoneCodesState();
}

class _PhoneCodesState extends State<PhoneCodeForget> {
  // final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  // TextEditingController phone = TextEditingController();
  TextEditingController pinNum = TextEditingController();
  // String? verifyPhone;
  final controlAuths = Get.put(ClassAuthPhone());

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.grey[300],
    borderRadius: BorderRadius.circular(5.0),
  );
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/password.svg",
                        width: 130,
                        height: 130,
                        color: appColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'OPT',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  textInputPwd(),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: BackButtons(
                  onPressed: () {
                    navigator!.pop();
                  },
                  icon: Icons.arrow_back,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: NextButtons(onPressed: () async {
                  await phoneGetCode();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  textInputPwd() {
    return Container(
      margin: EdgeInsets.only(right: 25, left: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.all(10.0),
      child: PinPut(
        withCursor: true,
        fieldsCount: 6,
        //  preFilledWidget: FlutterLogo(),
        textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
        eachFieldWidth: 30.0,
        eachFieldHeight: 60.0,
        // onSubmit: (String pin) => _showSnackBar(pin),
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration:
            pinPutDecoration.copyWith(color: Colors.black54),
        followingFieldDecoration: pinPutDecoration,
        onSubmit: (pin) async {
          pinNum.text = pin;
        },
      ),
    );
  }

  Future<http.Response?> phoneGetCode() async {
    String phone = "${controlAuths.phone}";
    var url =
        Uri.parse(apiReceivedCode + "?phonenumber=$phone&code=${pinNum.text}");
    // print(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      // print("done===");
      Get.offAll(() => const ResetPasswordPage(),
          transition: Transition.rightToLeft);
    } else {
      Fluttertoast.showToast(msg: "something went wrong");
    }
  }
}
