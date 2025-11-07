import 'package:get/get.dart';
import 'package:torbanticketing/controller/pagecon.dart';



class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Pagemanagementcontroller());
   
  }
}
