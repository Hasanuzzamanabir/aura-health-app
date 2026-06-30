import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class MealMacroWidget extends StatelessWidget {
  final String kcal;
  final String protein;
  final String carbs;
  final String fat;

  const MealMacroWidget({
    super.key,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildItem(kcal, "kcal"),
        _buildDivider(),
        _buildItem(protein, "Protein"),
        _buildDivider(),
        _buildItem(carbs, "Carbs"),
        _buildDivider(),
        _buildItem(fat, "Fat"),
      ],
    );
  }

  Widget _buildItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 12.sp,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1.w,
      height: 24.h,
      color: AppColors.border.withValues(alpha: 0.6),
    );
  }
}