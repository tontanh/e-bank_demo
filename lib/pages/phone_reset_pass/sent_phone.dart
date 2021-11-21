import 'dart:convert';

import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/root_page/root_home.dart';
import 'package:ebank_demo/pages/register/back_button.dart';
import 'package:ebank_demo/pages/register/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'class.dart';
import 'get_code_sms_auth.dart';

class PhoneSentCodeToServer extends StatefulWidget {
  const PhoneSentCodeToServer({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PhoneSentCodeToServer> {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'LA';
  PhoneNumber number = PhoneNumber(isoCode: 'LA');
  final TextEditingController phoneNumber = TextEditingController();
  final controlAuth = Get.put(ClassAuthPhone());

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
            Form(
              // key: formKey,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/phone.svg",
                          width: 100,
                          height: 100,
                          color: appColor,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                        phoneNumber.text = number.phoneNumber!;
                      },
                      // onInputValidated: (bool value) {
                      //   print(value);
                      // },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),

                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: controller,
                      formatInput: false,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),

                      autoFocus: false,
                      hintText: "20xxxxxxxx",
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: BackButtons(
                onPressed: () {
                  Get.off(() => RootHomePage(),
                      transition: Transition.noTransition);
                },
                icon: Icons.close,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: NextButtons(onPressed: () async {
                await phoneSents(tell: phoneNumber.text);
              }),
            ),
          ],
        )),
      ),
    );
  }

  Future<http.Response?> phoneSents({String? tell}) async {
    var url = Uri.parse(apiSentCode + "?phonenumber=$tell&channel=sms");
    controlAuth.phone = "$tell".obs;
    print(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      Get.to(() => const PhoneCodeForget(), transition: Transition.rightToLeft);
    } else {
      Fluttertoast.showToast(msg: "something went wrong");
    }
  }
}
