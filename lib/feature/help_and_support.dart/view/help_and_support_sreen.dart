import 'package:aurahealth/feature/help_and_support.dart/widget/custom_tab_switch.dart';
import 'package:aurahealth/feature/help_and_support.dart/widget/faqaccordiontile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/widget/custom_app_bar.dart';


class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  bool _isFaqSelected = true;
  final TextEditingController _emailController = TextEditingController(text: "abc@email.com");
  final TextEditingController _problemController = TextEditingController();

  final List<Map<String, String>> _faqList = [
    {
      "q": "Is this app free?",
      "a": "CoParent AI is free during our beta period. After launch, we'll offer both free and premium tiers to ensure accessibility for all families."
    },
    {
      "q": "Is it legally safe?",
      "a": "Yes, all data shared within the application is securely encrypted and compliant with baseline privacy policies."
    },
    {
      "q": "Can both parents use the same account?",
      "a": "Each parent should create their own individual account linked to a shared dynamic environment."
    },
    {
      "q": "How does the AI tone detection work?",
      "a": "The system processes structural language outputs dynamically to highlight highly reactive or non-cooperative tones."
    },
    {
      "q": "When will the app be available?",
      "a": "The current platform is undergoing immediate incremental updates and beta extensions."
    },
    {
      "q": "What if my co-parent refuses to use the app?",
      "a": "You can still track personal insights and manage documentation logs independently."
    }
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Help & Support"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Column(
            children: [
              CustomTabSwitch(
                isFaqSelected: _isFaqSelected,
                onTabChanged: (val) {
                  setState(() {
                    _isFaqSelected = val;
                  });
                },
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: _isFaqSelected ? _buildFaqTab() : _buildContactTab(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqTab() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _faqList.length,
      itemBuilder: (context, index) {
        return FaqAccordionTile(
          question: _faqList[index]["q"]!,
          answer: _faqList[index]["a"]!,
        );
      },
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Icon(Icons.mail_outline, color: AppColors.textSecondary, size: 20.sp),
                ),
                prefixIconConstraints: BoxConstraints(minWidth: 40.w),
                hintText: "Enter email address",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextFormField(
              controller: _problemController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Explain the problem",
                hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.6)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16.w),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 54.h),
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(27.r),
              ),
            ),
            child: Text(
              "Send",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}