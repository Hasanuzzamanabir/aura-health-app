import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/image_path.dart';
import 'package:aurahealth/feature/ai_section/view/ai_chat.dart';
import 'package:aurahealth/feature/bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'package:aurahealth/feature/home/view/home.dart';
import 'package:aurahealth/feature/meal_section/view/meal_view.dart';
import 'package:aurahealth/feature/profile/view/profile.dart';
import 'package:aurahealth/feature/recipe_section/view/recipe_section_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppFontScale {
  static double legacy(double base, double level, {required int divisor}) {
    return base + (level / divisor);
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    final List<Widget> pages = [
      const HomeScreen(),
      const MealScreen(),
      const SizedBox.shrink(),
      const RecipeSectionScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(
        () =>
            IndexedStack(index: controller.currentIndex.value, children: pages),
      ),
      bottomNavigationBar: const BottomNavBarScreen(),
    );
  }
}

class BottomNavBarScreen extends GetView<BottomNavController> {
  const BottomNavBarScreen({super.key});

  static const String bottomNavBarScreen = '/bottomNavBarScreen';

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.paddingOf(context).bottom;

    return SizedBox(
      height: 80.h + bottomPadding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 62.h + bottomPadding,
            child: Container(
              padding: EdgeInsets.only(bottom: bottomPadding),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 15,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Obx(() {
                final level = controller.fontLevel.value;
                final currentIndex = controller.currentIndex.value;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _AppBottomNavItem(
                      icon: ImagePath.homeIcon,
                      label: 'Home',
                      index: BottomNavIndex.home.index,
                      currentIndex: currentIndex,
                      fontLevel: level,
                      onTap: controller.changePage,
                    ),
                    _AppBottomNavItem(
                      icon: ImagePath.mealIcon,
                      label: 'Meal Plan',
                      index: BottomNavIndex.mealPlan.index,
                      currentIndex: currentIndex,
                      fontLevel: level,
                      onTap: controller.changePage,
                    ),
                    SizedBox(width: 56.w),
                    _AppBottomNavItem(
                      icon: ImagePath.recipeIcon,
                      label: 'Recipes',
                      index: BottomNavIndex.recipe.index,
                      currentIndex: currentIndex,
                      fontLevel: level,
                      onTap: controller.changePage,
                    ),
                    _AppBottomNavItem(
                      icon: ImagePath.profileIcon,
                      label: 'Profile',
                      index: BottomNavIndex.profile.index,
                      currentIndex: currentIndex,
                      fontLevel: level,
                      onTap: controller.changePage,
                    ),
                  ],
                );
              }),
            ),
          ),
          Positioned(
            top: -2.h,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Get.toNamed(AiChatScreen.aiChatScreen),
                child: Obx(() {
                  final level = controller.fontLevel.value;
                  final currentIndex = controller.currentIndex.value;
                  final aiActive = currentIndex == BottomNavIndex.aiCoach.index;

                  return AnimatedScale(
                    scale: aiActive ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.aiGradientStart,
                            AppColors.aiGradientEnd,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImagePath.aiIcon,
                            height: 22.h,
                            width: 22.w,
                            color: AppColors.background,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'AI Coach',
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: AppFontScale.legacy(
                                8.5,
                                level,
                                divisor: 3,
                              ).sp,
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
          ),
        ],
      ),
    );
  }
}

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
              height: 20.h,
              width: 20.w,
              color: activeColor,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 3.h),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: activeColor,
                fontSize: AppFontScale.legacy(10, fontLevel, divisor: 3).sp,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
