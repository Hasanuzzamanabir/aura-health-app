import 'package:aurahealth/feature/auth/forgot_password/screen/forgot_password.dart';
import 'package:aurahealth/feature/auth/signup/screen/signup_screen.dart';
import 'package:aurahealth/feature/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/utils/image_path.dart';
import 'package:aurahealth/core/widget/google_login_container.dart';
import 'package:aurahealth/core/widget/text_field_widget.dart';
import 'package:aurahealth/feature/auth/login/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String loginScreen = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 22.h),
                        Image.asset(ImagePath.appLogo),
                        SizedBox(height: 16.h),
                        Text(
                          "Sign in to your account",
                          style: AppStyle.poppinsSemiBold600(context),
                        ),

                        SizedBox(height: 26.h),

                        TextFieldWidget(
                          text: "Email",
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Enter your email',
                            ),
                          ),
                        ),

                        Obx(
                          () => TextFieldWidget(
                            text: "Password",
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'Enter your Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.passwordVisibility.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () {
                                    controller.togglePasswordVisibility();
                                  },
                                ),
                              ),
                              obscureText: controller.passwordVisibility.value,
                              obscuringCharacter: "*",
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  controller.toggleRememberMe();
                                },
                                borderRadius: BorderRadius.circular(4.r),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IgnorePointer(
                                        child: SizedBox(
                                          width: 20.w,
                                          height: 20.h,
                                          child: Checkbox(
                                            value:
                                                controller.isRememberMe.value,
                                            activeColor: AppColors.primary,
                                            checkColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            side: BorderSide(
                                              color: AppColors.primary,
                                              width: 1.5.w,
                                            ),
                                            onChanged: (value) {
                                              controller.toggleRememberMe();
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Remember me",
                                        style: AppStyle.interMedium500(context)
                                            .copyWith(
                                              fontSize: 12.sp,
                                              color: AppColors.forgotColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.offNamed(ForgotPassword.forgotPassword);
                              },
                              borderRadius: BorderRadius.circular(4.r),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: Text(
                                  "Forgot password?",
                                  style: AppStyle.interMedium500(context)
                                      .copyWith(
                                        fontSize: 12.sp,
                                        color: AppColors.forgotColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 26.h),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.offNamed(
                                BottomNavBarScreen.bottomNavBarScreen,
                              );
                            },
                            child: Text("Sing In"),
                          ),
                        ),

                        SizedBox(height: 26.h),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: const Color(0xFFCFD8DC),
                                thickness: 1.5,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Text(
                                "Or Connect with",
                                style: AppStyle.interMedium500(context)
                                    .copyWith(
                                      fontSize: 14.sp,
                                      color: AppColors.textSecondary,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: const Color(0xFFCFD8DC),
                                thickness: 1.5,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoogleLoginContainer(
                              imagePath: ImagePath.googleIcon,
                              onTap: () {},
                            ),
                            SizedBox(width: 16.w),
                            GoogleLoginContainer(
                              imagePath: ImagePath.appleIcon,
                              onTap: () {},
                            ),
                          ],
                        ),

                        const Spacer(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? "),
                            InkWell(
                              onTap: () {
                                Get.toNamed(SignupScreen.signupScreen);
                              },
                              child: Text(
                                "Sign Up",
                                style: AppStyle.interMedium500(
                                  context,
                                ).copyWith(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
