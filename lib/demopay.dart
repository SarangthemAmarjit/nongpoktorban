import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:torbanticketing/payment/atom_pay_helper.dart';

import 'web_view_container.dart';

class Home extends StatelessWidget {
  String _atomTokenId = '';

  // merchant configuration data
  final String login = "317157"; //mandatory
  final String password = 'Test@123'; //mandatory
  final String prodid = 'NSE'; //mandatory
  final String requestHashKey = 'KEY1234567234'; //mandatory
  final String responseHashKey = 'KEYRESP123657234'; //mandatory
  final String requestEncryptionKey =
      'A4476C2062FFA58980DC8F79EB6A799E'; //mandatory
  final String responseDecryptionKey =
      '75AEF0FA1B94B3C10D4F5B268F757F11'; //mandatory
  final String txnid =
      'test240223'; // mandatory // this should be unique each time
  final String clientcode = "NAVIN"; //mandatory
  final String txncurr = "INR"; //mandatory
  final String mccCode = "5499"; //mandatory
  final String merchType = "R"; //mandatory
  final String amount = "1.00"; //mandatory

  final String mode = "uat"; // change live for production

  final String custFirstName = 'test'; //optional
  final String custLastName = 'user'; //optional
  final String mobile = '8888888888'; //optional
  final String email = 'test@gmail.com'; //optional
  final String address = 'mumbai'; //optional
  final String custacc = '639827'; //optional
  final String udf1 = "udf1"; //optional
  final String udf2 = "udf2"; //optional
  final String udf3 = "udf3"; //optional
  final String udf4 = "udf4"; //optional
  final String udf5 = "udf5"; //optional

  final String authApiUrl = "https://caller.atomtech.in/ots/aipay/auth"; // uat

  // final String auth_API_url =
  //     "https://payment1.atomtech.in/ots/aipay/auth"; // prod

  final String returnUrl =
      "https://pgtest.atomtech.in/mobilesdk/param"; //return url uat
  // final String returnUrl =
  //     "https://payment.atomtech.in/mobilesdk/param"; ////return url production

