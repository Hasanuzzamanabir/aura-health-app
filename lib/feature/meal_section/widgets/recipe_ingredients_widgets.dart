import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class RecipeIngredientsWidget extends StatelessWidget {
  final List<String> ingredients;

  const RecipeIngredientsWidget({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ingredients",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        ...ingredients.map((ingredient) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  Container(
                    width: 5.w,
                    height: 5.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    ingredient,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}