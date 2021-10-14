import 'dart:convert';
import 'dart:io';

import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/switch_page/screenloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ebank_demo/pages/api/api.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class QRCodeMainPage extends StatefulWidget {
  const QRCodeMainPage({Key? key}) : super(key: key);

  @override
  _QRCodeMainPageState createState() => _QRCodeMainPageState();
}

class _QRCodeMainPageState extends State<QRCodeMainPage> {
  final controlText = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    return FutureBuilder(
      future: loginUser(
          uid: '${userAcccess.uIdGet}', token: '${userAcccess.jwtGet}'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return doneAll();
        } else {
          return doneAll();
        }
        // ignore: dead_code
        return loading();
      },
    );
  }

  doneAll() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text('QR Code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textDetail(),
              QrImage(
                data: controlText.text,
                size: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }

  loading() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text('QR Code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textDetail(),
              Container(
                height: 200,
                width: 200,
                color: Colors.grey[200],
              )
            ],
          ),
        ),
      ),
    );
  }

  textDetail() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Text(
        'This is your QR Code'.tr,
        style: const TextStyle(fontSize: 18),
      ),
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
      controlText.text = responseJson['card_number'];
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
