import 'package:aurahealth/feature/profile/widgets/ai_interprotation_widget.dart';
import 'package:aurahealth/feature/profile/widgets/bio_marker_card.dart';
import 'package:aurahealth/feature/profile/widgets/drag_drop_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/app_style.dart';


class BiomarkerScreen extends StatelessWidget {
  const BiomarkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Biomarker",
          style: AppStyle.poppinsSemiBold600(context).copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Biomarkers list
            BiomarkerCard(
              name: "Testosterone",
              value: "450",
              unit: "ng/dL",
              status: "LOW",
              sliderValue: 0.25,
              minRange: "300",
              maxRange: "1000",
              isUpArrow: false,
              statusColor: AppColors.error,
            ),
            BiomarkerCard(
              name: "Glucose (Fasting)",
              value: "88",
              unit: "mg/dL",
              status: "OPTIMAL",
              sliderValue: 0.6,
              minRange: "70",
              maxRange: "99",
              statusColor: AppColors.primary, isUpArrow:false,
            ),
            BiomarkerCard(
              name: "Cortisol (AM)",
              value: "18.5",
              unit: "mcg/dL",
              status: "HIGH",
              sliderValue: 0.9,
              minRange: "6",
              maxRange: "18.4",
              isUpArrow: true,
              statusColor: AppColors.error,
            ),
            BiomarkerCard(
              name: "Vitamin D",
              value: "42",
              unit: "ng/mL",
              status: "OPTIMAL",
              sliderValue: 0.45,
              minRange: "30",
              maxRange: "100",
              isUpArrow: true,
              statusColor: AppColors.primary,
            ),
            BiomarkerCard(
              name: "Magnesium",
              value: "1.9",
              unit: "mg/dL",
              status: "LOW",
              sliderValue: 0.3,
              minRange: "1.7",
              maxRange: "2.2",
              isUpArrow: false,
              statusColor: AppColors.error,
            ),
            
            SizedBox(height: 16.h),
            DragDropUploadWidget(onBrowsePressed: () {}),
            
            SizedBox(height: 24.h),
            const AiInterpretationWidget(
              interpretationText: "Your cortisol is elevated and testosterone is on the lower end of the range. This indicates high systemic stress and poor recovery.",
              protocols: [
                "Increased healthy fats (avocado, nuts) by 15%",
                "Added Ashwagandha to supplement stack",
                "Reduced high-intensity workout volume",
              ],
            ),
            
            SizedBox(height: 24.h),
            // Supplement Stack Section
            Text(
              "Supplement Stack",
              style: TextStyle(fontFamily: "Inter", fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.border.withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  _buildSupplementRow("Vitamin D3 + K2", "Essential for hormone production", "5000 IU / daily"),
                  const Divider(color: AppColors.border),
                  _buildSupplementRow("Magnesium Glycinate", "For sleep and recovery", "400mg / night"),
                  const Divider(color: AppColors.border),
                  _buildSupplementRow("Ashwagandha", "Cortisol modulation", "600mg / daily"),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            // Bottom Banner Image
         // Bottom Banner Image
Container(
  width: double.infinity,
  height: 160.h,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.r),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF1E3520), 
        Color(0xFF2C442E), 
      ],
    ),
    boxShadow: const [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  ),
  padding: EdgeInsets.all(16.w),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
       
          Text(
            "Fuel your recovery",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      SizedBox(height: 6.h),
      Text(
        "Healthy fats are crucial for hormone balance and testosterone synthesis.",
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.white.withOpacity(0.8),
          height: 1.3,
        ),
      ),
    ],
  ),
),
          ],
        ),
      ),
    );
  }

  Widget _buildSupplementRow(String title, String subtitle, String dosage) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              Text(subtitle, style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
            ],
          ),
          Text(dosage, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}