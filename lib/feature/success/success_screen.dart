import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/feature/auth/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  static const String successScreen = "/successScreen";

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(LoginScreen.loginScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/Success.json',
                  width: 150.w,
                  height: 150.h,
                  repeat: false,
                ),
                SizedBox(height: 24.h),
                Text(
                  "Password Changed!",
                  textAlign: TextAlign.center,
                  style: AppStyle.interMedium500(context).copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Your password has been changed\nsuccessfully.",
                  textAlign: TextAlign.center,
                  style: AppStyle.interMedium500(context).copyWith(
                    color: AppColors.labelTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
