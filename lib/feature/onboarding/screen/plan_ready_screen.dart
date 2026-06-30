import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/feature/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:aurahealth/feature/onboarding/controller/onboarding_controller.dart';

class PlanReadyScreen extends StatelessWidget {
  const PlanReadyScreen({super.key});

  static const String planReadyScreen = '/planReadyScreen';

  @override
  Widget build(BuildContext context) {
    // Retrieve the existing OnboardingController instance
    final controller = Get.find<OnboardingController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),

              // Thumbs-up green circle icon
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.thumb_up_alt_rounded,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),

              SizedBox(height: 24.h),

              // Title
              Text(
                "Your plan is ready!",
                style: AppStyle.poppinsSemiBold600(context).copyWith(
                  fontSize: 32.sp,
                  height: 1.2,
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle
              Text(
                "Based on your data, here is your personalized summary.",
                style: AppStyle.interMedium500(context).copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),

              SizedBox(height: 32.h),

              // 1. Daily Calories Card
              _buildSummaryCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Calories",
                      style: AppStyle.interMedium500(context).copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          controller.dailyCaloriesTarget.toString(),
                          style: AppStyle.poppinsSemiBold600(context).copyWith(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "kcal",
                          style: AppStyle.interMedium500(context).copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Goal: ${controller.dailyCaloriesMaintenanceGoal} kcal",
                      style: AppStyle.interMedium500(context).copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // 2. Macros Card
              _buildSummaryCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Macros",
                      style: AppStyle.interMedium500(context).copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Protein
                        _buildMacroColumn(
                          context: context,
                          label: "Protein",
                          amount: "${controller.targetProtein}g",
                          lineColor: AppColors.primary,
                        ),
                        // Carbs
                        _buildMacroColumn(
                          context: context,
                          label: "Carbs",
                          amount: "${controller.targetCarbs}g",
                          lineColor: Colors.blue,
                        ),
                        // Fat
                        _buildMacroColumn(
                          context: context,
                          label: "Fat",
                          amount: "${controller.targetFat}g",
                          lineColor: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // 3. Recovery Score Card
              _buildSummaryCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recovery Score",
                            style: AppStyle.interMedium500(context).copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "82",
                                style: AppStyle.poppinsSemiBold600(context).copyWith(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                  height: 1.1,
                                ),
                              ),
                              Text(
                                " / 100",
                                style: AppStyle.interMedium500(context).copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Optimal",
                            style: AppStyle.interMedium500(context).copyWith(
                              color: AppColors.primary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.show_chart_rounded,
                        color: AppColors.primary,
                        size: 22.sp,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Start Your Journey Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Main dashboard screen and clear stack
                    Get.offAllNamed(BottomNavBarScreen.bottomNavBarScreen);
                  },
                  child: const Text("Start Your Journey"),
                ),
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper summary card widget
  Widget _buildSummaryCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border, width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  // Helper macro column widget
  Widget _buildMacroColumn({
    required BuildContext context,
    required String label,
    required String amount,
    required Color lineColor,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyle.interMedium500(context).copyWith(
              color: AppColors.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            amount,
            style: AppStyle.poppinsSemiBold600(context).copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            height: 4.h,
            width: 44.w,
            decoration: BoxDecoration(
              color: lineColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ),
    );
  }
}
