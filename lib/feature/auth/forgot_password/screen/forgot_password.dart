import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static const String forgotPassword = "/forgot_password";

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 30.h),
              Text(
                "Forgot Password?",
                style: AppStyle.interMedium500(
                  context,
                ).copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                style: AppStyle.interMedium500(
                  context,
                ).copyWith(color: Color(0xff747474)),
              ),

              SizedBox(height: 22.h),

              TextFieldWidget(
                text: "Email",
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(label: Text("Enter your email")),
                ),
              ),

              SizedBox(height: 26.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Send OTP"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
