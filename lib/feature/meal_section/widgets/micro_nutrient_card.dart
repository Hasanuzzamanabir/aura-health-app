import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class MacroNutrientCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String currentAmount;
  final String targetAmount;
  final String unit;
  final double progress; // Value between 0.0 and 1.0

  const MacroNutrientCard({
    super.key,
    required this.icon,
    required this.title,
    required this.currentAmount,
    required this.targetAmount,
    required this.unit,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                title,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currentAmount,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4.h, left: 2.w),
                child: Text(
                  "/ $targetAmount $unit",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: AppColors.border.withOpacity(0.5),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}