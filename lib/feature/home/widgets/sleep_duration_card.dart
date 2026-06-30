import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/feature/home/model/home_model.dart';

class SleepDurationCard extends StatelessWidget {
  final SleepDurationTrend trend;

  const SleepDurationCard({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Ring Icon + Title
          Row(
            children: [
              Container(
                width: 18.w,
                height: 18.h,
                margin: EdgeInsets.only(right: 8.w),
                child: CustomPaint(
                  painter: RingIconPainter(
                    color: const Color(0xFF9F54FC), // Sleep Purple
                  ),
                ),
              ),
              Text(
                trend.title,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Side-by-Side: Yesterday sleep stats (Left) and Sleep bars chart (Right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Left Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSleepValue(trend.value),
                  SizedBox(height: 2.h),
                  Text(
                    trend.subtitle,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 24.w),
              // Right Column (Bar chart)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(trend.chartData.length, (index) {
                    final double heightVal = trend.chartData[index];
                    final isFriday = index == 4; // Friday is 5th day (index 4)
                    final barColor = isFriday
                        ? const Color(0xFFE1D5FF) // Lighter purple for Friday
                        : const Color(0xFF9F54FC);

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 14.w,
                          height: (heightVal * 8.h).clamp(4.0, 52.h),
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          trend.chartLabels[index],
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSleepValue(String val) {
    final regExp = RegExp(r'(\d+)h\s*(\d+)m');
    final match = regExp.firstMatch(val);
    if (match != null) {
      final hours = match.group(1) ?? "";
      final mins = match.group(2) ?? "";
      return Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            hours,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            "h",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            mins,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            "m",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      );
    }
    return Text(
      val,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 30.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class RingIconPainter extends CustomPainter {
  final Color color;

  RingIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.2.w
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw arc with a small gap (sweep from -pi/2 to 1.75 * pi)
    const double startAngle = -3.1415926535 / 2;
    const double sweepAngle = 2 * 3.1415926535 * 0.85;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 1.w),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant RingIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
