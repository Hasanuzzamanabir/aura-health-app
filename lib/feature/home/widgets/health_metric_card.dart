import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/feature/home/model/home_model.dart';

class HealthMetricCard extends StatelessWidget {
  final HealthMetric metric;

  const HealthMetricCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final String title = metric.title.toLowerCase();

    // Map each metric type to its corresponding accent colors and icons
    Color accentColor = AppColors.primary;
    IconData iconData = Icons.favorite_outline;

    if (title == 'calories') {
      accentColor = const Color(0xFFF28500); // Orange
      iconData = Icons.whatshot_outlined;
    } else if (title == 'steps') {
      accentColor = const Color(0xFF4CAF50); // Green
      iconData = Icons.directions_run_outlined;
    } else if (title == 'active minutes') {
      accentColor = const Color(0xFF00B366); // Aura Green
      iconData = Icons.watch_later_outlined;
    } else if (title == 'heart rate') {
      accentColor = const Color(0xFFE53935); // Red
      iconData = Icons.favorite_outline_rounded;
    } else if (title == 'hrv') {
      accentColor = const Color(0xFF1E88E5); // Blue
      iconData = Icons.show_chart_rounded;
    } else if (title == 'stress') {
      accentColor = const Color(0xFF9C27B0); // Purple
      iconData = Icons.bar_chart_outlined;
    }

    return Container(
      height: 195.h,
      padding: EdgeInsets.all(16.w),
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
          // Icon and Title Row
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withValues(alpha: 0.05),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.3),
                    width: 1.5.w,
                  ),
                ),
                child: Icon(
                  iconData,
                  size: 16.sp,
                  color: accentColor,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  metric.title,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B), // Sleek grey title
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Value and Unit
          _buildValueAndUnit(),
          SizedBox(height: 2.h),

          // Subtitle / Goal
          Text(
            metric.subtitle ?? "",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary.withValues(alpha: 0.8),
            ),
          ),
          const Spacer(),

          // Visualization chart
          SizedBox(
            height: 38.h,
            width: double.infinity,
            child: _buildVisualization(accentColor, title),
          ),
        ],
      ),
    );
  }

  Widget _buildValueAndUnit() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          metric.value,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        if (metric.unit.isNotEmpty) ...[
          SizedBox(width: 2.w),
          Text(
            metric.unit,
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVisualization(Color color, String type) {
    if (type == 'active minutes') {
      // Horizontal linear progress bar
      final double val = double.tryParse(metric.value) ?? 0.0;
      final double progressVal = (val / 60.0).clamp(0.0, 1.0);
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: progressVal,
            minHeight: 8.h,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      );
    }

    if (type == 'steps' || type == 'stress') {
      final data = metric.chartData ?? [];
      if (data.isEmpty) return const SizedBox.shrink();

      return Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(data.length, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                    height: (data[index] * (type == 'stress' ? 26.h : 30.h)).clamp(3.0, 30.h),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                );
              }),
            ),
          ),
          if (type == 'stress') ...[
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _AxisLabel('Mon'),
                _AxisLabel('Tue'),
                _AxisLabel('Wed'),
                _AxisLabel('Thu'),
                _AxisLabel('Fri'),
                _AxisLabel('Sat'),
                _AxisLabel('Sun'),
              ],
            ),
          ],
        ],
      );
    }

    // Line sparklines for Calories, Heart Rate, HRV
    final data = metric.chartData ?? [];
    if (data.isEmpty) return const SizedBox.shrink();

    return CustomPaint(
      painter: CardSparklinePainter(
        data: data,
        lineColor: color,
        fillGradientColors: [
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.0),
        ],
      ),
    );
  }
}

class _AxisLabel extends StatelessWidget {
  final String text;
  const _AxisLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Inter",
          fontSize: 7.5.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}

class CardSparklinePainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final List<Color> fillGradientColors;

  CardSparklinePainter({
    required this.data,
    required this.lineColor,
    required this.fillGradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double minVal = data.reduce((a, b) => a < b ? a : b);
    final double maxVal = data.reduce((a, b) => a > b ? a : b);
    final double valRange = maxVal - minVal == 0 ? 1 : maxVal - minVal;

    final double dx = size.width / (data.length - 1);

    final Path path = Path();
    final Path fillPath = Path();

    List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      double x = i * dx;
      double normalizedY = (data[i] - minVal) / valRange;
      double y = size.height - (normalizedY * (size.height - 12.h) + 6.h);
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

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: fillGradientColors,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.6.w
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    canvas.drawPath(path, linePaint);

    // Draw circular nodes
    final nodeBorderPaint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.2.w
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    final nodeInnerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (var point in points) {
      canvas.drawCircle(point, 2.5.r, nodeInnerPaint);
      canvas.drawCircle(point, 2.5.r, nodeBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CardSparklinePainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.fillGradientColors != fillGradientColors;
  }
}
