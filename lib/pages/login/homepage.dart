// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/language/change_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle dartStyle = dartTextStyleMainColor;
  bool _isObscure = true, btnCheck = false;
  int closeAD = 1;
  double adSize = 80.00;

  // String sName, sPass;
  // final regisController = Get.put(RegisterClass());
  // int idUser;
  // UserLoginStat _user;
  TextEditingController userName = TextEditingController();
  TextEditingController pwd = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            // resizeToAvoidBottomInset: false,
            bottomNavigationBar: bottomBox(),
            body: Stack(
              children: [
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           //   Get.to(() => SinInInfo(),
                //           // transition: Transition.rightToLeft);
                //         },
                //         child: Container(
                //           height: 90,
                //           // width: 200,
                //           color: appColor,
                //           child: Stack(
                //             children: [
                //               Positioned(
                //                   top: 1,
                //                   left: 1,
                //                   child: IconButton(
                //                       onPressed: () {},
                //                       icon: const Icon(
                //                         Icons.close,
                //                         color: appColor,
                //                       )))
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Center(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 40, left: 40),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    height: 130,
                                    width: 130,
                                    child: Image.asset('assets/images/nbb.png'),
                                  ),
                                  Text(
                                    'NAYOBY BANK'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: userName,
                                  onChanged: (value) {
                                    userName.text = value;
                                    userName.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: userName.text.length));
                                  },
                                  // controller: userName,
                                  style: dartStyle.copyWith(height: 2),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    // fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    hintText: 'User'.tr,
                                    hintStyle: const TextStyle(
                                        height: 2, color: Colors.green),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: lightColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: lightColor,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: appColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextField(
                                  onChanged: (value) {
                                    pwd.text = value;
                                  },
                                  style: dartStyle.copyWith(height: 2),
                                  obscureText: _isObscure,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    // fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: appColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                    hintText: 'Password'.tr,
                                    hintStyle: const TextStyle(
                                        height: 1, color: Colors.green),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: lightColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: lightColor,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.vpn_key_rounded,
                                      color: appColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                // ignore: sized_box_for_whitespace
                                Container(
                                  width: 200,
                                  height: 50,
                                  child: AbsorbPointer(
                                    absorbing: btnCheck,
                                    child: TextButton(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          btnCheck == false
                                              ? btnCheck = true
                                              : btnCheck = false;
                                        });
                                        // await getLoginUser();
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.all(5),
                                          child: btnCheck == false
                                              ? Text(
                                                  'Login'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Container(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      const CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white),
                                                  ),
                                                )),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(appColor),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     InkWell(
                                //       onTap: () {
                                //         // Get.to(() => PhoneFineForgot(),
                                //         //     transition: Transition.rightToLeft);
                                //       },
                                //       child: Container(
                                //         child: Text(
                                //           'Forgot Password?',
                                //           style: TextStyle(
                                //             color: Colors.green,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        width: 75,
                        height: 55,
                        decoration: BoxDecoration(
                          color: bgwhite,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: bgwhite),
                        ),
                        margin: const EdgeInsets.only(top: 20, right: 20),
                        child: InkWell(
                          onTap: () {
                            ChangeLanguage().ChangeLanguages(context: context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.language,
                                // color: appColor,
                                size: 30,
                              ),
                              const SizedBox(height: 1),
                              Text(
                                'language'.tr,
                                // style: TextStyle(color: appColor),
                              ),
                            ],
                          ),
                        ))),
              ],
            )),
      ),
    );
  }

  bottomBox() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: adSize,
          color: appColor,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    adSize == 80.00 ? Icons.close : Icons.arrow_upward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      adSize == 80.00 ? adSize = 35.00 : adSize = 80.00;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 55, top: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'welcome'.tr,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'This Application created By tontanh'.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'Created for testig E-BANK Like BCEL One'.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
