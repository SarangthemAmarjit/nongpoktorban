import 'package:get/get.dart';
import 'package:torbanticketing/routes/app_routes.dart';
import 'package:torbanticketing/view/formpage.dart';
import 'package:torbanticketing/view/landing.dart';
import 'package:torbanticketing/view/offlineticket.dart';

import '../controller/pagecon.dart' show Pagemanagementcontroller;

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.landing,
      page: () => MainLayout(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => Pagemanagementcontroller()),
      ),
    ),
    GetPage(
      name: AppRoutes.ticketbookingscreen,
      // middlewares: [Bookingmiddleware()],
      page: () => TicketBookingScreen(),
    ),
    GetPage(name: AppRoutes.offlineticket, page: () => OfflineReceiptPage()),
  ];
}
