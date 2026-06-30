import 'package:aurahealth/feature/profile/widgets/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/widget/custom_app_bar.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: "Subscription"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              SubscriptionCard(
                planName: "Basic",
                price: "0",
                description: "Perfect for getting started with basic tracking.",
                buttonText: "Get Started",
                features: const [
                  "Basic calorie tracking",
                  "Standard recipe library",
                  "Manual weight logging",
                ],
                onButtonPressed: () {},
              ),

              SizedBox(height: 32.h),

              SubscriptionCard(
                planName: "Pro",
                price: "12",
                description: "Everything you need for serious results.",
                buttonText: "Subscribe Now",
                isPopular: true,
                features: const [
                  "AI-generated meal plans",
                  "Smart device sync (Apple/Fitbit)",
                  "Automated grocery lists",
                  "Basic AI Coach access",
                ],
                onButtonPressed: () {},
              ),

              SizedBox(height: 24.h),

              SubscriptionCard(
                planName: "Premium",
                price: "29",
                description: "For those who want the ultimate experience.",
                buttonText: "Get Premium",
                features: const [
                  "Everything in Pro",
                  "24/7 Priority AI Coach chat",
                  "Food image analysis",
                  "Bloodwork integration",
                ],
                onButtonPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
