import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  ShowToast();
  showLoginFailed({String? msg}) {
    return Fluttertoast.showToast(
      msg: '$msg',
      fontSize: 16,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
    );
  }
}
