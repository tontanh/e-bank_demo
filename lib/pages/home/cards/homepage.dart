// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:animate_icons/animate_icons.dart';
import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/root_page/controler.dart';
import 'package:ebank_demo/pages/home/root_page/root_home.dart';
import 'package:ebank_demo/pages/home/statement/statement.dart';
import 'package:ebank_demo/pages/home/transfer/transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'card.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final pageIndex = Get.put(PageNextCard());
  bool showBalance = true;
  String? money, cards;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    loginUser(uid: '${userAcccess.uIdGet}', token: '${userAcccess.jwtGet}');
    cards = userAcccess.cardGet;
    return designWidget(onPress: () {
      setState(() {
        loginUser(uid: '${userAcccess.uIdGet}', token: '${userAcccess.jwtGet}');
        showBalance = false;
      });
    });
  }

  designWidget({VoidCallback? onPress, meme}) {
    // print(stdController.proId);

    return Scaffold(
      bottomNavigationBar: botBox(),
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text('NBB Classic Card'),
        leading: leadingWidget(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 90,
                color: Colors.grey[200],
                child: Stack(
                  children: [
                    showBalance
                        ? Container()
                        : Positioned(
                            bottom: 15,
                            right: 20,
                            child: Icon(
                              Icons.done,
                              color: Colors.grey,
                            ),
                          ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(left: 10),
                            height: 65,
                            width: 100,
                            child: Image.asset(
                              'assets/images/nbb_card.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('$cards'),
                                SizedBox(
                                  height: 5,
                                ),
                                showBalance
                                    ? TextButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    side: BorderSide(
                                                        color: Colors.grey)))),
                                        onPressed: onPress,
                                        child: Text(
                                          'Show balance',
                                          style: TextStyle(color: Colors.black),
                                        ))
                                    : Container(
                                        child: Row(
                                          children: [
                                            Text('$money'),
                                            SizedBox(width: 5),
                                            Text('kip'),
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    showBalance
                        ? Container()
                        : Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showBalance = true;
                                  });
                                },
                                icon: SvgPicture.asset(
                                  'assets/icons/hide_eye.svg',
                                  height: 20,
                                  width: 20,
                                ))),
                  ],
                ),
              ),
            ),
            Positioned(
              // top: 80,
              child: Container(
                margin: const EdgeInsets.only(top: 110),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 17),
                      child: menuItem(
                        icon: SvgPicture.asset(
                          'assets/icons/his_book.svg',
                          height: 63,
                          width: 60,
                          color: appColor,
                        ),
                        text: 'Statement',
                        close: '',
                        onTap: () {
                          Get.to(() => const StatementPage(),
                              transition: Transition.noTransition);
                        },
                      ),
                    ),
                    menuItem(
                      icon: SvgPicture.asset(
                        'assets/icons/card_info.svg',
                        height: 80,
                        width: 60,
                        color: appColor,
                      ),
                      text: 'Card Info',
                      close: '(Close)'.tr,
                      onTap: () {
                        Fluttertoast.showToast(msg: '(Close)'.tr);
                        // Navigator.pushNamed(
                        //     context, OpenAndCloseOfExam.id);
                      },
                    ),
                    menuItem(
                      icon: SvgPicture.asset(
                        'assets/icons/transfer.svg',
                        height: 80,
                        width: 60,
                        color: appColor,
                      ),
                      text: 'Transfer',
                      close: '',
                      onTap: () {
                        Get.off(() => TransferPageAccount(),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    menuItem(
                      icon: SvgPicture.asset(
                        'assets/icons/atm_m.svg',
                        height: 80,
                        width: 60,
                        color: appColor,
                      ),
                      text: 'ATM',
                      close: '(Close)'.tr,
                      onTap: () {
                        Fluttertoast.showToast(msg: '(Close)'.tr);
                      },
                    ),
                    menuItem(
                      icon: SvgPicture.asset(
                        'assets/icons/phone_pay.svg',
                        height: 80,
                        width: 60,
                        color: appColor,
                      ),
                      text: 'Phone Pay',
                      close: '(Close)'.tr,
                      onTap: () {
                        Fluttertoast.showToast(msg: '(Close)'.tr);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell menuItem(
      {Widget? icon,
      String? text,
      close,
      GestureTapCallback? onTap,
      Color color = Colors.blue}) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            // radius: 30,
            // backgroundColor: color,
            child: icon,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$text',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                '$close',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  leadingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              pageIndex.cardPage = '1'.obs;
              // setState(() {
              Get.offAll(() => RootHomePage(),
                  transition: Transition.noTransition);
              // });
            },
            icon: const Icon(Icons.arrow_back)),
      ],
    );
  }

  botBox() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 88,
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    height: 70,
                    width: 70,
                    // color: appColor,
                    child: Image.asset('assets/images/nbb_pay.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<http.Response?> loginUser({String? uid, token}) async {
    var url = Uri.parse(apiShowCard + '$uid');
    // var body =
    //     json.encode({"email": "${userName.text}", "password": "${pwd.text}"});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      var meme = '${responseJson['card_money']}';
      final formatter = NumberFormat("#,###");
      var price = int.parse(meme);
      var moneys = formatter.format(price);

      money = moneys;
    } else if (response.statusCode == 401) {
      // if (Platform.isAndroid) {
      //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // } else if (Platform.isIOS) {
      //   exit(0);
      // }
    } else {
      print('wrong');
    }
  }
}
