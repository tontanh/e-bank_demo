import 'dart:convert';

PhoneAuth phoneAuthFromJson(String str) => PhoneAuth.fromJson(json.decode(str));

String phoneAuthToJson(PhoneAuth data) => json.encode(data.toJson());

class PhoneAuth {
  PhoneAuth({
    required this.message,
    required this.phonenumber,
  });

  String message;
  String phonenumber;

  factory PhoneAuth.fromJson(Map<String, dynamic> json) => PhoneAuth(
        message: json["message"],
        phonenumber: json["phonenumber"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "phonenumber": phonenumber,
      };
}
