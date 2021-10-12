import 'dart:io';

import 'package:ebank_demo/pages/class/login_data_provider.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/home/myqr_code/myqr_code.dart';

import 'package:ebank_demo/pages/home/root_page/root_home.dart';
import 'package:ebank_demo/pages/home/scanner/scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../root_page/controler.dart';
import 'homepage.dart';

class CardListPage extends StatefulWidget {
  const CardListPage({Key? key}) : super(key: key);

  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  final pageIndex = Get.put(PageNextCard());

  String? page;
  int? uids;
  String close = '(Close)'.tr;
  @override
  Widget build(BuildContext context) {
    final DataUserLogins userAcccess = Provider.of<DataUserLogins>(context);
    page = '${pageIndex.cardPage}';
    uids = userAcccess.uIdGet;

    return thisBody();
  }

  thisBody() {
    return page == '1'
        ? Scaffold(
            bottomNavigationBar: botBox(),
            appBar: AppBar(
              backgroundColor: appColor,
              centerTitle: true,
              title: Text('NAYOBY BANK'.tr),

              // leading: leadingWidget(),
              actions: [
                IconButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/poweroff.svg',
                    color: Colors.white,
                    height: 25,
                    width: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  profileBox(),
                  const Divider(height: 1, color: Colors.grey),
                  cardList1(),
                  const Divider(height: 1, color: Colors.grey),
                  cardList2(),
                  const Divider(height: 1, color: Colors.grey),
                ],
              ),
            ))
        : const CardPage();
  }

  profileBox() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
              height: 120,
              color: Colors.grey[100],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/avatar.png',
                      ),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tontanh ${uids.toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Text('ຕົ້ນຕານ ແກ້ວມະນີວົງ '),
                        SizedBox(height: 3),
                        Text('tonkmnv@gmail.com'),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            height: 30,
            width: 50,
            // color: Colors.grey,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Edit'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  cardList1() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: ()
                // Get.to(() => CardPage(), transition: Transition.rightToLeft);
                {
              setState(() {
                page = '2';
                pageIndex.cardPage = '2'.obs;
              });
            },
            child: Container(
                height: 100,
                // color: Colors.grey[100],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/nbb_card.png')),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NBB Classic Card',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Text('020202 20202 9484848 15'),
                          SizedBox(height: 3),
                          Text('Tontanh keomanyvong'),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  cardList2() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: '(Close)'.tr);
            },
            child: Container(
                height: 100,
                // color: Colors.grey[100],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/visa_card.png')),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'VISA Card',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                '(Close)'.tr,
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text('ຕົ້ນຕານ ແກ້ວມະນີວົງ '),
                          SizedBox(height: 3),
                          Text('tonkmnv@gmail.com'),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  botBox() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 88,
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: 'Close'.tr);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 50,
                      // color: appColor,
                      child: Center(
                        child: Container(
                          height: 35,
                          width: 35,
                          // color: appColor,
                          child: SvgPicture.asset(
                            'assets/icons/headphone.svg',
                            color: appColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          const Text(
                            'NBB Care',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '$close',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const QRCodeMainPage(),
                      transition: Transition.zoom);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 50,
                      // color: appColor,
                      child: Center(
                        child: Container(
                          height: 35,
                          width: 35,
                          // color: appColor,
                          child: SvgPicture.asset(
                            'assets/icons/qr_code.svg',
                            color: appColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: const Text(
                        'My Qr',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const QRViewExample(),
                      transition: Transition.zoom);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  height: 70,
                  width: 70,
                  child: Image.asset('assets/images/nbb_pay.png'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
