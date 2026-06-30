import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class RecipeInstructionsWidget extends StatelessWidget {
  final List<String> instructions;

  const RecipeInstructionsWidget({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Instructions",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        ...instructions.asMap().entries.map((entry) {
          int index = entry.key + 1;
          String step = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border.withOpacity(0.5)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$index",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Text(
                      step,
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}