import 'dart:convert';

import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/cards/card.dart';
import 'package:ebank_demo/pages/home/messages/ms.dart';
import 'package:ebank_demo/pages/home/root_page/controler.dart';
import 'package:ebank_demo/pages/home/setting/settings.dart';
import 'package:http/http.dart' as http;
import 'package:ebank_demo/pages/service/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RootHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  RootHomePage({Key? key}) : super(key: key);

  @override
  _RootHomePageState createState() => _RootHomePageState();
}

class _RootHomePageState extends State<RootHomePage> {
  int currentTab = 0;
  Widget? swapped;
  late List<Widget> screen;
  Widget? currentScreen;

  final PageStorageBucket bucket = PageStorageBucket();
  final getData = Get.put(PageNextCard());
  String? ac_no;
  @override
  void initState() {
    currentScreen = const CardListPage();
    screen = [
      const CardListPage(),
      const MessagePage(),
      const SettingPage(),
      const ServiceScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    getData.ac_no = "${userAcccess.cardGet}".obs;
    getData.token = "${userAcccess.jwtGet}".obs;
    return Scaffold(
        body: currentScreen,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentTab = 0;
                      currentScreen = screen[currentTab];
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bank_card.svg',
                        width: 25,
                        height: 25,
                        color: currentTab == 0 ? appColor : Colors.grey,
                      ),
                      Text(
                        'Cards'.tr,
                        style: TextStyle(
                          color: currentTab == 0 ? appColor : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentTab = 1;
                      currentScreen = screen[currentTab];
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ms2.svg',
                        width: 25,
                        height: 25,
                        color: currentTab == 1 ? appColor : Colors.grey,
                      ),
                      Text(
                        'Messages'.tr,
                        style: TextStyle(
                          color: currentTab == 1 ? appColor : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentTab = 2;
                      currentScreen = screen[currentTab];
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/settings.svg',
                        width: 25,
                        height: 25,
                        color: currentTab == 2 ? appColor : Colors.grey,
                      ),
                      Text(
                        'Settings'.tr,
                        style: TextStyle(
                          color: currentTab == 2 ? appColor : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentTab = 3;
                      currentScreen = screen[currentTab];
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/more.svg',
                        width: 25,
                        height: 25,
                        color: currentTab == 3 ? appColor : Colors.grey,
                      ),
                      Text(
                        'Service'.tr,
                        style: TextStyle(
                          color: currentTab == 3 ? appColor : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
