import 'dart:convert';
import 'dart:io';
import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/home/transfer/class.dart';
import 'package:ebank_demo/pages/home/transfer/transfer_amount.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import 'checkqrcode.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? barcode;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final uidRe = Get.put(TransferClass());
  String? token, meId;
  // final barcodeController = Get.put(BarcodeText());
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    token = '${userAcccess.jwtGet}';
    meId = '${userAcccess.uIdGet}';
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
            Positioned(top: 10, child: buildControlButton()),
            Positioned(
                bottom: 10,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.white24),
                  child: Text(
                    'Cancel'.tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                )),
            // Positioned(
            // bottom: 20,
            // child: buildResult()),
          ],
        ),
      ),
    );
  }

  Widget buildControlButton() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white24),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                icon: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(
                        snapshot.data != null
                            ? Icons.flash_on
                            : Icons.flash_off,
                        color: Colors.white,
                      );
                    } else {
                      return Container();
                    }
                  },
                )),
            IconButton(
                onPressed: () async {
                  await controller?.flipCamera();
                  setState(() {});
                },
                icon: FutureBuilder(
                  future: controller?.getCameraInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(
                        Icons.switch_camera,
                        color: Colors.white,
                      );
                    } else {
                      return Container();
                    }
                  },
                )),
          ],
        ),
      );
// Widget buildResult() => Text(barcode != null? 'Result : ${barcode.code} ': 'Scan Barcode',maxLines: 3,);
  Widget buildQrView(BuildContext context) {
    // var scanArea = (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 150.0
    //     : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.blue,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
        // cutOutSize: scanArea
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        this.barcode = scanData;
        if (this.barcode != null) {
          // ignore: avoid_print

          print(barcode?.code);
          //  await accSelect(accTxt: barcode?.code);
          String? txt = barcode?.code;
          Get.to(
              () => CheckQrCodeReal(
                    accNumC: txt!,
                  ),
              transition: Transition.rightToLeft);
        } else {}
      });
    });
  }

  // Future<http.Response?> accSelect({String? accTxt}) async {
  //   String acText;
  //   accTxt == null || accTxt == "" ? accTxt = "121" : accTxt = accTxt;
  //   acText = accTxt;
  //   var url = Uri.parse(apiSelectCard + acText);

  //   Map<String, String> headers = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   final response = await http.get(url, headers: headers);
  //   final responseJson = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     String uids = "${responseJson["user_id"]}";
  //     String cardRe = "${responseJson["card_number"]}";
  //     String money = "${responseJson["card_money"]}";
  //     uidRe.uidReceiver = "$uids".obs;
  //     uidRe.cardNumber = "$cardRe".obs;
  //     uidRe.moneys = "$money".obs;
  //     // await getUserInfo(receiId: uids);
  //   } else {
  //     Fluttertoast.showToast(msg: 'wrong card');
  //     // Future.delayed(Duration(seconds: 1), () {});
  //   }
  // }

  // Future<http.Response?> getUserInfo({String? receiId}) async {
  //   var url = Uri.parse(apiGetUserInfo + receiId!);

  //   Map<String, String> headers = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   final response = await http.get(url, headers: headers);
  //   final responseJson = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     String name = "${responseJson["userinfo_firstname_en"]}";
  //     String last = "${responseJson["userinfo_lastname_en"]}";
  //     // print(name + last);
  //     uidRe.namRe = "$name".obs;
  //     uidRe.lastRe = "$last".obs;
  //     await getTokenMe();
  //     await getTokenYou(uids: receiId);
  //     await acMe();
  //   } else {
  //     Fluttertoast.showToast(msg: 'something went wrong');
  //     // Future.delayed(Duration(seconds: 1), () {});
  //   }
  // }

  // Future<http.Response?> acMe() async {
  //   var url = Uri.parse(apiGetUserInfo + meId!);
  //   Map<String, String> headers = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   final response = await http.get(url, headers: headers);
  //   final responseJson = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     String nameME = "${responseJson["userinfo_firstname_en"]}";
  //     String lastME = "${responseJson["userinfo_lastname_en"]}";
  //     uidRe.namMe = "$nameME".obs;
  //     uidRe.lastMe = "$lastME".obs;
  //     Get.to(() => const TranAmountPage(), transition: Transition.rightToLeft);
  //   } else {
  //     Fluttertoast.showToast(msg: 'something went wrong');
  //     // Future.delayed(Duration(seconds: 1), () {});
  //   }
  // }

  // Future<http.Response?> getTokenMe() async {
  //   var url = Uri.parse(apiNotiToken + meId!);
  //   Map<String, String> headers = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   final response = await http.get(url, headers: headers);
  //   final responseJson = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     String notiToken = "${responseJson["noti_token"]}";
  //     uidRe.tokenNotiMe = "$notiToken".obs;
  //     // print("me id ===" + notiToken);
  //   } else {
  //     Fluttertoast.showToast(msg: 'notification went wrong 1');
  //     // Future.delayed(Duration(seconds: 1), () {});
  //   }
  // }

  // Future<http.Response?> getTokenYou({String? uids}) async {
  //   var url = Uri.parse(apiNotiToken + uids!);
  //   Map<String, String> headers = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   final response = await http.get(url, headers: headers);
  //   final responseJson = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     String notiToken = "${responseJson["noti_token"]}";
  //     // print("you id ===" + notiToken);
  //     uidRe.tokenNotiYou = "$notiToken".obs;
  //   } else {
  //     Fluttertoast.showToast(msg: 'notification went wrong 2');
  //     // Future.delayed(Duration(seconds: 1), () {});
  //   }
  // }
}
