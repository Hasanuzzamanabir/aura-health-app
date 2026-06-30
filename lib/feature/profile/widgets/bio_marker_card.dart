import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';

class BiomarkerCard extends StatelessWidget {
  final String name;
  final String value;
  final String unit;
  final String status; // LOW, OPTIMAL, HIGH
  final double sliderValue; // 0.0 to 1.0
  final String minRange;
  final String maxRange;
  final bool? isUpArrow; // true = ↑, false = ↓, null = none
  final Color statusColor;
  final double optimalStart;
  final double optimalEnd;

  const BiomarkerCard({
    super.key,
    required this.name,
    required this.value,
    required this.unit,
    required this.status,
    required this.sliderValue,
    required this.minRange,
    required this.maxRange,
    this.isUpArrow,
    required this.statusColor,
    this.optimalStart = 0.3,
    this.optimalEnd = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    // Determine status colors based on status value (case insensitive)
    final normalizedStatus = status.toUpperCase();
    final bool isOptimal = normalizedStatus == "OPTIMAL";
    
    // Status pill background and text colors
    final Color pillBgColor = isOptimal
        ? const Color(0xFFDCFCE7) // soft green (Tailwind green-100)
        : const Color(0xFFFEE2E2); // soft red/pink (Tailwind red-100)
        
    final Color pillTextColor = isOptimal
        ? const Color(0xFF10B981) // emerald-500
        : const Color(0xFFEF4444); // red-500

    // Slider track background color (low/high segments)
    final Color trackBgColor = isOptimal
        ? const Color(0xFFF3F4F6) // light grey for optimal status
        : const Color(0xFFFEE2E2); // soft pink/red for low/high status

    const Color optimalSegmentColor = Color(0xFF81C784); // pastel green for optimal range

    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Arrow
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isUpArrow != null) ...[
                      SizedBox(width: 4.w),
                      Text(
                        isUpArrow! ? "↑" : "↓",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: pillTextColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Value, Unit, and Status pill
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        unit,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: pillBgColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: pillTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Custom multi-segment slider track
          Stack(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: Size(double.infinity, 6.h),
                painter: BiomarkerSliderPainter(
                  optimalStart: optimalStart,
                  optimalEnd: optimalEnd,
                  trackColor: trackBgColor,
                  optimalColor: optimalSegmentColor,
                ),
              ),
              Align(
                alignment: Alignment(sliderValue * 2 - 1, 0),
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: pillTextColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          
          // Slider range labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                minRange,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                maxRange,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BiomarkerSliderPainter extends CustomPainter {
  final double optimalStart;
  final double optimalEnd;
  final Color trackColor;
  final Color optimalColor;

  BiomarkerSliderPainter({
    required this.optimalStart,
    required this.optimalEnd,
    required this.trackColor,
    required this.optimalColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final double width = size.width;
    final double height = size.height;
    final double radius = height / 2;

    canvas.save();
    final RRect trackRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      Radius.circular(radius),
    );
    canvas.clipRRect(trackRRect);

    // Draw background track
    paint.color = trackColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    // Draw optimal segment
    paint.color = optimalColor;
    canvas.drawRect(
      Rect.fromLTRB(optimalStart * width, 0, optimalEnd * width, height),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BiomarkerSliderPainter oldDelegate) {
    return oldDelegate.optimalStart != optimalStart ||
        oldDelegate.optimalEnd != optimalEnd ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.optimalColor != optimalColor;
  }
}
