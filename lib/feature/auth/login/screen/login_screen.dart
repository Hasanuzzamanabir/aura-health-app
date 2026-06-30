import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/utils/image_path.dart';
import 'package:aurahealth/core/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String loginScreen = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Image.asset(ImagePath.appLogo),
              SizedBox(height: 16.h),
              Text(
                "Sign in to your account",
                style: AppStyle.poppinsSemiBold600(context),
              ),

              SizedBox(height: 16.h),

              TextFieldWidget(
                text: "Email",
                child: TextField(
                  decoration: InputDecoration(labelText: 'Enter your email'),
                ),
              ),

              TextFieldWidget(
                text: "Password",
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter your Password',
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                  ),
                  obscureText: true,
                  obscuringCharacter: "*",
                ),
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
