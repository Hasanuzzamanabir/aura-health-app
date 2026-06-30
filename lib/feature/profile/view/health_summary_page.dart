import 'package:aurahealth/feature/profile/widgets/tracking_card.dart';
import 'package:aurahealth/feature/profile/widgets/wide_tracking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';


class HealthSummaryScreen extends StatelessWidget {
  const HealthSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Tracking",
          style: AppStyle.poppinsSemiBold600(context).copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.25,
              children: const [
                TrackingCard(
                  title: "Weight",
                  value: "70.5",
                  unit: "kg",
                  subtitle: "-1.2 kg",
                  subtitleColor: AppColors.error,
                ),
                TrackingCard(
                  title: "Body Fat",
                  value: "18.6",
                  unit: "%",
                  subtitle: "-0.4%",
                  subtitleColor: AppColors.error,
                ),
                TrackingCard(
                  title: "Muscle Mass",
                  value: "56.3",
                  unit: "kg",
                  subtitle: "+0.8 kg",
                  subtitleColor: AppColors.primary,
                ),
                TrackingCard(
                  title: "Water Intake",
                  value: "1.8",
                  unit: "L",
                  subtitle: "Good",
                  subtitleColor: AppColors.textSecondary,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            const WideTrackingCard(
              title: "Sleep Score",
              value: "78",
              maxOrSubtitle: "/100",
              statusText: "Good",
              statusColor: Colors.blueAccent,
            ),
            SizedBox(height: 16.h),
            const WideTrackingCard(
              title: "Workouts",
              value: "4",
              maxOrSubtitle: "this week",
              statusText: "On Track",
              statusColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}