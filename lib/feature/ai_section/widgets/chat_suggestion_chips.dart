import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class ChatSuggestionChips extends StatelessWidget {
  final List<String> suggestions;
  final Function(String) onChipTap;

  const ChatSuggestionChips({
    super.key,
    required this.suggestions,
    required this.onChipTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => onChipTap(suggestion),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(color: AppColors.border.withOpacity(0.6)),
                ),
                alignment: Alignment.center,
                child: Text(
                  suggestion,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}