import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class MealInfoRow extends StatelessWidget {
  final String time;
  final String difficulty;
  final String serving;

  const MealInfoRow({
    super.key,
    required this.time,
    required this.difficulty,
    required this.serving,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildInfoItem(Icons.access_time_rounded, time),
        SizedBox(width: 20.w),
        _buildInfoItem(Icons.local_fire_department_rounded, difficulty),
        SizedBox(width: 20.w),
        _buildInfoItem(Icons.room_service_outlined, serving),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AppColors.textSecondary),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}