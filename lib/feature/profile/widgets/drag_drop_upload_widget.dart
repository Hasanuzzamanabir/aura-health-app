import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class DragDropUploadWidget extends StatelessWidget {
  final VoidCallback onBrowsePressed;

  const DragDropUploadWidget({super.key, required this.onBrowsePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.borderFocused.withOpacity(0.4),
          style: BorderStyle.solid, 
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.file_upload_outlined, size: 40.sp, color: AppColors.textSecondary),
          SizedBox(height: 12.h),
          Text(
            "Drag & drop your report\nimages here",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "or click to browse from your computer",
            style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
          ),
          SizedBox(height: 8.h),
          Text(
            "Supported formats: JPG, PNG",
            style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary.withOpacity(0.7)),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: onBrowsePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              minimumSize: Size(160.w, 40.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            ),
            child: Text("Browse Files", style: TextStyle(fontSize: 14.sp, color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}