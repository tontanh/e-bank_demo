import 'package:ebank_demo/pages/about/about_page.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/language/change_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SETTINGS'),
        backgroundColor: appColor,
      ),
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          showList(
              title: 'Change Password',
              detailText: 'Use a new password to login',
              imageUrl: 'assets/icons/password.svg'),
          // showList(
          //     title: 'Change Language',
          //     detailText: 'change a language that you choose',
          //     imageUrl: 'assets/icons/language.svg',
          //     onTap: () => ChangeLanguage().ChangeLanguages(context: context)),
          showList(
              title: 'About Me',
              detailText: 'show detail and contact about me ',
              imageUrl: 'assets/icons/about.svg',
              onTap: () {
                Get.to(() => AboutScreen(), transition: Transition.rightToLeft);
              }),
        ],
      ),
    );
  }

  showList({String? title, detailText, imageUrl, GestureTapCallback? onTap}) {
    return Container(
      height: 90,
      color: Colors.grey[100],
      child: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Align(
            alignment: Alignment.bottomCenter,
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              //         splashFactory: NoSplash.splashFactory,
              // highlightColor: Colors.transparent,
              onTap: onTap,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 60,
                        width: 60,
                        child: Center(
                          child: SvgPicture.asset(
                            '$imageUrl',
                            color: appColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$title',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '$detailText',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
