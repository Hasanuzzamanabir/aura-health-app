import 'package:get/get.dart';
import 'package:orange/feature/bottom_nav_bar/bottom_nav_bar.dart';

class AppRoutes {
  static const String bottomNavBarScreen = '/BottomNavBarScreen';
  
  static String getBottomNavBarScreen() => bottomNavBarScreen;

  static List<GetPage> routes = [
    GetPage(
      name: bottomNavBarScreen,
      page: () => const MainScreen(),
    ),
  ];
}