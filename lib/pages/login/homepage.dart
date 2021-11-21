// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';

import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/root_page/controler.dart';
import 'package:ebank_demo/pages/home/root_page/root_home.dart';
import 'package:ebank_demo/pages/language/change_language.dart';
import 'package:ebank_demo/pages/test/testpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'class.dart';
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
  final regisData = Get.put(PageNextCard());
  final notiData = Get.put(ClassLoginUsers());
  bool memPass = true;
  String? jwts;
  String? cards;
  int? uids;

  // String sName, sPass;
  // int idUser;
  // UserLoginStat _user;
  TextEditingController userName = TextEditingController();
  TextEditingController pwd = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getEmailData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcess = Provider.of<DataUserLogins>(context);

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
                                  // onChanged: (value) {
                                  //   userName.text = value;
                                  //   userName.selection =
                                  //       TextSelection.fromPosition(TextPosition(
                                  //           offset: userName.text.length));
                                  // },
                                  // controller: userName,
                                  style: dartStyle.copyWith(height: 2),
                                  keyboardType: TextInputType.emailAddress,
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
                                      Icons.email,
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
                                const SizedBox(height: 5),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Checkbox(
                                              // checkColor: appColor,
                                              side: const BorderSide(
                                                // ======> CHANGE THE BORDER COLOR HERE <======
                                                color: Colors.grey,
                                                // Give your checkbox border a custom width
                                                width: 1.5,
                                              ),
                                              activeColor: appColor,
                                              value: memPass,
                                              onChanged: (_) {
                                                setState(() {
                                                  memPass
                                                      ? memPass = false
                                                      : memPass = true;
                                                });
                                              }),
                                          Text(
                                            'Remember Email'.tr,
                                            style: const TextStyle(
                                              color: appColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                                        // ignore: avoid_print

                                        // await getLoginUser();
                                        await buttonPress();
                                        userAcess.emailSet = userName.text;
                                        userAcess.jwtSet = jwts;
                                        userAcess.uIdSet = uids;
                                        userAcess.cardSet = cards;
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
                    adSize == 80.00 ? Icons.arrow_downward : Icons.arrow_upward,
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
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'This Application created By tontanh'.tr,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'Created for testig E-BANK Like BCEL One'.tr,
                          style: const TextStyle(
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

  buttonPress() async {
    String uName = userName.text;
    // print(uName);
    if (memPass) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('uEmail', uName);
    }
    await loginUser();
  }

  getEmailData() async {
    String? uE;
    SharedPreferences pref = await SharedPreferences.getInstance();

    uE = pref.getString('uEmail');
    uE == null || uE == '' || uE.isEmpty ? uE = '' : uE = uE;
    userName.text = uE;
  }

  Future<http.Response?> loginUser() async {
    var url = Uri.parse(apiLogin);
    var body =
        json.encode({"email": "${userName.text}", "password": "${pwd.text}"});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(url, body: body, headers: headers);
    final responseJson = json.decode(response.body);
    if (userName == null ||
        userName.text == '' ||
        pwd.text == '' ||
        pwd == null) {
      ShowToast().showLoginFailed(msg: 'Please input User Name or Password');
      setState(() {
        btnCheck = false;
      });
    } else {
      if (response.statusCode == 200) {
        int id = responseJson['id'];
        String jwt = responseJson['token'];
        uids = id;
        jwts = jwt;
        await getTokenNotification(uid: id);
      } else {
        Future.delayed(Duration(seconds: 1), () {
          // ShowDialogs().alertWarning(msg: 'User Name or Password incorrect');
          ShowToast().showLoginFailed(msg: 'User Name or Password incorrect');
          setState(() {
            btnCheck = false;
          });
        });
      }
    }
  }

  Future<http.Response?> getTokenNotification({int? uid}) async {
    String token = '${notiData.notiToken}';
    var url = Uri.parse(apiGetNotiToken);
    var body = json.encode({"user_id": "$uid", "noti_token": token});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      await cardShow(uid: uid);
    } else {
      // ShowDialogs().alertWarning(msg: 'User Name or Password incorrect');
      ShowToast().showLoginFailed(msg: 'Something went wrong');
      setState(() {
        btnCheck = false;
      });
    }
  }

  Future<http.Response?> cardShow({int? uid}) async {
    var url = Uri.parse(apiShowCard + '$uid');
    // var body =
    //     json.encode({"email": "${userName.text}", "password": "${pwd.text}"});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      cards = responseJson['card_number'];
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(() => RootHomePage(), transition: Transition.zoom);
        setState(() {
          btnCheck = false;
        });
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        // ShowDialogs().alertWarning(msg: 'User Name or Password incorrect');
        ShowToast().showLoginFailed(msg: 'Something went wrong');
        setState(() {
          btnCheck = false;
        });
      });
    }
  }
}
