// To parse this JSON data, do
//
//     final priceModel = priceModelFromJson(jsonString);

import 'dart:convert';

List<PriceModel> priceModelFromJson(String str) =>
    List<PriceModel>.from(json.decode(str).map((x) => PriceModel.fromJson(x)));

String priceModelToJson(List<PriceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PriceModel {
  final int id;
  final String adultPrice;
  final String childPrice;


  PriceModel({
    required this.id,
    required this.adultPrice,
    required this.childPrice,
  
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
    id: json["id"],
    adultPrice: json["adultPrice"],
    childPrice: json["childPrice"],
  
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "adultPrice": adultPrice,
    "childPrice": childPrice,
  
  };
}
