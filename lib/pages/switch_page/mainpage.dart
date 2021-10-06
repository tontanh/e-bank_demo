// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'screenloading.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({Key? key}) : super(key: key);

  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  // String sName, sPass, sToken, sId;
  // final regisController = Get.put(RegisterClass());

  @override
  Widget build(BuildContext context) {
    return ScreenLoadingPage();
    //  FutureBuilder(
    //   future: getData(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       // Future.delayed(Duration(seconds: 1), () {
    //       getLoginUser(name: sName, pass: sPass);
    //       // });
    //       // print(sName + sPass);
    //     }
    //     //  else {
    //     // Get.offAll(() => SignInScreen(), transition: Transition.zoom);

    //     // }
    //     return loadingWidget();
    //   },
    // );
  }

  // getLoginUser({String name, pass}) async {
  //   try {
  //     var url = Uri.parse(apiLogin);
  //     var body = json.encode({"name": name, "password": pass});
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //     };
  //     final response =
  //         await http.post(url, body: body, headers: headers).timeout(
  //       Duration(seconds: 10),
  //       onTimeout: () {
  //         Get.to(() => ErrorPages(), transition: Transition.zoom);
  //         return null;
  //       },
  //     );
  //     final responseJson = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       int id = responseJson['id'];
  //       //save get
  //       regisController.id = id.obs;
  //       regisController.token = '${responseJson['token']}'.obs;
  //       regisController.userName = '$name'.obs;
  //       regisController.pwd = '$pass'.obs;
  //       //save local
  //       SharedPreferences pref = await SharedPreferences.getInstance();
  //       pref.setString('name', '$name');
  //       pref.setString('pwd', '$pass');
  //       pref.setString('token', '${responseJson['token']}');
  //       pref.setInt('id', id);
  //       //delay

  //       Get.offAll(() => RootApp(), transition: Transition.zoom);
  //     } else {
  //       Get.offAll(() => SignInScreen(), transition: Transition.zoom);

  //       // Future.delayed(Duration(seconds: 1), () {
  //       // });
  //     }
  //   } catch (e) {
  //     if (e is SocketException) {
  //       print("SocketException");
  //       Get.to(() => ErrorPages(), transition: Transition.zoom);
  //     } else if (e is TimeoutException) {
  //       print("TimeoutException");
  //       Get.to(() => ErrorPages(), transition: Transition.zoom);
  //     } else {
  //       Get.to(() => ErrorPages(), transition: Transition.zoom);
  //     }
  //   }
  // }

  // Future<void> getData() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   sName = pref.getString('name');
  //   sPass = pref.getString('pwd');
  //   sToken = pref.getString('token');
  //   sId = pref.getString('id');
  //   // setState(() {});
  // }
}
