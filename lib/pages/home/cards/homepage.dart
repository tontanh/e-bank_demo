import 'dart:convert';
import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/root_page/controler.dart';
import 'package:ebank_demo/pages/home/root_page/root_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return designWidget();
  }

  designWidget() {
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
                                Text('0101 2240 10200 xxxxxxx'),
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
                                        onPressed: () {
                                          setState(() {
                                            showBalance = false;
                                          });
                                        },
                                        child: Text(
                                          'Show balance',
                                          style: TextStyle(color: Colors.black),
                                        ))
                                    : Container(
                                        child: Row(
                                          children: [
                                            Text('100,000.00'),
                                            Text('kip'),
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          )
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
                        onTap: () {},
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
                      close: '',
                      onTap: () {
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
                      onTap: () {},
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
}
