import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pagemanagementcontroller extends GetxController {
  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final scrollController = ScrollController();

  void resetScroll() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  void onNavItemTapped(int index) {
    _selectedIndex = index;
    update();
    resetScroll();
  }

  void setPage(int page) {
    _currentPage = page;
    update();
  }

  void resetPage() {
    _currentPage = 1;
    update();
  }
}
