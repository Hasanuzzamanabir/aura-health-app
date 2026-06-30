import 'package:aurahealth/feature/meal_section/widgets/meal_ai_insight_card.dart';
import 'package:aurahealth/feature/meal_section/widgets/meal_info_row.dart';
import 'package:aurahealth/feature/meal_section/widgets/meal_macro_widgets.dart';
import 'package:aurahealth/feature/meal_section/widgets/recipe_ingredients_widgets.dart';
import 'package:aurahealth/feature/meal_section/widgets/recipe_instruction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/widget/custom_app_bar.dart';

class MealPlanDetails extends StatelessWidget {
  const MealPlanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Meal Plan"),
      body: SafeArea(
        child: Hero(
          tag: "Breakfast",
          child: Material(
            type: MaterialType.transparency,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
                      width: double.infinity,
                      height: 240.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 240.h,
                          color: AppColors.surface,
                          child: Icon(
                            Icons.fastfood_outlined,
                            size: 50.sp,
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Quinoa Chicken Bowl",
                    style: AppStyle.poppinsSemiBold600(
                      context,
                    ).copyWith(fontSize: 24.sp, color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 16.h),
                  const MealMacroWidget(
                    kcal: "520",
                    protein: "35g",
                    carbs: "45g",
                    fat: "15g",
                  ),
                  SizedBox(height: 16.h),
                  const Divider(color: AppColors.border, thickness: 0.8),
                  SizedBox(height: 14.h),
                  const MealInfoRow(
                    time: "30 min",
                    difficulty: "600kcal",
                    serving: "Easy",
                  ),
                  SizedBox(height: 20.h),
                  const MealAiInsightCard(
                    insightText: "Optimized for recovery and muscle repair.",
                  ),
                  SizedBox(height: 24.h),
                  const RecipeIngredientsWidget(
                    ingredients: [
                      "150g Chicken Breast",
                      "1 cup Quinoa",
                      "1/2 Avocado",
                      "Mixed Greens",
                    ],
                  ),
                  SizedBox(height: 24.h),
                  const RecipeInstructionsWidget(
                    instructions: [
                      "Cook quinoa as directed",
                      "Grill chicken breast",
                      "Assemble bowl with greens and avocado",
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 52.h),
                            backgroundColor: const Color(0xFF41B058),
                            elevation: 1,
                            shadowColor: const Color(
                              0xFF41B058,
                            ).withValues(alpha: 0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.r),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Add to Grocery List",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 52.h),
                            backgroundColor: const Color(0xFFEDF4EE),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.r),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: const Color(0xFF464E47),
                                  size: 18.sp,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "Mark as Completed",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF464E47),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 52.h),
                      backgroundColor: const Color(0xFFF7F8F9),
                      side: const BorderSide(
                        color: Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.r),
                      ),
                    ),
                    child: Text(
                      "Swap Meal",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2D3748),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
