import 'package:aurahealth/feature/ai_section/view/ai_chat.dart';
import 'package:aurahealth/feature/auth/change_password/screen/change_password.dart';
import 'package:aurahealth/feature/auth/forgot_password/screen/forgot_password.dart';
import 'package:aurahealth/feature/auth/otp_screen/screen/otp_screen.dart';
import 'package:aurahealth/feature/notification/view/notification_screen.dart';
import 'package:aurahealth/feature/success/success_screen.dart';
import 'package:get/get.dart';
import 'package:aurahealth/feature/auth/login/screen/login_screen.dart';
import 'package:aurahealth/feature/auth/signup/screen/signup_screen.dart';
import 'package:aurahealth/feature/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:aurahealth/feature/splash_screen/splash_screen.dart';
import 'package:aurahealth/feature/onboarding/screen/onboarding_steps_screen.dart';
import 'package:aurahealth/feature/onboarding/screen/plan_ready_screen.dart';

class AppRoutes {
  static List<GetPage> routes = [
    //Bottom Nav bar
    GetPage(
      name: BottomNavBarScreen.bottomNavBarScreen,
      page: () => const MainScreen(),
    ),

    //AI Chat Screen
    GetPage(
      name: AiChatScreen.aiChatScreen,
      page: () => const AiChatScreen(),
    ),

    //Splash Screen
    GetPage(name: SplashScreen.splashScreen, page: () => const SplashScreen()),

    //Login Screen
    GetPage(name: LoginScreen.loginScreen, page: () => const LoginScreen()),

    //singup screen
    GetPage(name: SignupScreen.signupScreen, page: () => const SignupScreen()),
    //notification screen
    GetPage(name: NotificationScreen.notificationScreen, page: () => const NotificationScreen()),

    //forgot password screen
    GetPage(
      name: ForgotPassword.forgotPassword,
      page: () => const ForgotPassword(),
    ),

    //otp  screen
    GetPage(
      name: OtpScreen.otpScreen,
      page: () {
        final args = Get.arguments;
        if (args is Map<String, dynamic>) {
          return OtpScreen(
            email: args['email'] as String? ?? '',
            signUp: args['signUp'] as bool? ?? false,
          );
        }
        return OtpScreen(
          email: args is String ? args : '',
          signUp: false,
        );
      },
    ),

    //change passworrd  screen
    GetPage(
      name: ChangePassword.changePassword,
      page: () => const ChangePassword(),
    ),

    //success screen
    GetPage(
      name: SuccessScreen.successScreen,
      page: () => const SuccessScreen(),
    ),

    // onboarding steps screen
    GetPage(
      name: OnboardingStepsScreen.onboardingStepsScreen,
      page: () => const OnboardingStepsScreen(),
    ),

    // plan ready screen
    GetPage(
      name: PlanReadyScreen.planReadyScreen,
      page: () => const PlanReadyScreen(),
    ),
  ];
}
