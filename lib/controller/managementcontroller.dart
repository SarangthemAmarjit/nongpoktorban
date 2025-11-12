import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:torbanticketing/config/const.dart';
import 'package:torbanticketing/model/pricemodel.dart';
import 'package:torbanticketing/model/visitordetails.dart';

class Managementcontroller extends GetxController {
  // Future<void> addPayments(
  //     PaymentRequest p, String key, BuildContext context) async {
  //   // Implementation of adding payments
  // }

  List<PriceModel> _pricemodel = [];
  List<PriceModel> get pricemodel => _pricemodel;

  String _name = '';
  String _phone = '';
  String _address = '';
  String _email = '';

  int _totalamount = 0;
  int get totalamount => _totalamount;

  int _adultcount = 1;
  int get adultcount => _adultcount;
  int _childcount = 0;
  int get childcount => _childcount;

  String? onlineAplicant;
  int _adultrate = 0;
  int get adultrate => _adultrate;
  int _childrate = 0;
  int get childrate => _childrate;

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
  setfinaldetails(int  adultcountnum, int childcountnum, int totalamountnum) {
    _adultcount = adultcountnum;
    _childcount = childcountnum ;
    _totalamount = totalamountnum; 

    _visitorDetails = VisitorDetails(adultCount: _adultcount, childCount: _childcount, totalAmount: _totalamount, name: _name, phone: _phone, address: _address, email: _email);
    update();
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
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void registerUser({
    required String name,
    required String mobileNo,
    required String address,
    required String email,
    required int adultNo,
    required int? childNo,
    required int amount,
  }) async {
    try {
      final url = Uri.parse(
        '$baseapi/Registrations',
      ); // change endpoint if needed

      final headers = {'Content-Type': 'application/json'};

      final body = jsonEncode({
        "name": name,
        "mobileNo": mobileNo,
        "address": address,
        "email": email,
        "adultNo": adultNo,
        "childNo": childNo,
        "amount": (adultNo * _adultrate) + ((childNo ?? 0) * _childrate),
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Registration Successful');
        print('Response: ${response.body}');
        // Optional: parse model
        // final data = registerModelFromJson(response.body);
        // _registerModel = data;
        update();
      } else {
        print(
          'Registration Failed (${response.statusCode}): ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
