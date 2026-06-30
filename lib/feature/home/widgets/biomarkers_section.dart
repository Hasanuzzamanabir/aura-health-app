import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/feature/home/model/home_model.dart';
import 'package:aurahealth/feature/profile/view/bio_marker_screen.dart';

class BiomarkersSection extends StatelessWidget {
  final List<BiomarkerHomeModel> biomarkers;

  const BiomarkersSection({super.key, required this.biomarkers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Blood Biomarkers",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(() => const BiomarkerScreen()),
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "All result",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.primary,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Horizontal List of Cards
        SizedBox(
          height: 125.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: biomarkers.length,
            separatorBuilder: (context, index) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final item = biomarkers[index];
              return GestureDetector(
                onTap: () => Get.to(() => const BiomarkerScreen()),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 140.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        item.name,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8E8E93),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),

                      // Value + Unit
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            item.value,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            item.unit,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // Status (Green Dot + Text)
                      Row(
                        children: [
                          Container(
                            width: 7.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: item.statusColor,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            item.status,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: item.statusColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
