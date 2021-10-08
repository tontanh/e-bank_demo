import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ShowDialogs {
  ShowDialogs();
  showProccessing(context) {
    return showDialog(
      barrierDismissible: false,
      // barrierColor: null,
      context: context,
      builder: (context) => Container(
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          content: Container(
            // color: Colors.white,
            height: 68,
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                Text(
                  'loading...'.tr,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
