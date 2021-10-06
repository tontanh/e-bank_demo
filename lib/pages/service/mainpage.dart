import 'package:ebank_demo/pages/constant/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text('Service'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            bodyList(
                onTaps: () => Fluttertoast.showToast(msg: '(Close)'.tr),
                imageUrl: 'assets/icons/gift.svg',
                textTitile: 'Promotions'.tr,
                close: '(Close)'.tr,
                textDetail1: 'Special sevices and discounts from'.tr,
                textDetail2: 'NBB partners'.tr),
            bodyList(
                onTaps: () => Fluttertoast.showToast(msg: '(Close)'.tr),
                imageUrl: 'assets/icons/newspaper.svg',
                textTitile: 'News'.tr,
                close: '(Close)'.tr,
                textDetail1: 'Information and  notice from NBB'.tr,
                textDetail2: ''),
            bodyList(
                onTaps: () => Fluttertoast.showToast(msg: '(Close)'.tr),
                close: '(Close)'.tr,
                imageUrl: 'assets/icons/exchange.svg',
                textTitile: 'Exchange Rates'.tr,
                textDetail1: 'View buy/sell rates of foreign'.tr,
                textDetail2: 'currencies'.tr),
            bodyList(
                onTaps: () => Fluttertoast.showToast(msg: '(Close)'.tr),
                imageUrl: 'assets/icons/atm.svg',
                textTitile: 'Location of NBB ATMs'.tr,
                textDetail1: 'View ATMs'.tr,
                close: '(Close)'.tr,
                textDetail2: ''),
            bodyList(
                onTaps: () => Fluttertoast.showToast(msg: '(Close)'.tr),
                close: '(Close)'.tr,
                imageUrl: 'assets/icons/kip.svg',
                textTitile: 'Fees'.tr,
                textDetail1: 'Fees of all NBB services'.tr,
                textDetail2: ''),
            bodyList(
                onTaps: () => Fluttertoast.showToast(msg: '(Close)'.tr),
                imageUrl: 'assets/icons/discount.svg',
                textTitile: 'Interests'.tr,
                close: '(Close)'.tr,
                textDetail1: 'Deposit and loan interests'.tr,
                textDetail2: ''),
          ],
        ),
      ),
    );
  }

  bodyList(
      {GestureTapCallback? onTaps,
      String? imageUrl,
      close,
      textTitile,
      textDetail1,
      textDetail2}) {
    return Column(
      children: [
        InkWell(
          onTap: onTaps,
          child: Container(
            height: 90,
            // color: Colors.white,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: SvgPicture.asset(
                    '$imageUrl',
                    color: appColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Row(
                      children: [
                        Text(
                          '$textTitile',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '$close',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    // ignore: prefer_const_constructors

                    Text(
                      '$textDetail1',
                    ),

                    Text(
                      '$textDetail2',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          // color: Colors.grey,
        ),
      ],
    );
  }
}
