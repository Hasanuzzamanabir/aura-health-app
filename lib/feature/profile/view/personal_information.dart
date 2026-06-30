import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final TextEditingController _firstNameController = TextEditingController(
    text: 'Thomas',
  );
  final TextEditingController _lastNameController = TextEditingController(
    text: 'Thomas',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'thomas@gmail.com',
  );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Personal information",
          style: AppStyle.interMedium500(
            context,
          ).copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWidget(
                  text: "First Name",
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your first name",
                    ),
                  ),
                ),
                TextFieldWidget(
                  text: "Last Name",
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your last name",
                    ),
                  ),
                ),
                TextFieldWidget(
                  text: "Email",
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                    ),
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56.h),
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: AppStyle.interMedium500(
                      context,
                    ).copyWith(fontSize: 16.sp, color: AppColors.textPrimary),
                  ),
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text("Save Change", style: TextStyle(fontSize: 16.sp)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
