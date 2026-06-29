import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange/core/utils/app_style.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final Widget child;

  const TextFieldWidget({super.key, required this.text, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text("\t\t\t$text", style: AppStyle.interMedium500(context)),
        SizedBox(height: 8.h),
        child,
        SizedBox(height: 14.h),
      ],
    );
  }
}
