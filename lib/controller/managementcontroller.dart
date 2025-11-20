import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:torbanticketing/config/const.dart';
import 'package:torbanticketing/controller/paymentcontroller.dart';
import 'package:torbanticketing/model/paymentresponsemodel.dart';
import 'package:torbanticketing/model/pricemodel.dart';
import 'package:torbanticketing/model/registermodel.dart';
import 'package:torbanticketing/model/visitordetails.dart';
import 'package:torbanticketing/payment/PaymentPage.dart';
import 'package:torbanticketing/view/offlineticket.dart';

class Managementcontroller extends GetxController {
  // Future<void> addPayments(
  //     PaymentRequest p, String key, BuildContext context) async {
  //   // Implementation of adding payments
  // }

  List<PriceModel> _pricemodel = [];
  List<PriceModel> get pricemodel => _pricemodel;

  String _transactionid = '';
  String get transactionid => _transactionid;

  bool _isloading = false;
  bool get isloading => _isloading;

  String _name = '';
  String _phone = '';
  String _address = '';
  String _email = '';

  RegisterModelFromJson? _registerModel;
  RegisterModelFromJson? get registerModel => _registerModel;

  Addpaymentresponsemodel? _payresModel;
  Addpaymentresponsemodel? get payresModel => _payresModel;

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

  double get totalamount => subtotal;

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

  final int _foreignrate = 0;
  int get foreignrate => _foreignrate;
  VisitorDetails? _visitorDetails;
  VisitorDetails? get visitorDetails => _visitorDetails;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getticketprices();
  }

  setfinaldetails(BuildContext context) {
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

    if (isofflinepay) {
      registerUserforcounter(context);
    } else {
      Get.to(() => OfflineReceiptPage());
    }
  }

  setVisitorDetails(String name, String phone, String address, String email) {
    _name = name;
    _phone = phone;
    _address = address;
    _email = email;
    _transactionid = generateReceiptNumber();
    update();
  }

  void registerUserforcounter(BuildContext context) async {
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
        final data = registerModelFromJsonFromJson(response.body);
        _registerModel = data;
        _isloading = false;
        update();

        addpaymentforoffline();

        Get.to(() => OfflineReceiptPage());
      } else {
        _isloading = false;
        update();
        showErrorDialog(context,'Registration Failed');
        print(
          'Registration Failed (${response.statusCode}): ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      _isloading = false;
      update();
      showErrorDialog(context,'Registration Failed');
      print('Exception: $e');
    }
  }

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text("Failed"),
          ],
        ),
        content: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Retry",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
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

  void addpaymentforoffline() async {
    try {
      final url = Uri.parse('$baseapi/Payments'); // change endpoint if needed

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        "regId": _registerModel!.id,
        "paymentStatus": "SUCCESS",
        "transactionId": _transactionid,
        "totalAmount": totalamount.toString(),
        "paymentDate": DateTime.now().toIso8601String(),
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Payment Added Successful');
        print('Response: ${response.body}');
        // Optional: parse model
        final data = addpaymentresponsemodelFromJson(response.body);
        _payresModel = data;
        update();
      } else {
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

  void addpayment() async {
    try {
      final url = Uri.parse('$baseapi/Payments'); // change endpoint if needed

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        "regId": _registerModel!.id,
        "paymentStatus": "Initiated",
        "transactionId": _transactionid,
        "totalAmount": totalamount.toString(),
        "paymentDate": DateTime.now().toIso8601String(),
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Payment Added Successful');
        print('Response: ${response.body}');
        // Optional: parse model
        final data = addpaymentresponsemodelFromJson(response.body);
        _payresModel = data;
        update();
      } else {
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

  Future<void> updatepayment(Addpaymentresponsemodel p) async {
    try {
      final url = Uri.parse(
        '$baseapi/Payments/${p.id}',
      ); // change endpoint if needed

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        "id": p.id,
        "regId": p.regId,
        "paymentStatus": p.paymentStatus,
        "transactionId": p.transactionId,
        "totalAmount": p.totalAmount,
        "paymentDate": DateTime.now().toIso8601String(),
      });

      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print('Payment Update Successful');
        print('Response: ${response.body}');
        // Optional: parse model
        // final data = addpaymentresponsemodelFromJson(response.body);
        // _payresModel = data;
        // update();
      } else {
        print(
          'Payment Update Failed (${response.statusCode}): ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      _isloading = false;
      update();
      print('Exception: $e');
    }
  }

  void registerUser({
    required BuildContext context,

    required String transId,

    required String clientcodeok,
  }) async {
    _isloading = true;
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
        final data = registerModelFromJsonFromJson(response.body);
        _registerModel = data;
        _isloading = false;
        update();
        var res = await Get.find<Paymentcontroller>().initNdpsPayment(
          context: context,
          name: _name,
          transId: transId,
          amount: totalamount.toString(),
          email: _email,
          clientcodeok: clientcodeok,
          number: _phone,
          address: _address,
        );
        if (res != null) {
          addpayment();
          Get.to(PaymentFinalPage());
        } else {
          // context.go('/home/successpage');
        }

        // Get.to(() => OfflineReceiptPage());
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
