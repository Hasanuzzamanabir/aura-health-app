import 'package:get/get.dart';
import 'package:orange/feature/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:orange/feature/profile/view/personal_information.dart';

class AppRoutes {
  static const String bottomNavBarScreen = '/BottomNavBarScreen';
  static const String personalInformationScreen = '/PersonalInformationScreen';
  
  static String getBottomNavBarScreen() => bottomNavBarScreen;
  static String getPersonalInformationScreen() => personalInformationScreen;

  static List<GetPage> routes = [
    GetPage(
      name: bottomNavBarScreen,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: personalInformationScreen,
      page: () => const PersonalInformationScreen(),
    ),
  ];
}