import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/feature/home/model/home_model.dart';
import 'package:aurahealth/feature/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:aurahealth/feature/meal_section/view/meal_plan_details.dart';
import 'package:aurahealth/feature/recipe_section/controller/recipe_controller.dart';

class TodayPlanSection extends StatelessWidget {
  final TodayMeal meal;
  final String progress;

  const TodayPlanSection({
    super.key,
    required this.meal,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "Today's Plan",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  progress,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the Meal Plan tab (index 1)
                final bottomNavController = Get.find<BottomNavController>();
                bottomNavController.changePage(BottomNavIndex.mealPlan.index);
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Text(
                    "See all",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.primary,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Meal Card
        GestureDetector(
          onTap: () {
            // Find recipe dynamically from RecipeController if available
            try {
              final recipeController = Get.find<RecipeController>();
              final recipe = recipeController.recipes.firstWhere(
                (r) => r.title.toLowerCase().contains("quinoa"),
              );
              Get.to(() => MealPlanDetails(recipe: recipe));
            } catch (e) {
              // Fallback
              Get.to(() => const MealPlanDetails());
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                // Meal Image Circle
                ClipOval(
                  child: Image.network(
                    meal.imageUrl,
                    width: 76.w,
                    height: 76.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 76.w,
                        height: 76.h,
                        color: AppColors.surface,
                        child: Icon(
                          Icons.restaurant_menu_outlined,
                          size: 32.sp,
                          color: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16.w),

                // Meal Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.mealType,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        meal.mealName,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        meal.ingredients,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary.withValues(alpha: 0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            meal.calories,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            meal.unit,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Chevron Arrow Right
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondary.withValues(alpha: 0.6),
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
