import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange/core/utils/app_colors.dart';
import 'package:orange/core/widgets/custom_app_bar.dart';
import 'package:orange/core/widgets/custom_button.dart';
import 'package:orange/core/widgets/custom_text_field.dart';


class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: 'Personal information'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextField(
              labelText: 'First Name',
              hintText: 'Thomas',
            ),
            const CustomTextField(
              labelText: 'Last Name',
              hintText: 'Thomas',
            ),
            const CustomTextField(
              labelText: 'Email',
              hintText: 'thomas@gmail.com',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10.h),
            CustomButton(
              text: 'Cancel',
              isOutline: true,
              onTap: () {
                Navigator.maybePop(context);
              },
            ),
            SizedBox(height: 16.h),
            CustomButton(
              text: 'Save Change',
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}