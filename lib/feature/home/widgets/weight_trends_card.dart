import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/feature/home/model/home_model.dart';

class WeightTrendsCard extends StatelessWidget {
  final WeightTrend trend;

  const WeightTrendsCard({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 12.0;

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
          Text(
            trend.title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Mon Weight
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        trend.startValue,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        trend.startUnit,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    trend.startLabel,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              // Right side: Today Weight & Change
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        trend.endValue,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        trend.endUnit,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    trend.endLabel,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    trend.changeText,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: trend.changeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Chart
          SizedBox(
            height: 100.h,
            width: double.infinity,
            child: CustomPaint(
              painter: WeightTrendsPainter(
                data: trend.chartData,
                lineColor: trend.changeColor,
                fillGradientColors: [
                  trend.changeColor.withValues(alpha: 0.15),
                  trend.changeColor.withValues(alpha: 0.0),
                ],
                horizontalPadding: horizontalPadding.w,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Day labels aligned with data points
          Padding(
            padding: EdgeInsets.symmetric(horizontal: (horizontalPadding - 8).w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: trend.chartLabels.map((label) {
                return SizedBox(
                  width: 36.w,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class WeightTrendsPainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final List<Color> fillGradientColors;
  final double horizontalPadding;

  WeightTrendsPainter({
    required this.data,
    required this.lineColor,
    required this.fillGradientColors,
    required this.horizontalPadding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double minVal = data.reduce((a, b) => a < b ? a : b);
    final double maxVal = data.reduce((a, b) => a > b ? a : b);
    final double valRange = maxVal - minVal == 0 ? 1 : maxVal - minVal;

    final double usableWidth = size.width - (2 * horizontalPadding);
    final double dx = usableWidth / (data.length - 1);

    final Path path = Path();
    final Path fillPath = Path();

    List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      double x = horizontalPadding + (i * dx);
      double normalizedY = (data[i] - minVal) / valRange;
      // Invert Y coordinate so higher values are drawn higher up on screen
      double y = size.height - (normalizedY * (size.height - 20.h) + 10.h);
      points.add(Offset(x, y));
    }

    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(points[0].dx, size.height);
    fillPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
      fillPath.lineTo(points[i].dx, points[i].dy);
    }

    fillPath.lineTo(points.last.dx, size.height);
    fillPath.close();

    // Draw gradient fill
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: fillGradientColors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Draw lines
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.2.w
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    canvas.drawPath(path, linePaint);

    // Draw point nodes
    final nodeBorderPaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.w
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    final nodeInnerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (var point in points) {
      canvas.drawCircle(point, 4.5.r, nodeInnerPaint);
      canvas.drawCircle(point, 4.5.r, nodeBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant WeightTrendsPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.fillGradientColors != fillGradientColors ||
        oldDelegate.horizontalPadding != horizontalPadding;
  }
}
