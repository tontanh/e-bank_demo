import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/register/regist_email_pass.dart';
import 'package:ebank_demo/pages/register/regist_tel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'back_button.dart';
import 'class.dart';
import 'next_button.dart';

class RegisLastName extends StatefulWidget {
  const RegisLastName({Key? key}) : super(key: key);

  @override
  _RegisLastNameState createState() => _RegisLastNameState();
}

class _RegisLastNameState extends State<RegisLastName> {
  bool errorBool = false;
  String errorMSG = '';
  String? lName1, lName2;

  final regisController = Get.put(ClassLoginData());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/register.svg",
                              color: appColor,
                              width: 150,
                              height: 150,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Register'.tr,
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                        Text(
                          'Last Name EN'.tr,
                          style: TextStyle(fontSize: 18),
                        ),
                        TextField(
                          onChanged: (value) {
                            regisController.userinfo_lastname_en = value.obs;
                            lName1 = value;
                          },
                          // style: dartStyle.copyWith(height: 2),
                          // keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            hintText: 'Last Name English'.tr,
                            hintStyle: TextStyle(height: 2, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: appColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: appColor,
                              ),
                            ),
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Colors.black,
                            // ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Last Name LA'.tr,
                          style: TextStyle(fontSize: 18),
                        ),
                        TextField(
                          onChanged: (value) {
                            regisController.userinfo_lastname_la = value.obs;
                            lName2 = value;
                          },
                          // style: dartStyle.copyWith(height: 2),
                          // keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            hintText: 'Last Name Lao'.tr,
                            hintStyle: TextStyle(height: 2, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: appColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: appColor,
                              ),
                            ),
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Colors.black,
                            // ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          errorMSG,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: BackButtons(
                    icon: Icons.arrow_back,
                    onPressed: () {
                      navigator!.pop();
                    }),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: NextButtons(onPressed: () {
                  if (lName1 == null ||
                      lName2 == null ||
                      lName1 == '' ||
                      lName2 == '') {
                    setState(() {
                      errorMSG = 'Please input info';
                    });
                  } else {
                    Get.to(() => const RegisEmailPass(),
                        transition: Transition.rightToLeft);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
