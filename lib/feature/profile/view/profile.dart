import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/widget/custom_app_bar.dart';
import 'package:aurahealth/feature/auth/login/screen/login_screen.dart';
import 'package:aurahealth/feature/help_and_support.dart/view/help_and_support_sreen.dart';
import 'package:aurahealth/feature/onboarding/controller/onboarding_controller.dart';
import 'package:aurahealth/feature/onboarding/screen/onboarding_steps_screen.dart';
import 'package:aurahealth/feature/profile/view/bio_marker_screen.dart';
import 'package:aurahealth/feature/profile/view/health_summary_page.dart';
import 'package:aurahealth/feature/profile/view/personal_information.dart';
import 'package:aurahealth/feature/profile/view/subscription_screen.dart';
import 'package:aurahealth/feature/profile/widgets/card_widget_file.dart';
import 'package:aurahealth/feature/settings/view/about_screen.dart';
import 'package:aurahealth/feature/settings/view/privecy_screen.dart';
import 'package:aurahealth/feature/settings/view/trams_and_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import 'custom_app_bar.dart';
// import 'profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFECEF), // soft red tint
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    color: AppColors.error,
                    size: 26.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Are you sure you want to log out of your account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          side: BorderSide(color: AppColors.border, width: 1.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Get.offAll(() => const LoginScreen());
                        },
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountSectionItems = [
      ProfileTileData(
        icon: Icons.person_outline,
        title: 'Personal Information',
        onTap: () {
          Get.to(() => const PersonalInformationScreen());
        },
      ),
      ProfileTileData(
        icon: Icons.link_rounded,
        title: 'Connected Devices',
        onTap: () {
          final controller = Get.put(OnboardingController());
          Get.to(
            () => Scaffold(
              backgroundColor: AppColors.surface,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => Get.back(),
                ),
                title: Text(
                  'Connected Devices',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
                backgroundColor: AppColors.surface,
                elevation: 0,
              ),
              body: SafeArea(
                child: Step4ConnectDevices(controller: controller),
              ),
            ),
          );
        },
      ),
      ProfileTileData(
        icon: Icons.monitor_heart_outlined,
        title: 'Health Summary',
        onTap: () {
          Get.to(() => const HealthSummaryScreen());
        },
      ),
      ProfileTileData(
        icon: Icons.analytics_outlined,
        title: 'Biomarkers',
        onTap: () {
          Get.to(() => const BiomarkerScreen());
        },
      ),
      ProfileTileData(
        icon: Icons.credit_card_outlined,
        title: 'Subscription',
        onTap: () {
          Get.to(() => const SubscriptionScreen());
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: 'Profile', isBack: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryLight, width: 2.w),
                ),
                child: CircleAvatar(
                  radius: 45.r,
                  backgroundColor: AppColors.border,
                  backgroundImage: const NetworkImage(
                    'https://imgs.search.brave.com/ZmFlfJH5KKHzXpcekBlo3lAU8de84r5qnmS6chnO7cI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvOTM4/NzA5MzYyL3Bob3Rv/L3BvcnRyYWl0LW9m/LWEtZ2lybC5qcGc_/cz02MTJ4NjEyJnc9/MCZrPTIwJmM9VVFH/WHBlaUxySTc4bk8x/QjlwZVVuMEQwZkNT/UnJtLUo4eG9oTVdH/Mkxtcz0',
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Emma Wilson',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'emma.wilson@email.com',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(radius: 4.r, backgroundColor: AppColors.primary),
                  SizedBox(width: 6.w),
                  Text(
                    'Premium Plan',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            ProfileGroupCard(items: accountSectionItems),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SettingsSingleCard(
              icon: Icons.info_outline_rounded,
              title: 'About',
              onTap: () {
                Get.to(() => const AboutScreen());
              },
            ),
            SettingsSingleCard(
              icon: Icons.shield_outlined,
              title: 'Privacy Policy',
              onTap: () {
                Get.to(() => const PrivacyPolicyScreen());
              },
            ),
            SettingsSingleCard(
              icon: Icons.shield_outlined,
              title: 'Trams & Condition',
              onTap: () {
                Get.to(() => const TermsConditionScreen());
              },
            ),
            SettingsSingleCard(
              icon: Icons.help_outline_rounded,
              title: 'Help and support',
              onTap: () {
                Get.to(() => const HelpSupportScreen());
              },
            ),
            SettingsSingleCard(
              icon: Icons.logout,
              title: 'Log Out',
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
