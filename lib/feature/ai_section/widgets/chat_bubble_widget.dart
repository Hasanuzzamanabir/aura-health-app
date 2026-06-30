import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String text;
  final bool isMe;
  final Widget? customContent;

  const ChatBubbleWidget({
    super.key,
    required this.text,
    required this.isMe,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.auto_awesome, color: AppColors.white, size: 14.sp),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: isMe ? Radius.circular(16.r) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : Radius.circular(16.r),
                ),
                border: isMe
                    ? null
                    : Border.all(color: AppColors.border.withOpacity(0.4)),
                boxShadow: isMe
                    ? null
                    : const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14.sp,
                      color: isMe ? AppColors.white : AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                  if (customContent != null) ...[
                    SizedBox(height: 12.h),
                    customContent!,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}