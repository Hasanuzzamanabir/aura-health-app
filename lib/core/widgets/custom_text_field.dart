import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
        ],
        Container(
          margin: EdgeInsets.only(bottom: 20.h),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: AppColors.border.withOpacity(0.5), width: 1.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: AppColors.borderFocused, width: 1.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}