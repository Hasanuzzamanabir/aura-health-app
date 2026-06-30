import 'package:aurahealth/core/utils/getting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/feature/home/controller/home_controller.dart';
import 'package:aurahealth/feature/home/widgets/metric_card.dart';
import 'package:aurahealth/feature/notification/view/notification_screen.dart';

import 'package:aurahealth/feature/home/widgets/weight_trends_card.dart';
import 'package:aurahealth/feature/home/widgets/health_metric_card.dart';

import 'package:aurahealth/feature/home/widgets/sleep_duration_card.dart';
import 'package:aurahealth/feature/home/widgets/today_plan_section.dart';
import 'package:aurahealth/feature/home/widgets/biomarkers_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject/retrieve the HomeController
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          final data = controller.homeData.value;
          if (data == null) {
            return const Center(child: Text("No health data available"));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Getting.getGreeting(),
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                data.userName,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                  height: 1.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Notification Icon with Red Badge Dot
                        GestureDetector(
                          onTap: () => Get.toNamed(
                            NotificationScreen.notificationScreen,
                          ),
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.all(4.w),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(
                                  Icons.notifications_none_outlined,
                                  size: 28.sp,
                                  color: AppColors.textPrimary,
                                ),
                                if (data.hasNotification)
                                  Positioned(
                                    right: 2.w,
                                    top: 2.h,
                                    child: Container(
                                      width: 8.w,
                                      height: 8.h,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      data.subGreeting,
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2x2 Grid of Metric Cards (Weight, Sleep, Readiness, Health Score)
                      Row(
                        children: [
                          Expanded(child: MetricCard(metric: data.weight)),
                          SizedBox(width: 16.w),
                          Expanded(child: MetricCard(metric: data.sleep)),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(child: MetricCard(metric: data.readiness)),
                          SizedBox(width: 16.w),
                          Expanded(child: MetricCard(metric: data.healthScore)),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Weight Trends Card (Full width)
                      WeightTrendsCard(trend: data.weightTrend),
                      SizedBox(height: 24.h),

                      // 3x2 Grid of new health metrics (Calories, Steps, Active Minutes, Heart Rate, HRV, Stress)
                      Row(
                        children: [
                          Expanded(
                            child: HealthMetricCard(metric: data.calories),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(child: HealthMetricCard(metric: data.steps)),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: HealthMetricCard(metric: data.activeMinutes),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: HealthMetricCard(metric: data.heartRate),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(child: HealthMetricCard(metric: data.hrv)),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: HealthMetricCard(metric: data.stress),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Sleep Duration Card (Full width at the very bottom)
                      SleepDurationCard(trend: data.sleepDurationTrend),
                      SizedBox(height: 24.h),

                      // Today's Plan Meal Card Section
                      TodayPlanSection(
                        meal: data.todayMeal,
                        progress: data.todayPlanProgress,
                      ),

                      SizedBox(height: 24.h),

                      // Blood Biomarkers Section
                      BiomarkersSection(biomarkers: data.biomarkers),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
