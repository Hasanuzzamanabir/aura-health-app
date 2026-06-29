import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary),
        onPressed: onBackPressed ?? () => Navigator.maybePop(context),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}