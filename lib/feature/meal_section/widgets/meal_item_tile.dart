import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class MealItemTile extends StatelessWidget {
  final String mealType; // Breakfast, Snack, etc.
  final String mealName;
  final String calories;
  final String duration;
  final String placeholderLetter; // লোকাল টেস্ট করার জন্য ইমেজের লেটার

  const MealItemTile({
    super.key,
    required this.mealType,
    required this.mealName,
    required this.calories,
    required this.duration,
    required this.placeholderLetter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ইমেজ কন্টেইনার
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.border.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: Text(
              placeholderLetter,
              style: TextStyle(fontSize: 20.sp, color: AppColors.textSecondary),
            ),
          ),
          SizedBox(width: 14.w),
          // টেক্সট ইনফরমেশন
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealType,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  mealName,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.local_fire_department_outlined, size: 14.sp, color: AppColors.textSecondary),
                    SizedBox(width: 2.w),
                    Text(
                      "$calories kcal",
                      style: TextStyle(fontFamily: "Inter", fontSize: 11.sp, color: AppColors.textSecondary),
                    ),
                    SizedBox(width: 12.w),
                    Icon(Icons.access_time, size: 14.sp, color: AppColors.textSecondary),
                    SizedBox(width: 2.w),
                    Text(
                      "$duration min",
                      style: TextStyle(fontFamily: "Inter", fontSize: 11.sp, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}