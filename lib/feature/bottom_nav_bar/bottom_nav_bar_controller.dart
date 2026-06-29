import 'package:get/get.dart';

enum BottomNavIndex { home, mealPlan, aiCoach, recipes, profile }

class BottomNavController extends GetxController {
  var fontLevel = 1.0.obs;
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
