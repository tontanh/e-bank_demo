import 'dart:convert';

import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/transfer/trans_done.dart';
import 'package:ebank_demo/pages/login/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'class.dart';

class TranAmountPage extends StatefulWidget {
  const TranAmountPage({Key? key}) : super(key: key);
  @override
  _TransferPageAccountState createState() => _TransferPageAccountState();
}

class _TransferPageAccountState extends State<TranAmountPage> {
  final infoTransfer = Get.put(TransferClass());
  TextEditingController moneyInput = TextEditingController();
  TextEditingController detailAdd = TextEditingController();
  int? moneys;
  String? money;
  String? token, meId, cardMe;
  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    token = '${userAcccess.jwtGet}';
    meId = '${userAcccess.uIdGet}';
    cardMe = '${userAcccess.cardGet}';
    money = "${infoTransfer.moneys}";
    moneys = int.parse(money!);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Transfer Account"),
          backgroundColor: appColor,
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.close,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
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
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            height: 260,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // crossAxisAlignment: ,
                      children: [
                        Text("From account :"),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/avatar.png',
                                  ),
                                  backgroundColor: Colors.grey[300],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${infoTransfer.namMe} ${infoTransfer.lastMe}",
                                    style: TextStyle(fontSize: 21),
                                  ),
                                  Text("0101 2240 10200 xxxxxxx"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Text("To account :"),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/avatar.png',
                                  ),
                                  backgroundColor: Colors.grey[300],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${infoTransfer.namRe} ${infoTransfer.lastRe}",
                                    style: TextStyle(fontSize: 21),
                                  ),
                                  Text("0101 2240 10200 xxxxxxx"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Detail'),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 40,
                  width: 200,
                  child: TextField(
                      controller: detailAdd,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        filled: true,
                        hintText: "Add Detail",
                        // border: BorderSide.none,
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.zero),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  nextButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.grey[200],
        height: 130,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () async {
                  if (moneyInput.text == null || moneyInput.text == "") {
                    Fluttertoast.showToast(msg: "please input money");
                  } else {
                    int moneyAdd = int.parse(moneyInput.text);
                    if (moneyAdd >= 1) {
                      if (moneyAdd <= moneys!) {
                        await transMoney();
                      } else {
                        Fluttertoast.showToast(msg: "money not enough");
                      }
                    } else {
                      Fluttertoast.showToast(msg: "money not enough");
                    }
                  }
                },
                child: Container(
                  color: appColor,
                  height: 55,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Please enter amount',
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 200,
                        child: TextField(
                            controller: moneyInput,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              filled: true,
                              // hintText: "Account Number",
                              // border: BorderSide.none,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero),
                            )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Kip'),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<http.Response?> transMoney() async {
    String ac_memus, money;
    ac_memus = cardMe!;
    money = moneyInput.text;
    var url = Uri.parse(apiTranCard);
    var body = json.encode({"menus": money, "ac_memus": ac_memus});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.patch(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      await receiveMoney();
    } else {
      // ShowDialogs().alertWarning(msg: 'User Name or Password incorrect');
      Fluttertoast.showToast(msg: 'something went wrong');
    }
  }

  Future<http.Response?> receiveMoney() async {
    String ac_add, money;
    ac_add = "${infoTransfer.cardNumber}";
    money = moneyInput.text;
    var url = Uri.parse(apiReceived);
    var body = json.encode({"add": money, "ac_add": ac_add});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.patch(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      await creatTranHis();
    } else {
      // ShowDialogs().alertWarning(msg: 'User Name or Password incorrect');
      Fluttertoast.showToast(msg: 'something went wrong');
    }
  }

  Future<http.Response?> creatTranHis() async {
    String ac_add, money, ac_memus;
    ac_add = "${infoTransfer.cardNumber}";
    ac_memus = cardMe!;
    money = moneyInput.text;
    var url = Uri.parse(apiCreateTran);
    var body = json.encode({
      "user_id": "$meId",
      "trans_reciever": "$ac_add",
      "trans_sender": "$ac_memus",
      "trans_money": "$money",
      "trans_detail": "${detailAdd.text}",
    });
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      await sentNoti();
    } else {
      // ShowDialogs().alertWarning(msg: 'User Name or Password incorrect');
      Fluttertoast.showToast(msg: 'something went wrong');
    }
  }

  Future<http.Response?> sentNoti() async {
    String ac_add, money, ac_memus;
    ac_add = "${infoTransfer.cardNumber}";
    ac_memus = cardMe!;
    money = moneyInput.text;
    var url = Uri.parse(apiNoti);
    var body = json.encode({
      "to":
          "fs0YiHbdRCOQ57GlTthgoh:APA91bHvMeg5_wqcA68IQwc-vAkzjL_8UKnZLyhtWmM84Q2p6li6-_UC6JVUl_y0A1LDvRSq0z_kj3-Ko4lOs5KudatkLjGOfRcrFfJEmC2oYh_yiX5sLeGIyETVJzB0vXKn51oEJiH4",
      "notification": {
        "title": "You Transfer to ${infoTransfer.namRe} ${infoTransfer.lastRe}",
        "body": "- $money kip",
        "mutable_content": true,
        "sound": "Tri-tone"
      }
    });
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization':
          'key=AAAA2pf8_a0:APA91bFVi3leh1yf8SLabK7Cj0yoUKtTuSJEPyKzIOwfy6JNgkZyF8Lg1qgxxYf7w8MLHwo-fTNqQZAYWkLjCEND02Ib1XuZNB8nPkqXq28KvxzUw0FZec3AUKYn43fdSfQGyQC2KeBV',
    };
    final response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      print("done===");
    } else {
      // ShowDialogs().alertWarning(msg: 'User Name or Password incorrect');
      Fluttertoast.showToast(msg: 'something went wrong');
    }
  }
}
