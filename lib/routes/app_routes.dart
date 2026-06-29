import 'package:get/get.dart';
import 'package:aurahealth/feature/auth/login/screen/login_screen.dart';
import 'package:aurahealth/feature/auth/signup/screen/signup_screen.dart';
import 'package:aurahealth/feature/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:aurahealth/feature/splash_screen/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes = [
    //Bottom Nav bar
    GetPage(
      name: BottomNavBarScreen.bottomNavBarScreen,
      page: () => const MainScreen(),
    ),

    //Splash Screen
    GetPage(name: SplashScreen.splashScreen, page: () => const SplashScreen()),

    //Login Screen
    GetPage(name: LoginScreen.loginScreen, page: () => const LoginScreen()),

    //singup screen
    GetPage(name: SignupScreen.signupScreen, page: () => const SignupScreen()),
  ];
}
