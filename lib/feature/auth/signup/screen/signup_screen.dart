import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/utils/image_path.dart';
import 'package:aurahealth/core/widget/google_login_container.dart';
import 'package:aurahealth/core/widget/text_field_widget.dart';
import 'package:aurahealth/feature/auth/login/screen/login_screen.dart';
import 'package:aurahealth/feature/auth/signup/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aurahealth/feature/onboarding/screen/onboarding_steps_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String signupScreen = '/signupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
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
                          "Signup  to your account",
                          style: AppStyle.poppinsSemiBold600(context),
                        ),

                        SizedBox(height: 26.h),

                        TextFieldWidget(
                          text: "First Name",
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter your First Name',
                            ),
                          ),
                        ),
                        TextFieldWidget(
                          text: "Last Name",
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter your email',
                            ),
                          ),
                        ),
                        TextFieldWidget(
                          text: "Email",
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter your email',
                            ),
                          ),
                        ),

                        Obx(
                          () => TextFieldWidget(
                            text: "Password",
                            child: TextField(
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
                        Obx(
                          () => TextFieldWidget(
                            text: "Confirm Password",
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Enter your Confirm Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.confirmPasswordVisibility.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () {
                                    controller
                                        .toggleConfirmPasswordVisibility();
                                  },
                                ),
                              ),
                              obscureText:
                                  controller.confirmPasswordVisibility.value,
                              obscuringCharacter: "*",
                            ),
                          ),
                        ),

                        SizedBox(height: 26.h),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed(OnboardingStepsScreen.onboardingStepsScreen),
                            child: Text("Singup"),
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
                            Text("Already have an account? "),
                            InkWell(
                              onTap: () {
                                Get.offNamed(LoginScreen.loginScreen);
                              },
                              child: Text(
                                "Login",
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
