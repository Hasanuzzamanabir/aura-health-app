import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class AppStyle {
  static TextStyle poppinsSemiBold600(BuildContext context) {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    );
  }

  static TextStyle interMedium500(BuildContext context) {
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    );
  }
}
