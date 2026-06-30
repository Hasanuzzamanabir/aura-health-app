import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class WeeklyOverviewCard extends StatelessWidget {
  const WeeklyOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    // ডামি ডেইজ ডাটা
    final List<Map<String, String>> days = [
      {"date": "20", "day": "M"},
      {"date": "21", "day": "T"},
      {"date": "22", "day": "W"},
      {"date": "23", "day": "T"},
      {"date": "24", "day": "F"}, // Active Day
      {"date": "25", "day": "S"},
      {"date": "26", "day": "S"},
    ];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weekly Overview",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "14,031 / 15,400 kcal this week",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 11.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: AppColors.primaryDark, size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "AI Optimized",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((d) {
              bool isActive = d["date"] == "24"; // ইমেজ অনুযায়ী ২৪ তারিখ অ্যাক্টিভ
              return Column(
                children: [
                  Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : AppColors.primaryLight.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      d["date"]!,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: isActive ? AppColors.white : AppColors.textPrimary.withOpacity(0.7),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    d["day"]!,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 11.sp,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}