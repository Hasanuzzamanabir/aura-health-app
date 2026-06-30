import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTileData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  ProfileTileData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class ProfileGroupCard extends StatelessWidget {
  final List<ProfileTileData> items;

  const ProfileGroupCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: AppColors.border.withValues(alpha: 0.5),
          width: 1.w,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.border.withValues(alpha: 0.4),
          height: 1.h,
          indent: 50.w,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            dense: true,
            leading: Icon(
              item.icon,
              color: AppColors.textSecondary,
              size: 22.sp,
            ),
            title: Text(
              item.title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 14.sp,
            ),
            onTap: item.onTap,
          );
        },
      ),
    );
  }
}

class SettingsSingleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsSingleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: AppColors.border.withValues(alpha: 0.5),
            width: 1.w,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          //backgroundColor: AppColors.background,
          leading: Icon(icon, color: AppColors.textSecondary, size: 22.sp),
          title: Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.textSecondary,
            size: 14.sp,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
