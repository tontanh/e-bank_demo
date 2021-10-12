// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ebank_demo/main.dart';
import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/login/homepage.dart';
import 'package:ebank_demo/pages/login_root/root.dart';
import 'package:ebank_demo/pages/switch_page/time_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'screenloading.dart';

class SwitchScreen extends StatefulWidget {
  final String notiToken;
  const SwitchScreen({Key? key, required this.notiToken}) : super(key: key);

  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  // String sName, sPass, sToken, sId;
  // final regisController = Get.put(RegisterClass());
  final notiData = Get.put(ClassLoginUsers());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notiData.notiToken = '${notiToken}'.obs;

    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Future.delayed(Duration(seconds: 1), () {
          getLoginUser();
          // });
          // print(sName + sPass);
        } else {
          getLoginUser();
        }
        return ScreenLoadingPage();
      },
    );
  }

  getLoginUser() async {
    try {
      var url = Uri.parse(apiServer + "on");
      // print(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await http.get(url, headers: headers).timeout(
        Duration(seconds: 5),
        onTimeout: () {
          Get.to(() => const ErrorPages(), transition: Transition.zoom);
          // ignore: null_check_always_fails
          return null!;
        },
      );
      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        Future.delayed(Duration(seconds: 2), () {
          Get.off(() => HomePage(), transition: Transition.zoom);
        });
      } else {
        Get.to(() => const ErrorPages(), transition: Transition.zoom);
      }
    } catch (e) {
      if (e is SocketException) {
        print("SocketException");
        Get.to(() => const ErrorPages(), transition: Transition.zoom);
      } else if (e is TimeoutException) {
        print("TimeoutException");
        Get.to(() => const ErrorPages(), transition: Transition.zoom);
      } else {
        Get.to(() => const ErrorPages(), transition: Transition.zoom);
      }
    }
  }

  Future<void> getData() async {}
}
