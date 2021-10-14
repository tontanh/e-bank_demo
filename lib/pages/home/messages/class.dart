import 'dart:convert';
import 'dart:io';
import 'package:ebank_demo/pages/api/api.dart';
import 'package:ebank_demo/pages/home/messages/model.dart';
import 'package:ebank_demo/pages/login_root/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
Future<List<HisTransfer>?> dataHisTransfer({String? token, ac_no}) async {
  var url = Uri.parse(apiHisTransfer);
  var body =
      json.encode({"trans_reciever": "$ac_no", "trans_sender": "$ac_no"});

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
  final response = await http.post(url, body: body, headers: headers);

  if (response.statusCode == 200) {
    return hisTransferFromJson(response.body);
  } else {
    print('something went wrong ');
    // Get.off(() => HomePage, transition: Transition.noTransition);
  }
}
