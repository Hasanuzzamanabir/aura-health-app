import 'dart:developer';

import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/feature/auth/change_password/screen/change_password.dart';
import 'package:aurahealth/feature/auth/otp_screen/controller/otp_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  static const String otpScreen = '/otpScreen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = PinInputController();
  final controller = Get.put(OtpController());

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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        Text(
                          "Enter OTP",
                          style: AppStyle.interMedium500(context).copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            "4 digit code has been sent to your email ${widget.email}",
                            textAlign: TextAlign.center,
                            style: AppStyle.interMedium500(context).copyWith(
                              color: AppColors.labelTextColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              height: 1.4,
                            ),
                          ),
                        ),

                        SizedBox(height: 36.h),

                        PinInput(
                          length: 4,
                          pinController: pinController,
                          builder: (context, cells) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: cells.map((cell) {
                                return Container(
                                  width: 60.w,
                                  height: 60.h,
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                      width: 1.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      cell.character ?? '',
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                          onChanged: (pin) {
                            controller.otpCode.value = pin;
                          },
                          onCompleted: (pin) => log('PIN: $pin'),
                        ),

                        SizedBox(height: 20.h),

                        Obx(
                          () => Text.rich(
                            TextSpan(
                              text: "Code expire in : ",
                              style: AppStyle.interMedium500(context).copyWith(
                                color: const Color(0xFF2C2C2C),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              children: [
                                TextSpan(
                                  text: controller.timer,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 36.h),

                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.otpCode.value.length < 4
                                  ? null
                                  : () {
                                      Get.toNamed(
                                        ChangePassword.changePassword,
                                      );
                                      log(
                                        'Verify pressed. OTP: ${controller.otpCode.value}',
                                      );
                                    },
                              child: Text(
                                "Verify",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        Text.rich(
                          TextSpan(
                            text: "Didn't receive code? ",
                            style: AppStyle.interMedium500(context).copyWith(
                              color: const Color(0xFF2C2C2C),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            children: [
                              TextSpan(
                                text: "Resend",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: AppColors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    controller.startTimer();
                                    log('Resend OTP clicked');
                                  },
                              ),
                            ],
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
