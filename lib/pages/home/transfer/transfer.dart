import 'dart:convert';

import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/cards/homepage.dart';
import 'package:ebank_demo/pages/home/transfer/transfer_amount.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'class.dart';

class TransferPageAccount extends StatefulWidget {
  const TransferPageAccount({Key? key}) : super(key: key);
  @override
  _TransferPageAccountState createState() => _TransferPageAccountState();
}

class _TransferPageAccountState extends State<TransferPageAccount> {
  TextEditingController accTxt = TextEditingController();
  final uidRe = Get.put(TransferClass());
  String? token, meId;
  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    token = '${userAcccess.jwtGet}';
    meId = '${userAcccess.uIdGet}';
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Receivers Account"),
          backgroundColor: appColor,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Get.off(() => CardPage(), transition: Transition.leftToRight);
            },
          ),
        ),
        body: Stack(
          children: [
            topAccount(),
            nextButton(),
          ],
        ),
      ),
    );
  }

  topAccount() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: Colors.grey[200],
        height: 110,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                // crossAxisAlignment: ,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Add receivers account'),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    // color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 70,
                    child: TextField(
                        controller: accTxt,
                        maxLength: 20,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Account Number",
                          // border: BorderSide.none,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  nextButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () async {
          if (accTxt == null || accTxt == "") {
            Fluttertoast.showToast(msg: 'Please input number');
          } else {
            if (accTxt.text.length >= 20) {
              await accSelect();
            } else {
              Fluttertoast.showToast(msg: 'number length is 20');
            }
          }
        },
        child: Container(
          color: appColor,
          height: 60,
          child: Stack(
            children: [
              Center(
                child: Text(
                  "Next",
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
    );
  }

  Future<http.Response?> accSelect() async {
    String acText;
    acText = accTxt.text;
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
}
