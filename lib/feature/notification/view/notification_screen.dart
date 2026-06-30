import 'package:aurahealth/feature/notification/widgets/notification_filter_chips.dart';
import 'package:aurahealth/feature/notification/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/widget/custom_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const String notificationScreen = '/notification_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Notification"),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 12.h, bottom: 16.h),
              child: NotificationFilterChips(
                onFilterChanged: (selectedFilter) {},
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: const [
                  NotificationTile(
                    icon: Icons.restaurant_menu_outlined,
                    iconColor: Color(0xFFE67E22),
                    iconBackgroundColor: Color(0xFFFDF2E9),
                    title: "Meal Reminder",
                    subtitle: "Don't forget your lunch",
                    time: "now",
                  ),
                  NotificationTile(
                    icon: Icons.opacity_outlined,
                    iconColor: Color(0xFF2980B9),
                    iconBackgroundColor: Color(0xFFEBF5FB),
                    title: "Hydration Reminder",
                    subtitle: "Time to drink water",
                    time: "1h ago",
                  ),
                  NotificationTile(
                    icon: Icons.auto_awesome_outlined,
                    iconColor: AppColors.primaryDark,
                    iconBackgroundColor: AppColors.primaryLight,
                    title: "AI Insight",
                    subtitle:
                        "Your recovery is low today. AI adjusted your plan.",
                    time: "2h ago",
                  ),
                  NotificationTile(
                    icon: Icons.fitness_center_outlined,
                    iconColor: Color(0xFFE74C3C),
                    iconBackgroundColor: Color(0xFFFDEDEC),
                    title: "Workout Reminder",
                    subtitle: "Time for your workout",
                    time: "3h ago",
                  ),
                  NotificationTile(
                    icon: Icons.calendar_today_outlined,
                    iconColor: Color(0xFF9B59B6),
                    iconBackgroundColor: Color(0xFFF5EEF8),
                    title: "Plan Updated",
                    subtitle:
                        "Your meal plan has been updated for better results.",
                    time: "1d ago",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
