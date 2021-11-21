import 'dart:convert';

import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/root_page/root_home.dart';
import 'package:ebank_demo/pages/login_root/constant.dart';
import 'package:ebank_demo/pages/login_root/root.dart';
import 'package:ebank_demo/pages/register/back_button.dart';
import 'package:ebank_demo/pages/register/next_button.dart';
import 'package:ebank_demo/pages/widget/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String errorMSG = '';
  var pass1, pass2, meId;

  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    meId = '${userAcccess.uIdGet}';
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/password.svg",
                              color: appColor,
                              width: 150,
                              height: 150,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New Password',
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                        Text(
                          'Password'.tr,
                          style: TextStyle(fontSize: 18),
                        ),
                        TextField(
                          onChanged: (value) {
                            pass1 = value;
                          },
                          // style: dartStyle.copyWith(height: 2),
                          // keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            hintText: 'New Password'.tr,
                            hintStyle: TextStyle(height: 2, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: appColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: appColor,
                              ),
                            ),
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Colors.black,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Retry Password'.tr,
                          style: TextStyle(fontSize: 18),
                        ),
                        TextField(
                          onChanged: (value) {
                            pass2 = value;
                          },
                          // style: dartStyle.copyWith(height: 2),
                          // keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            hintText: 'Enter password again'.tr,
                            hintStyle: TextStyle(height: 2, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: appColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: appColor,
                              ),
                            ),
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Colors.black,
                            // ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          errorMSG,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: BackButtons(
                    icon: Icons.close,
                    onPressed: () {
                      Get.offAll(() => RootHomePage(),
                          transition: Transition.noTransition);
                      Get.snackbar(
                        "Alert",
                        "Password is not change",
                      );
                    }),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () async {
                    if (pass1 == null ||
                        pass1 == '' ||
                        pass2 == null ||
                        pass2 == '') {
                      setState(() {
                        errorMSG = 'Enter password';
                      });
                    } else {
                      if (pass1.length >= 6) {
                        if (pass1 == pass2) {
                          setState(() {
                            errorMSG = '';
                          });
                          await resetPassword();
                        } else {
                          setState(() {
                            errorMSG = 'Password not match';
                          });
                        }
                      } else {
                        setState(() {
                          errorMSG = 'at least 6';
                        });
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    color: appColor,
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            "Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response?> resetPassword() async {
    var url = Uri.parse(apiChangePass);
    var body = json.encode({"user_id": "$meId", "password": "$pass1"});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      // print("done==");
      Get.offAll(() => const HomePage(), transition: Transition.noTransition);
      Get.snackbar(
        "Alert",
        "Password is changed",
      );
    } else {
      setState(() {
        errorMSG = 'something went wrong';
      });
    }
  }
}
