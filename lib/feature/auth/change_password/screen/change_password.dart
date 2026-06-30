import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/widget/text_field_widget.dart';
import 'package:aurahealth/feature/auth/change_password/controller/change_password_controller.dart';
import 'package:aurahealth/feature/success/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  static const String changePassword = "/changePassword";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final controller = Get.put(ChangePasswordController());

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50.h),
                        Text(
                          "Create new password",
                          style: AppStyle.interMedium500(context).copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Your new password must be unique from those previously used.",
                          style: AppStyle.interMedium500(context).copyWith(
                            color: AppColors.labelTextColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.normal,
                            height: 1.4,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        Obx(
                          () => TextFieldWidget(
                            text: "New Password",
                            child: TextField(
                              controller: newPasswordController,
                              obscureText:
                                  controller.newPasswordVisibility.value,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                hintText: "New Password",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.newPasswordVisibility.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () {
                                    controller.toggleNewPasswordVisibility();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        Obx(
                          () => TextFieldWidget(
                            text: "Confirm Password",
                            child: TextField(
                              controller: confirmPasswordController,
                              obscureText:
                                  controller.confirmPasswordVisibility.value,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
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
                            ),
                          ),
                        ),

                        SizedBox(height: 26.h),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (newPasswordController.text.isEmpty ||
                                  confirmPasswordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please fill all fields"),
                                  ),
                                );
                              } else if (newPasswordController.text !=
                                  confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Passwords do not match"),
                                  ),
                                );
                              } else {
                                Get.toNamed(SuccessScreen.successScreen);
                              }
                            },
                            child: const Text(
                              "Reset Password",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
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
