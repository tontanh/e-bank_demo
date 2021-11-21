// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ebank_demo/main.dart';
import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/home/transfer/class.dart';
import 'package:ebank_demo/pages/home/transfer/transfer_amount.dart';
import 'package:ebank_demo/pages/login/homepage.dart';
import 'package:ebank_demo/pages/login_root/root.dart';
import 'package:ebank_demo/pages/switch_page/screenloading.dart';
import 'package:ebank_demo/pages/switch_page/time_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckQrCodeReal extends StatefulWidget {
  final String accNumC;
  const CheckQrCodeReal({Key? key, required this.accNumC}) : super(key: key);

  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<CheckQrCodeReal> {
  TextEditingController accTxt = TextEditingController();
  final uidRe = Get.put(TransferClass());
  String? token, meId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    token = '${userAcccess.jwtGet}';
    meId = '${userAcccess.uIdGet}';
    return FutureBuilder(
      future: accSelect(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //   Get.to(() => const TranAmountPage(),
          //       transition: Transition.rightToLeft);
        } else {
          ScreenLoadingPage();
        }
        return ScreenLoadingPage();
      },
    );
  }

  Future<http.Response?> accSelect() async {
    String acText;
    acText = '${widget.accNumC}';
    print('====================' + acText);
    var url = Uri.parse(apiSelectCard + acText);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      String uids = "${responseJson["user_id"]}";
      String cardRe = "${responseJson["card_number"]}";
      String money = "${responseJson["card_money"]}";
      uidRe.uidReceiver = "$uids".obs;
      uidRe.cardNumber = "$cardRe".obs;
      uidRe.moneys = "$money".obs;
      await getUserInfo(receiId: uids);
    } else {
      Get.back();
      Fluttertoast.showToast(msg: 'wrong card');
      // Future.delayed(Duration(seconds: 1), () {});
    }
  }

  Future<http.Response?> getUserInfo({String? receiId}) async {
    var url = Uri.parse(apiGetUserInfo + receiId!);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      String name = "${responseJson["userinfo_firstname_en"]}";
      String last = "${responseJson["userinfo_lastname_en"]}";
      // print(name + last);
      uidRe.namRe = "$name".obs;
      uidRe.lastRe = "$last".obs;
      await getTokenMe();
      await getTokenYou(uids: receiId);
      await acMe();
    } else {
      Fluttertoast.showToast(msg: 'something went wrong');
      // Future.delayed(Duration(seconds: 1), () {});
    }
  }

  Future<http.Response?> acMe() async {
    var url = Uri.parse(apiGetUserInfo + meId!);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      String nameME = "${responseJson["userinfo_firstname_en"]}";
      String lastME = "${responseJson["userinfo_lastname_en"]}";
      uidRe.namMe = "$nameME".obs;
      uidRe.lastMe = "$lastME".obs;
      Get.to(() => const TranAmountPage(), transition: Transition.rightToLeft);
    } else {
      Fluttertoast.showToast(msg: 'something went wrong');
      // Future.delayed(Duration(seconds: 1), () {});
    }
  }

  Future<http.Response?> getTokenMe() async {
    var url = Uri.parse(apiNotiToken + meId!);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      String notiToken = "${responseJson["noti_token"]}";
      uidRe.tokenNotiMe = "$notiToken".obs;
      // print("me id ===" + notiToken);
    } else {
      Fluttertoast.showToast(msg: 'notification went wrong 1');
      // Future.delayed(Duration(seconds: 1), () {});
    }
  }

  Future<http.Response?> getTokenYou({String? uids}) async {
    var url = Uri.parse(apiNotiToken + uids!);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      String notiToken = "${responseJson["noti_token"]}";
      // print("you id ===" + notiToken);
      uidRe.tokenNotiYou = "$notiToken".obs;
    } else {
      Fluttertoast.showToast(msg: 'notification went wrong 2');
      // Future.delayed(Duration(seconds: 1), () {});
    }
  }
}
