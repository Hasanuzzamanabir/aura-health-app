import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutline;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: isOutline 
              ? Colors.transparent 
              : (backgroundColor ?? AppColors.primary),
          elevation: 0,
          side: isOutline 
              ? const BorderSide(color: AppColors.border, width: 1.5) 
              : BorderSide.none,
          shape: const StadiumBorder(),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isOutline 
                ? AppColors.textSecondary 
                : (textColor ?? AppColors.background),
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}