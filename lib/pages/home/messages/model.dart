// To parse this JSON data, do
//
//     final hisTransfer = hisTransferFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<HisTransfer> hisTransferFromJson(String str) => List<HisTransfer>.from(
    json.decode(str).map((x) => HisTransfer.fromJson(x)));

String hisTransferToJson(List<HisTransfer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HisTransfer {
  HisTransfer({
    @required this.transId,
    @required this.userId,
    @required this.transReciever,
    @required this.transSender,
    @required this.transStatus,
    @required this.transMoney,
    @required this.cardId,
    @required this.transDetail,
    @required this.transTime,
  });

  int? transId;
  int? userId;
  String? transReciever;
  String? transSender;
  int? transStatus;
  int? transMoney;
  int? cardId;
  String? transDetail;
  DateTime? transTime;

  factory HisTransfer.fromJson(Map<String, dynamic> json) => HisTransfer(
        transId: json["trans_id"],
        userId: json["user_id"],
        transReciever: json["trans_reciever"],
        transSender: json["trans_sender"],
        transStatus: json["trans_status"],
        transMoney: json["trans_money"],
        cardId: json["card_id"],
        transDetail: json["trans_detail"],
        transTime: DateTime.parse(json["trans_time"]),
      );

  Map<String, dynamic> toJson() => {
        "trans_id": transId,
        "user_id": userId,
        "trans_reciever": transReciever,
        "trans_sender": transSender,
        "trans_status": transStatus,
        "trans_money": transMoney,
        "card_id": cardId,
        "trans_detail": transDetail,
        "trans_time": transTime?.toIso8601String(),
      };
}
