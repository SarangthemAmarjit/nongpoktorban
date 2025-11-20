// To parse this JSON data, do
//
//     final registerModelFromJson = registerModelFromJsonFromJson(jsonString);

import 'dart:convert';

RegisterModelFromJson registerModelFromJsonFromJson(String str) =>
    RegisterModelFromJson.fromJson(json.decode(str));

String registerModelFromJsonToJson(RegisterModelFromJson data) =>
    json.encode(data.toJson());

class RegisterModelFromJson {
  final int id;
  final String name;
  final String mobileNo;
  final String address;
  final String email;
  final String adultNo;
  final String childNo;
  final String amount;

  RegisterModelFromJson({
    required this.id,
    required this.name,
    required this.mobileNo,
    required this.address,
    required this.email,
    required this.adultNo,
    required this.childNo,
    required this.amount,
  });

  factory RegisterModelFromJson.fromJson(Map<String, dynamic> json) =>
      RegisterModelFromJson(
        id: json["id"],
        name: json["name"],
        mobileNo: json["mobileNo"],
        address: json["address"],
        email: json["email"],
        adultNo: json["adultNo"],
        childNo: json["childNo"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobileNo": mobileNo,
    "address": address,
    "email": email,
    "adultNo": adultNo,
    "childNo": childNo,
    "amount": amount,
  };
}
