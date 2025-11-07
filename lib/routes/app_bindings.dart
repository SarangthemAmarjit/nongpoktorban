import 'package:get/get.dart';
import 'package:torbanticketing/controller/managementcontroller.dart';
import 'package:torbanticketing/controller/pagecon.dart';
import 'package:torbanticketing/controller/paymentcontroller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Pagemanagementcontroller());
    Get.put(Managementcontroller());
    Get.put(Paymentcontroller());
  }
}