  final String payDetails = '';

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NDPS Sample App')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _initNdpsPayment(
                context,
                responseHashKey,
                responseDecryptionKey,
              ),
              child: const Text('Open'),
            ),
          ],
        ),
      ),
    );
  }

  void _initNdpsPayment(
    BuildContext context,
    String responseHashKey,
    String responseDecryptionKey,
  ) {
    _getEncryptedPayUrl(context, responseHashKey, responseDecryptionKey);
  }

  //Encrypt Function
  Future<String> encrypt(String text) async {
    debugPrint('Input text for encryption: $text');
    try {
      final pbkdf2 = Pbkdf2(
        macAlgorithm: Hmac.sha512(),
        iterations: 65536,
        bits: 256,
      );

      final derivedKey = await pbkdf2.deriveKey(
        secretKey: SecretKey(password22),
        nonce: salt,
      );

      final keyBytes = await derivedKey.extractBytes();
      debugPrint('Derived key bytes: $keyBytes');

      final aesCbc = AesCbc.with256bits(
        macAlgorithm: MacAlgorithm.empty,
        paddingAlgorithm: PaddingAlgorithm.pkcs7,
      );

      final secretBox = await aesCbc.encrypt(
        utf8.encode(text),
        secretKey: SecretKey(keyBytes),
        nonce: iv,
      );

      final hexOutput = secretBox.cipherText
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join();
      debugPrint('Encrypted hex output: $hexOutput');
      return hexOutput;
    } catch (e, stackTrace) {
      debugPrint('Encryption error: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  static const req_EncKey = 'A4476C2062FFA58980DC8F79EB6A799E';
  static const req_Salt = 'A4476C2062FFA58980DC8F79EB6A799E';
  static const res_DecKey = '75AEF0FA1B94B3C10D4F5B268F757F11';
  static const res_Salt = '75AEF0FA1B94B3C10D4F5B268F757F11';

  final password22 = Uint8List.fromList(utf8.encode(req_EncKey));
  final salt = Uint8List.fromList(utf8.encode(req_Salt));
  final resPassword = Uint8List.fromList(utf8.encode(res_DecKey));
  final resSalt = Uint8List.fromList(utf8.encode(res_Salt));
  final iv = Uint8List.fromList([
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
  ]);

  //Decrypt Function
  Future<String> decrypt(String hexCipherText) async {
    try {
      // debugPrint('Input hex for decryption: $hexCipherText');

      // Convert hex string to bytes
      List<int> cipherText = [];
      for (int i = 0; i < hexCipherText.length; i += 2) {
        String hex = hexCipherText.substring(i, i + 2);
        cipherText.add(int.parse(hex, radix: 16));
      }
      debugPrint('Cipher text bytes: $cipherText');

      final pbkdf2 = Pbkdf2(
        macAlgorithm: Hmac.sha512(),
        iterations: 65536,
        bits: 256,
      );

      final derivedKey = await pbkdf2.deriveKey(
        secretKey: SecretKey(resPassword),
        nonce: resSalt, // Use the same salt as in encryption
      );

      final keyBytes = await derivedKey.extractBytes();

      final aesCbc = AesCbc.with256bits(
        macAlgorithm: MacAlgorithm.empty,
        paddingAlgorithm: PaddingAlgorithm.pkcs7,
      );

      final secretBox = SecretBox(
        cipherText,
        nonce: iv, // Use the same IV as in encryption
        mac: Mac.empty,
      );
      // debugPrint('SecretBox: $secretBox');

      final decryptedBytes = await aesCbc.decrypt(
        secretBox,
        secretKey: SecretKey(keyBytes),
      );

      final decryptedText = utf8.decode(decryptedBytes);
      // debugPrint('Decrypted text: $decryptedText');
      return decryptedText;
    } catch (e, stackTrace) {
      debugPrint('Decryption error: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  _getEncryptedPayUrl(context, responseHashKey, responseDecryptionKey) async {
    String reqJsonData = _getJsonPayloadData();
    debugPrint(reqJsonData);

    try {
      final String encDataR = await encrypt(reqJsonData);
      String authEncryptedString = encDataR.toString();
      // here is result.toString() parameter you will receive encrypted string
      // debugPrint("generated encrypted string: '$authEncryptedString'");
      _getAtomTokenId(context, authEncryptedString);
    } on PlatformException catch (e) {
      debugPrint("Failed to get encryption string: '${e.message}'.");
    }
  }

  _getAtomTokenId(context, authEncryptedString) async {
    var request = http.Request(
      'POST',
      Uri.parse("https://caller.atomtech.in/ots/aipay/auth"),
    );
    request.bodyFields = {'encData': authEncryptedString, 'merchId': login};

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var authApiResponse = await response.stream.bytesToString();
      final split = authApiResponse.trim().split('&');
      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++) i: split[i],
      };
      final splitTwo = values[1]!.split('=');
      if (splitTwo[0] == 'encData') {
        final encDataPart = split.firstWhere(
          (element) => element.startsWith('encData'),
        );
        final encryptedData = encDataPart.split('=')[1];
        final extractedData = ['encData', encryptedData];

        try {
          final splitTwo = values[1]!.split('=');
          if (splitTwo[0] == 'encData') {
            final encDataPart = split.firstWhere(
              (element) => element.startsWith('encData'),
            );
            final encryptedData = encDataPart.split('=')[1];
            final extractedData = ['encData', encryptedData];
            try {
              final decryptedData = await decrypt(extractedData[1]);
              debugPrint(decryptedData.toString()); // to read full response
              var respJsonStr = decryptedData.toString();
              Map<String, dynamic> jsonInput = jsonDecode(respJsonStr);
              if (jsonInput["responseDetails"]["txnStatusCode"] == 'OTS0000') {
                _atomTokenId = jsonInput["atomTokenId"].toString();

                debugPrint("atomTokenId: $_atomTokenId");
                final String payDetails =
                    '{"atomTokenId" : "$_atomTokenId","merchId": "$login","emailId": $email,"mobileNumber":"98394853290", "returnUrl":"$returnUrl"}';
                _openNdpsPG(
                  payDetails,
                  context,
                  responseHashKey,
                  responseDecryptionKey,
                );
                return payDetails;
              } else {
                debugPrint("Problem in auth API response");
              }
            } on PlatformException catch (e) {
              debugPrint("Failed to decrypt: '${e.message}'.");
            }
          }
        } catch (e) {
          // paymnetFailedCallback(context);
          debugPrint("Failed to decrypt data in response: '$e'.");
        }
      }
    }
  }

  _openNdpsPG(payDetails, context, responseHashKey, responseDecryptionKey) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewContainer(
          mode,
          payDetails,
          responseHashKey,
          responseDecryptionKey,
        ),
      ),
    );
  }

  _getJsonPayloadData() {
    var payDetails = {};
    payDetails['login'] = login;
    payDetails['password'] = password;
    payDetails['prodid'] = prodid;
    payDetails['custFirstName'] = custFirstName;
    payDetails['custLastName'] = custLastName;
    payDetails['amount'] = amount;
    payDetails['mobile'] = mobile;
    payDetails['address'] = address;
    payDetails['email'] = email;
    payDetails['txnid'] = txnid;
    payDetails['custacc'] = custacc;
    payDetails['requestHashKey'] = requestHashKey;
    payDetails['responseHashKey'] = responseHashKey;
    payDetails['requestencryptionKey'] = requestEncryptionKey;
    payDetails['responseencypritonKey'] = responseDecryptionKey;
    payDetails['clientcode'] = clientcode;
    payDetails['txncurr'] = txncurr;
    payDetails['mccCode'] = mccCode;
    payDetails['merchType'] = merchType;
    payDetails['returnUrl'] = returnUrl;
    payDetails['mode'] = mode;
    payDetails['udf1'] = udf1;
    payDetails['udf2'] = udf2;
    payDetails['udf3'] = udf3;
    payDetails['udf4'] = udf4;
    payDetails['udf5'] = udf5;
    String jsonPayLoadData = getRequestJsonData(payDetails);
    return jsonPayLoadData;
  }
}
