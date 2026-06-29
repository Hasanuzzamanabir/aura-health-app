import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orange/core/utils/app_colors.dart';
import 'package:orange/core/utils/icon_path.dart';
import 'package:orange/feature/ai_section/view/ai_chat.dart';
import 'package:orange/feature/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:orange/feature/home/view/home.dart';
import 'package:orange/feature/meal_section/view/meal_view.dart';
import 'package:orange/feature/recipe_section/view/recipe_section_screen.dart';
import 'package:orange/feature/profile/view/profile.dart';

// আপনার আলাদা করা কন্ট্রোলার ফাইলটি এখানে সঠিকভাবে ইমপোর্ট করুন
// import 'package:orange/feature/bottom_nav_bar/bottom_nav_controller.dart'; 

class AppFontScale {
  static double legacy(double base, double level, {required int divisor}) {
    return base + (level / divisor);
  }
}

// ==========================================
// ১. MAIN SCREEN 
// ==========================================
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলারটি এখানে মেমোরিতে ইনিশিয়েলাইজ করা হলো
    final BottomNavController controller = Get.put(BottomNavController());

    final List<Widget> pages = [
      const HomeScreen(),
      const MealScreen(),
      const AiChat(),
      const RecipeSectionScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Obx(() => BottomNavBarScreen(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.changePage(index);
            },
          )),
    );
  }
}

// ==========================================
// ২. CUSTOM BOTTOM NAV BAR WIDGET (GetView ব্যবহার করা হয়েছে)
// ==========================================
class BottomNavBarScreen extends GetView<BottomNavController> {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBarScreen({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // GetView ব্যবহার করার কারণে এখানে আলাদা করে কোনো Get.put বা Get.find এর লাইনের প্রয়োজন নেই।
    return SizedBox(
      height: 85.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 75.h,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 20,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Obx(() {
              final level = controller.fontLevel.value;
              
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _AppBottomNavItem(
                    icon: IconPath.homeIcon,
                    label: 'Home',
                    index: BottomNavIndex.home.index,
                    currentIndex: currentIndex,
                    fontLevel: level,
                    onTap: onTap,
                  ),
                  _AppBottomNavItem(
                    icon: IconPath.mealIcon,
                    label: 'Meal Plan',
                    index: BottomNavIndex.mealPlan.index,
                    currentIndex: currentIndex,
                    fontLevel: level,
                    onTap: onTap,
                  ),
                  SizedBox(width: 70.w), // মাঝখানের AI Coach এর জন্য ফাঁকা জায়গা
                  _AppBottomNavItem(
                    icon: IconPath.recipeIcon,
                    label: 'Recipes',
                    index: BottomNavIndex.recipes.index,
                    currentIndex: currentIndex,
                    fontLevel: level,
                    onTap: onTap,
                  ),
                  _AppBottomNavItem(
                    icon: IconPath.profileIcon,
                    label: 'Profile',
                    index: BottomNavIndex.profile.index,
                    currentIndex: currentIndex,
                    fontLevel: level,
                    onTap: onTap,
                  ),
                ],
              );
            }),
          ),
          Positioned(
            top: -15.h,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(BottomNavIndex.aiCoach.index),
              child: Obx(() {
                final level = controller.fontLevel.value;
                final aiActive = currentIndex == BottomNavIndex.aiCoach.index;

                return AnimatedScale(
                  scale: aiActive ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  child: Container(
                    height: 76.h,
                    width: 76.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          IconPath.aiIcon,
                          height: 28.h,
                          width: 28.w,
                          color: AppColors.white,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'AI Coach',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: AppFontScale.legacy(10, level, divisor: 3).sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// ৩. BOTTOM NAV ITEM SUB-WIDGET
// ==========================================
class _AppBottomNavItem extends StatelessWidget {
  final String icon;
  final String label;
  final int index;
  final int currentIndex;
  final double fontLevel;
  final ValueChanged<int> onTap;

  const _AppBottomNavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.fontLevel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = index == currentIndex;
    final activeColor = active ? AppColors.primary : AppColors.textSecondary;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 24.h,
              width: 24.w,
              color: activeColor,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 5.h),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: activeColor,
                fontSize: AppFontScale.legacy(12, fontLevel, divisor: 3).sp,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}