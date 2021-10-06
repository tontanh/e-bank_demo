import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/language/change_language.dart';
import 'package:ebank_demo/pages/login/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text('Terms and Conditions'.tr),
        actions: <Widget>[
          Container(
              // width: 60,
              // height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                // border: Border.all(color: bgwhite),
              ),
              // margin: const EdgeInsets.only(top: 20, right: 20),
              child: InkWell(
                onTap: () {
                  ChangeLanguage().ChangeLanguages(context: context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.language,
                      // color: appColor,
                      size: 30,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'language'.tr,
                      // style: TextStyle(color: appColor),
                    ),
                  ],
                ),
              ))
        ],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'NBB is a product issued by Banque pour le Commerce Exterieur Lao Public (NBB) to the customer (you or your) desirous to use this product in order to facilitate the payment and to monitor the transactions of your card issued by NBB. The customer who is desirous to use NBB must satisfy the following terms and conditions:'
                          .tr),
                  Text(
                    'NAYOBY BANK'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'NBB shall be released from any and all responsibilities for damages and losses resulting from the use of NBB as follows:The user of NBB must keep the User name and Password confidential without disclosure to others.'
                          .tr),
                  Text(
                      'Any and all complete transactions of NBB, which use your User name and/or Password and lead to your financial losses, shall cause no responsibilities to NBB.'
                          .tr),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 55,
                    // margin: const EdgeInsets.only(left: 5, right: 5),
                    // width: 100,
                    // margin: const EdgeInsets.only(right: 5, left: 5),
                    color: Colors.white,
                    // child: Container(
                    //   color: Colors.white,
                    //   width: 40,
                    // ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                height: 40,
                width: 200,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'I ACCEPT'.tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(appColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
