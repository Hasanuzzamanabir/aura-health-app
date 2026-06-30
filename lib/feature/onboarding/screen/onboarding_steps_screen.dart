import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';
import 'package:aurahealth/core/widget/text_field_widget.dart';
import 'package:aurahealth/core/widget/custom_switch.dart';
import 'package:aurahealth/feature/onboarding/controller/onboarding_controller.dart';

class OnboardingStepsScreen extends StatelessWidget {
  const OnboardingStepsScreen({super.key});

  static const String onboardingStepsScreen = '/onboardingStepsScreen';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      appBar: AppBar(
        leading: Obx(() {
          // Hide back button on the final AI loading step (Step 6 / index 5)
          if (controller.currentStep.value == 5) {
            return const SizedBox.shrink();
          }
          return IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: controller.previousStep,
          );
        }),
        title: Obx(() {
          if (controller.currentStep.value == 5) {
            return Text(
              "Generating Plan",
              style: AppStyle.interMedium500(context).copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            );
          }
          return Text(
            "Step ${controller.currentStep.value + 1} of 6",
            style: AppStyle.interMedium500(context).copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          );
        }),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _Step1TellUsAboutYourself(controller: controller),
                  _Step2ChooseGoals(controller: controller),
                  _Step3FoodPreferences(controller: controller),
                  _Step4ConnectDevices(controller: controller),
                  _Step5Lifestyle(controller: controller),
                  _Step6GeneratingPlan(controller: controller),
                ],
              ),
            ),
            // Bottom Button (Hidden on the final generation step)
            Obx(() {
              if (controller.currentStep.value == 5) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.nextStep,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Next"),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.white,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// STEP 1: Tell Us About Yourself
class _Step1TellUsAboutYourself extends StatelessWidget {
  final OnboardingController controller;

  const _Step1TellUsAboutYourself({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "Tell us about\nyourself",
            style: AppStyle.poppinsSemiBold600(
              context,
            ).copyWith(fontSize: 32.sp, height: 1.2),
          ),
          SizedBox(height: 8.h),
          Text(
            "This helps AI create your personalized plan.",
            style: AppStyle.interMedium500(context).copyWith(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 32.h),

          // Age
          TextFieldWidget(
            text: "Age",
            child: TextField(
              controller: controller.ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: ""),
            ),
          ),

          // Weight
          TextFieldWidget(
            text: "Weight",
            child: TextField(
              controller: controller.weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "",
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "kg",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Height
          TextFieldWidget(
            text: "Height",
            child: TextField(
              controller: controller.heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "",
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "cm",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Gender Custom Selector
          TextFieldWidget(
            text: "Gender",
            child: Row(
              children: [
                Expanded(
                  child: Obx(() {
                    final isSelected =
                        controller.selectedGender.value == "Male";
                    return GestureDetector(
                      onTap: () => controller.setGender("Male"),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 54.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryLight
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          "Male",
                          style: AppStyle.interMedium500(context).copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Obx(() {
                    final isSelected =
                        controller.selectedGender.value == "Female";
                    return GestureDetector(
                      onTap: () => controller.setGender("Female"),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 54.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryLight
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          "Female",
                          style: AppStyle.interMedium500(context).copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

// STEP 2: Choose Goals
class _Step2ChooseGoals extends StatelessWidget {
  final OnboardingController controller;

  const _Step2ChooseGoals({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "What's your main\ngoal?",
            style: AppStyle.poppinsSemiBold600(
              context,
            ).copyWith(fontSize: 32.sp, height: 1.2),
          ),
          SizedBox(height: 8.h),
          Text(
            "We'll tailor your nutrition and insights to this.",
            style: AppStyle.interMedium500(context).copyWith(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 24.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.goalsOptions.length,
            itemBuilder: (context, index) {
              final goal = controller.goalsOptions[index];
              final title = goal["title"]!;
              final desc = goal["desc"]!;
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Obx(() {
                  final isSelected = controller.selectedGoal.value == title;
                  return GestureDetector(
                    onTap: () => controller.selectGoal(title),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 18.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryLight
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: 1.5,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppStyle.poppinsSemiBold600(context)
                                .copyWith(
                                  fontSize: 18.sp,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            desc,
                            style: AppStyle.interMedium500(context).copyWith(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

// STEP 3: Food Preferences
class _Step3FoodPreferences extends StatelessWidget {
  final OnboardingController controller;

  const _Step3FoodPreferences({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "Food Preferences",
            style: AppStyle.poppinsSemiBold600(
              context,
            ).copyWith(fontSize: 32.sp, height: 1.2),
          ),
          SizedBox(height: 8.h),
          Text(
            "Customize your meal recommendations.",
            style: AppStyle.interMedium500(context).copyWith(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 32.h),

          // Diet Type Label
          Text(
            "Diet Type",
            style: AppStyle.interMedium500(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),

          // Diet Type Selection
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  final isSelected = controller.dietType.value == "Vegetarian";
                  return GestureDetector(
                    onTap: () => controller.setDietType("Vegetarian"),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 54.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryLight
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        "Vegetarian",
                        style: AppStyle.interMedium500(context).copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Obx(() {
                  final isSelected =
                      controller.dietType.value == "Non-Vegetarian";
                  return GestureDetector(
                    onTap: () => controller.setDietType("Non-Vegetarian"),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 54.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryLight
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        "Non-Vegetarian",
                        style: AppStyle.interMedium500(context).copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),

          SizedBox(height: 28.h),

          // Allergies Label
          Text(
            "Allergies (Optional)",
            style: AppStyle.interMedium500(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          // Allergies Tag Wrap
          Obx(() {
            return Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: controller.allergiesOptions.map((allergy) {
                final isSelected = controller.selectedAllergies.contains(
                  allergy,
                );
                return GestureDetector(
                  onTap: () => controller.toggleAllergy(allergy),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: 22.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryLight
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      allergy,
                      style: AppStyle.interMedium500(context).copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

// STEP 4: Connect your devices
class _Step4ConnectDevices extends StatelessWidget {
  final OnboardingController controller;

  const _Step4ConnectDevices({required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> devices = [
      {
        "name": "Apple Health",
        "icon": Icons.favorite_outline,
        "iconColor": Colors.redAccent,
        "bgColor": const Color(0xFFFFECEF),
      },
      {
        "name": "Apple Watch",
        "icon": Icons.watch_outlined,
        "iconColor": Colors.black87,
        "bgColor": const Color(0xFFEFEFEF),
      },
      {
        "name": "Fitbit",
        "icon": Icons.show_chart_rounded,
        "iconColor": Colors.teal,
        "bgColor": const Color(0xFFECF8F8),
      },
      {
        "name": "Garmin",
        "icon": Icons.watch_rounded,
        "iconColor": Colors.blue,
        "bgColor": const Color(0xFFECEFF8),
      },
      {
        "name": "WHOOP",
        "icon": Icons.insights_rounded,
        "iconColor": Colors.black,
        "bgColor": const Color(0xFFEAEAEA),
      },
      {
        "name": "Oura",
        "icon": Icons.circle_outlined,
        "iconColor": Colors.blueGrey,
        "bgColor": const Color(0xFFECEFF1),
      },
      {
        "name": "Google Fit",
        "icon": Icons.phone_android_rounded,
        "iconColor": Colors.blueAccent,
        "bgColor": const Color(0xFFE3F2FD),
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "Connect your\ndevices",
            style: AppStyle.poppinsSemiBold600(
              context,
            ).copyWith(fontSize: 32.sp, height: 1.2),
          ),
          SizedBox(height: 8.h),
          Text(
            "Sync your health data for better AI recommendations.",
            style: AppStyle.interMedium500(context).copyWith(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 24.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final item = devices[index];
              final name = item["name"] as String;
              final icon = item["icon"] as IconData;
              final iconColor = item["iconColor"] as Color;
              final bgColor = item["bgColor"] as Color;

              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Container(
                  height: 68.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border, width: 1.0),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: bgColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: iconColor, size: 20.sp),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Text(
                          name,
                          style: AppStyle.interMedium500(context).copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Obx(() {
                        final isToggled =
                            controller.connectedDevices[name] ?? false;
                        return CustomSwitch(
                          value: isToggled,
                          onChanged: (val) => controller.toggleDevice(name),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

// STEP 5: Lifestyle
class _Step5Lifestyle extends StatelessWidget {
  final OnboardingController controller;

  const _Step5Lifestyle({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "Lifestyle",
            style: AppStyle.poppinsSemiBold600(
              context,
            ).copyWith(fontSize: 32.sp, height: 1.2),
          ),
          SizedBox(height: 8.h),
          Text(
            "Help us understand your daily routine.",
            style: AppStyle.interMedium500(context).copyWith(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 32.h),

          // Workout Frequency Slider
          Obx(() {
            return _SliderBlock(
              title: "Workout Frequency",
              value: controller.workoutFrequency.value,
              onChanged: controller.setWorkoutFrequency,
              leftLabel: "Rarely",
              rightLabel: "Daily",
            );
          }),

          // Average Sleep Slider
          Obx(() {
            return _SliderBlock(
              title: "Average Sleep",
              value: controller.averageSleep.value,
              onChanged: controller.setAverageSleep,
              leftLabel: "< 5 hrs",
              rightLabel: "8+ hrs",
            );
          }),

          // Stress Level Slider
          Obx(() {
            return _SliderBlock(
              title: "Stress Level",
              value: controller.stressLevel.value,
              onChanged: controller.setStressLevel,
              leftLabel: "Low",
              rightLabel: "High",
            );
          }),
        ],
      ),
    );
  }
}

// Reusable Slider Block Widget helper class
class _SliderBlock extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;
  final String leftLabel;
  final String rightLabel;

  const _SliderBlock({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.leftLabel,
    required this.rightLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.interMedium500(context).copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: const Color(0xFFE0E0E0),
            thumbColor: AppColors.primary,
            trackHeight: 8.h,
            trackShape: const RoundedRectSliderTrackShape(),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
          ),
          child: Slider(value: value, onChanged: onChanged),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leftLabel,
                style: AppStyle.interMedium500(context).copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                rightLabel,
                style: AppStyle.interMedium500(context).copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 28.h),
      ],
    );
  }
}

// STEP 6: AI Generation Loading Screen
class _Step6GeneratingPlan extends StatelessWidget {
  final OnboardingController controller;

  const _Step6GeneratingPlan({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30.h),
          Text(
            "AI is analyzing\nyour health data",
            textAlign: TextAlign.center,
            style: AppStyle.poppinsSemiBold600(
              context,
            ).copyWith(fontSize: 28.sp, height: 1.2),
          ),
          SizedBox(height: 8.h),
          Text(
            "This may take a few moments.",
            textAlign: TextAlign.center,
            style: AppStyle.interMedium500(context).copyWith(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 48.h),

          // Pulsing and spinning loading animation
          const FuturisticAiLoader(),

          SizedBox(height: 48.h),

          // Checklist indicators
          SizedBox(
            width: 220.w,
            child: Obx(() {
              final progress = controller.aiProgress.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CheckItem(text: "Analyzing sleep", isDone: progress >= 20),
                  _CheckItem(
                    text: "Analyzing recovery",
                    isDone: progress >= 45,
                  ),
                  _CheckItem(
                    text: "Analyzing activity",
                    isDone: progress >= 70,
                  ),
                  _CheckItem(
                    text: "Analyzing nutrition",
                    isDone: progress >= 90,
                  ),
                ],
              );
            }),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

// Helper checklist item class
class _CheckItem extends StatelessWidget {
  final String text;
  final bool isDone;

  const _CheckItem({required this.text, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isDone ? 1.0 : 0.4,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: isDone ? AppColors.primary : Colors.grey,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              text,
              style: AppStyle.interMedium500(context).copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isDone ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// Animated circle loading widget
// ----------------------------------------------------
class FuturisticAiLoader extends StatefulWidget {
  const FuturisticAiLoader({super.key});

  @override
  State<FuturisticAiLoader> createState() => _FuturisticAiLoaderState();
}

class _FuturisticAiLoaderState extends State<FuturisticAiLoader>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // Pulse animation (expand and fade)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.8, end: 0.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotation animation for outer ring (slow spin)
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 180.w,
        height: 180.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Pulsing breathing background (light green expanding circle)
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),

            // 2. Faint stationary inner circular aura
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),

            // 3. Rotating outer ring
            RotationTransition(
              turns: _rotationController,
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 4.w),
                ),
              ),
            ),

            // 4. Center tiny ring
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
                border: Border.all(color: AppColors.primary, width: 5.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
