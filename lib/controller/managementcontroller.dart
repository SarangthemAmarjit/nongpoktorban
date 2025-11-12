import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:torbanticketing/config/const.dart';
import 'package:torbanticketing/model/pricemodel.dart';
import 'package:torbanticketing/model/visitordetails.dart';
import 'package:torbanticketing/view/offlineticket.dart';

class Managementcontroller extends GetxController {
  // Future<void> addPayments(
  //     PaymentRequest p, String key, BuildContext context) async {
  //   // Implementation of adding payments
  // }

  List<PriceModel> _pricemodel = [];
  List<PriceModel> get pricemodel => _pricemodel;

  bool _isloading = false;
  bool get isloading => _isloading;

  String _name = '';
  String _phone = '';
  String _address = '';
  String _email = '';

  double _adultcount = 1;
  double get adultcount => _adultcount;
  double _childcount = 0;
  double get childcount => _childcount;

  String? onlineAplicant;
  int _adultrate = 0;
  int get adultrate => _adultrate;
  int _childrate = 0;
  int get childrate => _childrate;

  double get subtotal => _adultcount * _adultrate + _childcount * _childrate;

  double get taxesAndFees =>
      subtotal * 0.0833333333; // 8.333...% => example $7.5 on $90
  double get totalamount => subtotal + taxesAndFees;

  void incAdult() {
    _adultcount++;
    update();
  }

  void decAdult() {
    _adultcount = (_adultcount - 1).clamp(0, 999);
    update();
  }

  void incChild() {
    _childcount++;
    update();
  }

  void decChild() {
    _childcount = (_childcount - 1).clamp(0, 999);
    update();
  }

  void resetcount() {
    _adultcount = 1;
    _childcount = 0;
    update();
  }

  int _foreignrate = 0;
  int get foreignrate => _foreignrate;
  VisitorDetails? _visitorDetails;
  VisitorDetails? get visitorDetails => _visitorDetails;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getticketprices();
  }

  setfinaldetails() {
    _visitorDetails = VisitorDetails(
      adultCount: _adultcount,
      childCount: _childcount,
      totalAmount: totalamount,
      name: _name,
      phone: _phone,
      address: _address,
      email: _email,
    );
    update();
    Get.to(() => OfflineReceiptPage());
    // registerUser();
  }

  setVisitorDetails(String name, String phone, String address, String email) {
    _name = name;
    _phone = phone;
    _address = address;
    _email = email;
    update();
  }

  void getticketprices() async {
    try {
      final response = await http.get(Uri.parse('$baseapi/TicketPrices'));

      if (response.statusCode == 200) {
        print(response.body);

        final data = priceModelFromJson(response.body);
        _pricemodel = data;
        _adultrate = int.parse(data[0].adultPrice);
        _childrate = int.parse(data[0].childPrice);

        update();
        log(_childrate.toString());
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void registerUser() async {
    _isloading = true;
    update();
    try {
      final url = Uri.parse(
        '$baseapi/Registrations',
      ); // change endpoint if needed

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        "name": _visitorDetails?.name,
        "mobileNo": _visitorDetails?.phone,
        "address": _visitorDetails?.address,
        "email": _visitorDetails?.email,
        "adultNo": _visitorDetails?.adultCount.toString(),
        "childNo": _visitorDetails?.childCount.toString(),
        "amount": _visitorDetails?.totalAmount.toString(),
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Registration Successful');
        print('Response: ${response.body}');
        // Optional: parse model
        // final data = registerModelFromJson(response.body);
        // _registerModel = data;
        _isloading = false;
        update();
        Get.to(() => OfflineReceiptPage());
      } else {
        _isloading = false;
        update();
        print(
          'Registration Failed (${response.statusCode}): ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      _isloading = false;
      update();
      print('Exception: $e');
    }
  }
}
