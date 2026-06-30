import 'package:aurahealth/feature/meal_section/widgets/meal_ai_insight_card.dart';
import 'package:aurahealth/feature/meal_section/widgets/meal_info_row.dart';
import 'package:aurahealth/feature/meal_section/widgets/meal_macro_widgets.dart';
import 'package:aurahealth/feature/meal_section/widgets/recipe_ingredients_widgets.dart';
import 'package:aurahealth/feature/meal_section/widgets/recipe_instruction_widget.dart';
import 'package:aurahealth/feature/recipe_section/view/recipe_section_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/widget/custom_app_bar.dart';
import 'package:aurahealth/feature/recipe_section/model/recipe_model.dart';
import 'package:aurahealth/feature/recipe_section/controller/recipe_controller.dart';
import 'package:get/get.dart';

class MealPlanDetails extends StatelessWidget {
  final RecipeModel? recipe;

  const MealPlanDetails({super.key, this.recipe});

  @override
  Widget build(BuildContext context) {
    final RxBool isCompleted = false.obs;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Meal Plan"),
      body: SafeArea(
        child: Hero(
          tag: recipe != null ? recipe!.title : "Breakfast",
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
                      recipe?.imageUrl ??
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
                    recipe?.title ?? "Quinoa Chicken Bowl",
                    style: AppStyle.poppinsSemiBold600(
                      context,
                    ).copyWith(fontSize: 24.sp, color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 16.h),
                  if (recipe == null) ...[
                    const MealMacroWidget(
                      kcal: "520",
                      protein: "35g",
                      carbs: "45g",
                      fat: "15g",
                    ),
                    SizedBox(height: 16.h),
                    const Divider(color: AppColors.border, thickness: 0.8),
                    SizedBox(height: 14.h),
                  ],
                  MealInfoRow(
                    time: recipe?.time ?? "30 min",
                    difficulty: recipe?.calories ?? "600kcal",
                    serving: recipe?.difficulty ?? "Easy",
                  ),
                  SizedBox(height: 20.h),
                  MealAiInsightCard(
                    insightText:
                        recipe?.aiInsight ??
                        "Optimized for recovery and muscle repair.",
                  ),
                  SizedBox(height: 24.h),
                  RecipeIngredientsWidget(
                    ingredients:
                        recipe?.ingredients ??
                        const [
                          "150g Chicken Breast",
                          "1 cup Quinoa",
                          "1/2 Avocado",
                          "Mixed Greens",
                        ],
                  ),
                  SizedBox(height: 24.h),
                  RecipeInstructionsWidget(
                    instructions:
                        recipe?.instructions ??
                        const [
                          "Cook quinoa as directed",
                          "Grill chicken breast",
                          "Assemble bowl with greens and avocado",
                        ],
                  ),
                  SizedBox(height: 32.h),
                  if (recipe != null)
                    ElevatedButton(
                      onPressed: () {
                        final controller = Get.find<RecipeController>();
                        for (var ing in recipe!.ingredients) {
                          String name = ing;
                          String quantity = "1 pc";
                          String category = "Carbs/Pantry";

                          final parts = ing.split(" ");
                          if (parts.length > 1) {
                            final firstWord = parts[0];
                            if (RegExp(
                              r'^\d+(\/\d+)?(\.\d+)?$',
                            ).hasMatch(firstWord)) {
                              final secondWord = parts[1].toLowerCase();
                              if ([
                                "cup",
                                "cups",
                                "scoop",
                                "scoops",
                                "g",
                                "kg",
                                "pcs",
                                "ml",
                                "l",
                                "tbsp",
                                "tsp",
                              ].contains(secondWord)) {
                                quantity = "$firstWord ${parts[1]}";
                                name = parts.sublist(2).join(" ");
                              } else {
                                quantity = firstWord;
                                name = parts.sublist(1).join(" ");
                              }
                            }
                          }

                          final lowerName = name.toLowerCase();
                          if (lowerName.contains("chicken") ||
                              lowerName.contains("salmon") ||
                              lowerName.contains("eggs") ||
                              lowerName.contains("yogurt") ||
                              lowerName.contains("protein")) {
                            category = "Proteins";
                          } else if (lowerName.contains("banana") ||
                              lowerName.contains("broccoli") ||
                              lowerName.contains("spinach") ||
                              lowerName.contains("tomato") ||
                              lowerName.contains("lemon") ||
                              lowerName.contains("greens")) {
                            category = "Vegetables";
                          } else if (lowerName.contains("avocado") ||
                              lowerName.contains("almond") ||
                              lowerName.contains("oil") ||
                              lowerName.contains("chia") ||
                              lowerName.contains("seeds")) {
                            category = "Healthy Fats";
                          }

                          final exists = controller.groceryItems.any(
                            (item) =>
                                item.name.toLowerCase() == name.toLowerCase(),
                          );
                          if (!exists) {
                            controller.groceryItems.add(
                              GroceryItem(
                                name: name,
                                category: category,
                                quantity: quantity,
                              ),
                            );
                          }
                        }

                        Get.snackbar(
                          "Ingredients Added",
                          "this item is added Grocery List",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF41B058),
                          colorText: Colors.white,
                          borderRadius: 12.r,
                          margin: EdgeInsets.all(16.w),
                          duration: const Duration(seconds: 2),
                        );
                      },
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
                      ),
                      child: Text(
                        "Add to Grocery List",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    )
                  else ...[
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.snackbar(
                                "Ingredients Added",
                                "this item is added Grocery List",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(0xFF41B058),
                                colorText: Colors.white,
                                borderRadius: 12.r,
                                margin: EdgeInsets.all(16.w),
                                duration: const Duration(seconds: 2),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 52.h),
                              backgroundColor: const Color(0xFF41B058),
                              elevation: 1,
                              shadowColor: const Color(
                                0xFF41B058,
                              ).withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26.r)),
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
                          child: Obx(
                            () => ElevatedButton(
                              onPressed: () {
                                if (!isCompleted.value) {
                                  isCompleted.value = true;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 52.h),
                                backgroundColor:  const Color(0xFFEDF4EE),
                                elevation: isCompleted.value ? 1 : 0,
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
                                    if (isCompleted.value) ...[
                                      Icon(
                                        Icons.check,
                                        color: Colors.black,
                                        size: 18.sp,
                                      ),
                                      SizedBox(width: 6.w),
                                    ],
                                    Text(
                                      "Mark as Completed",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    OutlinedButton(
                      onPressed: () {
                        Get.to(() => const RecipeSectionScreen(
                          swapMealPlan: true,
                        ));
                      },
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
