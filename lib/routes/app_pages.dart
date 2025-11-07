import 'package:get/get.dart';
import 'package:torbanticketing/controller/pagecon.dart';
import 'package:torbanticketing/view/home.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeContent(),

      binding: BindingsBuilder(
        () => Get.lazyPut(() => Pagemanagementcontroller()),
      ),
    ),
  ];
}
