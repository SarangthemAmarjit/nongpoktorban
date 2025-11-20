// To parse this JSON data, do
//
//     final addpaymentresponsemodel = addpaymentresponsemodelFromJson(jsonString);

import 'dart:convert';

Addpaymentresponsemodel addpaymentresponsemodelFromJson(String str) =>
    Addpaymentresponsemodel.fromJson(json.decode(str) as Map<String, dynamic>);

String addpaymentresponsemodelToJson(Addpaymentresponsemodel data) =>
    json.encode(data.toJson());

class Addpaymentresponsemodel {
  final int id;
  final int regId;
  final String paymentStatus;
  final String transactionId;
  final String totalAmount;
  final DateTime paymentDate;

  Addpaymentresponsemodel({
    required this.id,
    required this.regId,
    required this.paymentStatus,
    required this.transactionId,
    required this.totalAmount,
    required this.paymentDate,
  });

  factory Addpaymentresponsemodel.fromJson(Map<String, dynamic> json) =>
      Addpaymentresponsemodel(
        id: json["id"],
        regId: json["regId"],
        paymentStatus: json["paymentStatus"],
        transactionId: json["transactionId"],
        totalAmount: json["totalAmount"],
        paymentDate: DateTime.parse(json["paymentDate"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "regId": regId,
    "paymentStatus": paymentStatus,
    "transactionId": transactionId,
    "totalAmount": totalAmount,
    "paymentDate": paymentDate.toIso8601String(),
  };
}
