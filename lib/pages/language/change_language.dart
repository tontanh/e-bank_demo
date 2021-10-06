import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguage {
  ChangeLanguage();
  final List locale = [
    // ignore: prefer_const_constructors
    {
      'name': 'English',
      'locale': const Locale('en', 'US'),
      'image': 'assets/icons/english.svg'
    },
    // ignore: prefer_const_constructors
    {
      'name': 'ລາວ',
      'locale': const Locale('la', 'LA'),
      'image': 'assets/icons/laos.svg'
    },
  ];
  updateLanguage(Locale locale) async {
    Get.back();
    Get.updateLocale(locale);
  }

  // ignore: non_constant_identifier_names
  ChangeLanguages({required BuildContext context}) {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose a language'.tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                            onTap: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setString(
                                  'language', '${locale[index]['locale']}');
                              updateLanguage(locale[index]['locale']);
                              // print('${locale[index]['locale']}');
                            },
                            child: Row(
                              children: [
                                // ignore: avoid_unnecessary_containers
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: SvgPicture.asset(
                                    '${locale[index]['image']}',
                                  ),
                                ),
                                // ignore: prefer_const_constructors
                                SizedBox(
                                  width: 10,
                                ),
                                Text(locale[index]['name']),
                              ],
                            )));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.white,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }
}
