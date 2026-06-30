import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class NotificationFilterChips extends StatefulWidget {
  final Function(String) onFilterChanged;

  const NotificationFilterChips({super.key, required this.onFilterChanged});

  @override
  State<NotificationFilterChips> createState() => _NotificationFilterChipsState();
}

class _NotificationFilterChipsState extends State<NotificationFilterChips> {
  int _selectedIndex = 0;
  final List<String> _filters = ["All", "Reminders", "Updates", "Alerts"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedIndex == index;
          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onFilterChanged(_filters[index]);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(20.r),
                  border: isSelected
                      ? null
                      : Border.all(color: AppColors.border.withOpacity(0.4)),
                ),
                alignment: Alignment.center,
                child: Text(
                  _filters[index],
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}