import 'dart:convert';
import 'dart:math';

import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/constant/data.dart';
import 'package:ebank_demo/pages/widget/showdialog.dart';
import 'package:ebank_demo/pages/widget/successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'back_button.dart';
import 'class.dart';
import 'next_button.dart';

class RegisEmailPass extends StatefulWidget {
  const RegisEmailPass({Key? key}) : super(key: key);

  @override
  _RegisLastNameState createState() => _RegisLastNameState();
}

class _RegisLastNameState extends State<RegisEmailPass> {
  bool errorBool = false;
  String errorMSG = '';
  var email, pass1, pass2;
  final regisController = Get.put(ClassLoginData());
  // final regisController = Get.put(ClassLogin());
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
                          'Email for Login'.tr,
                          style: TextStyle(fontSize: 18),
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            regisController.email = value.obs;

                            email = value;
                          },
                          // style: dartStyle.copyWith(height: 2),
                          // keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            fillColor: Colors.white,

                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),

                            hintText: 'Email'.tr,
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
                          'Password'.tr,
                          style: TextStyle(fontSize: 18),
                        ),
                        TextField(
                          onChanged: (value) {
                            regisController.password = value.obs;
                            pass1 = value;
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
                            hintText: 'New Password'.tr,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Retry Password'.tr,
                          style: TextStyle(fontSize: 18),
                        ),
                        TextField(
                          onChanged: (value) {
                            pass2 = value;
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
                            hintText: 'Enter password again'.tr,
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
                  email == null || email == '' ? email = 'mm' : email = email;
                  bool emailValid =
                      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(email!);
                  // print(email);
                  // print(emailValid);
                  if (emailValid == true) {
                    if (pass1 == null ||
                        pass1 == '' ||
                        pass2 == null ||
                        pass2 == '') {
                      setState(() {
                        errorMSG = 'Enter password';
                      });
                    } else {
                      if (pass1.length >= 6) {
                        if (pass1 == pass2) {
                          ShowDialogs().showProccessing(context);
                          getCheckMail();
                        } else {
                          setState(() {
                            errorMSG = 'Password not match';
                          });
                        }
                      } else {
                        setState(() {
                          errorMSG = 'at least 6';
                        });
                      }
                    }
                  } else {
                    setState(() {
                      errorMSG = 'Email not correct';
                    });
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response?> getCheckMail() async {
    var url = Uri.parse(apiCheckMail + email);
    print(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $tokens',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      await getRegister();
    } else {
      Fluttertoast.showToast(msg: 'something went wrong');
      setState(() {
        errorMSG = 'Email is already used';
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<http.Response?> getRegister() async {
    var url = Uri.parse(apiCreateUser);
    var body = json.encode({
      "email": '${regisController.email}',
      "password": '${regisController.password}',
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $tokens',
    };
    final response = await http.post(url, body: body, headers: headers);
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      int id = responseJson['id'];
      await getRegisterAll(id: id);
    } else {
      Fluttertoast.showToast(msg: 'something went wrong');
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<http.Response?> getRegisterAll({int? id}) async {
    var url = Uri.parse(apiCreateAll);
    var body = json.encode({
      "user_id": '$id',
      "userinfo_firstname_en": '${regisController.userinfo_firstname_en}',
      "userinfo_firstname_la": '${regisController.userinfo_firstname_la}',
      "userinfo_lastname_en": '${regisController.userinfo_lastname_en}',
      "userinfo_lastname_la": '${regisController.userinfo_lastname_la}',
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $tokens',
    };
    final response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      await getRegisterCard(id: id);
    } else {
      Fluttertoast.showToast(msg: 'something went wrong');
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<http.Response?> getRegisterCard({int? id}) async {
    Random random = Random();
    String acNo = '${random.nextInt(10000000)}';
    String acNos = '0101224010200' + acNo;
    var url = Uri.parse(apiCreateCard);
    var body = json.encode({
      "user_id": '$id',
      "card_money": '5000000',
      "card_name": 'NBB Classic Card',
      "card_number": acNos,
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $tokens',
    };
    final response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      regisController.accountNumber = acNos.obs;
      Get.off(() => AllDone(), transition: Transition.zoom);
    } else {
      Fluttertoast.showToast(msg: 'something went wrong');
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
