import 'package:ebank_demo/pages/home/root_page/root_home.dart';
import 'package:ebank_demo/pages/language/language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/login_root/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? languageCode;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      // locale: Locale('$languageCode'),
      title: 'E-Banking Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // primaryColor: appColor,
      ),
      debugShowCheckedModeBanner: false,
      // home: const SwitchScreen(),
      home: const HomePage(),
    );
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    languageCode = pref.getString('language');
    languageCode == "en_US" ? languageCode = "1" : languageCode = "2";
    if (languageCode == "1") {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('la', 'LA'));
    }
  }
}
