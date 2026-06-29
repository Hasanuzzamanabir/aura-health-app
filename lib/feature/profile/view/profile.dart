import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:orange/core/utils/app_colors.dart';
import 'package:orange/core/widgets/custom_app_bar.dart';
import 'package:orange/feature/profile/view/personal_information.dart';
import 'package:orange/feature/profile/widgets/card_widget_file.dart';
// import 'custom_app_bar.dart'; 
// import 'profile_widgets.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountSectionItems = [
      ProfileTileData(icon: Icons.person_outline, title: 'Personal Information', onTap: () {
        Get.to(() => const PersonalInformationScreen());
      }),
      ProfileTileData(icon: Icons.link_rounded, title: 'Connected Devices', onTap: () {}),
      ProfileTileData(icon: Icons.monitor_heart_outlined, title: 'Health Summary', onTap: () {}),
      ProfileTileData(icon: Icons.analytics_outlined, title: 'Biomarkers', onTap: () {}),
      ProfileTileData(icon: Icons.credit_card_outlined, title: 'Subscription', onTap: () {}),
    ];

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: 'Profile'),
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
                  backgroundImage: const NetworkImage('https://placeholder.com/user_image.png'),
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
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.sp,
              ),
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
                child:  Text(
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
              onTap: () {},
            ),
            SettingsSingleCard(
              icon: Icons.shield_outlined,
              title: 'Privacy Policy',
              onTap: () {},
            ),
            SettingsSingleCard(
              icon: Icons.shield_outlined,
              title: 'Trams & Condition',
              onTap: () {},
            ),
            SettingsSingleCard(
              icon: Icons.help_outline_rounded,
              title: 'Help and support',
              onTap: () {},
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}