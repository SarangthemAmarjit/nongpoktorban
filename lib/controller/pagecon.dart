import 'package:get/get.dart';

class Pagemanagementcontroller extends GetxController {
  int _currentPage = 1;
  int get currentPage => _currentPage;

  void setPage(int page) {
    _currentPage = page;
    update();
  }

  void resetPage() {
    _currentPage = 1;
    update();
  }
}
