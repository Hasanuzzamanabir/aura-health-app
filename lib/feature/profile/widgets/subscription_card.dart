import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class SubscriptionCard extends StatelessWidget {
  final String planName;
  final String price;
  final String description;
  final String buttonText;
  final bool isPopular;
  final List<String> features;
  final VoidCallback onButtonPressed;

  const SubscriptionCard({
    super.key,
    required this.planName,
    required this.price,
    required this.description,
    required this.buttonText,
    this.isPopular = false,
    required this.features,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // মূল কার্ডের বডি
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isPopular
                  ? AppColors.primary
                  : AppColors.border.withValues(alpha: 0.5),
              width: isPopular ? 2.w : 1.w,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPopular) SizedBox(height: 8.h),
              Text(
                planName,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$$price",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.h, left: 2.w),
                    child: Text(
                      "/month",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                description,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),

              // কন্ডিশনাল বাটন স্টাইলিং (Most Popular হলে সলিড গ্রিন, অন্যথায় আউটলাইনড)
              isPopular
                  ? ElevatedButton(
                      onPressed: onButtonPressed,
                      child: Text(buttonText),
                    )
                  : OutlinedButton(
                      onPressed: onButtonPressed,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
              SizedBox(height: 24.h),

              // ফিচার লিস্ট জেনারেটর
              ...features.map(
                (feature) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // "Most Popular" টপ ব্যাজ
        if (isPopular)
          Positioned(
            top: -14.h,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "Most Popular",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
