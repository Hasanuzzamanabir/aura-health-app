import 'package:aurahealth/feature/meal_section/view/meal_plan_details.dart';
import 'package:aurahealth/feature/meal_section/widgets/meal_item_tile.dart';
import 'package:aurahealth/feature/meal_section/widgets/micro_nutrient_card.dart';
import 'package:aurahealth/feature/meal_section/widgets/weekly_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/widget/custom_app_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  String _getWeekdayName(DateTime date) {
    final shortNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return shortNames[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: "Meal Plan", isBack: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 14.h,
              childAspectRatio: 1.35,
              children: const [
                MacroNutrientCard(
                  icon: Icons.local_fire_department,
                  title: "Calories",
                  currentAmount: "1892",
                  targetAmount: "2200",
                  unit: "kcal",
                  progress: 0.86,
                ),
                MacroNutrientCard(
                  icon: Icons.fitness_center,
                  title: "Protein",
                  currentAmount: "125",
                  targetAmount: "150",
                  unit: "g",
                  progress: 0.83,
                ),
                MacroNutrientCard(
                  icon: Icons.grain,
                  title: "Carbohydrates",
                  currentAmount: "210",
                  targetAmount: "275",
                  unit: "g",
                  progress: 0.76,
                ),
                MacroNutrientCard(
                  icon: Icons.opacity,
                  title: "Lipids",
                  currentAmount: "65",
                  targetAmount: "75",
                  unit: "g",
                  progress: 0.86,
                ),
              ],
            ),

            SizedBox(height: 20.h),

            WeeklyOverviewCard(
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),

            SizedBox(height: 24.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_getWeekdayName(_selectedDate)}'s Meals",
                  style: AppStyle.poppinsSemiBold600(
                    context,
                  ).copyWith(fontSize: 18.sp),
                ),
                Text(
                  "4 meals",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            Hero(
              tag: 'Breakfast',
              child: MealItemTile(
                mealType: "Breakfast",
                mealName: "Greek Yogurt Bowl",
                calories: "520",
                duration: "10",
                placeholderLetter: "🥣",
                onTap: () {
                  Get.to(() => const MealPlanDetails());
                },
              ),
            ),
            MealItemTile(
              mealType: "Snack",
              mealName: "Protein Smoothie",
              calories: "192",
              duration: "5",
              placeholderLetter: "🥛",
              onTap: () {
                Get.to(() => const MealPlanDetails());
              },
            ),
            MealItemTile(
              mealType: "Lunch",
              mealName: "Quinoa Chicken Bowl",
              calories: "600",
              duration: "30",
              placeholderLetter: "🥗",
              onTap: () {
                Get.to(() => const MealPlanDetails());
              },
            ),
            MealItemTile(
              mealType: "Dinner",
              mealName: "Salmon & Veggies",
              calories: "560",
              duration: "25",
              placeholderLetter: "🐟",
              onTap: () {
                Get.to(() => const MealPlanDetails());
              },
            ),
          ],
        ),
      ),
    );
  }
}
