import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/feature/home/model/home_model.dart';

class MetricCard extends StatelessWidget {
  final HealthMetric metric;

  const MetricCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final bool isReadiness = metric.title.toLowerCase() == 'readiness';
    final bool isSleep = metric.title.toLowerCase() == 'sleep';

    return Container(
      height: 180.h,
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
      child: isReadiness
          ? _buildReadinessLayout(context)
          : _buildStandardLayout(context, isSleep),
    );
  }

  Widget _buildReadinessLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          metric.title,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildValueWidget(),
                SizedBox(height: 12.h),
                Text(
                  metric.subtitle ?? "",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: metric.subtitleColor ?? AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            Container(
              width: 54.w,
              height: 54.h,
              margin: EdgeInsets.only(bottom: 4.h),
              child: CustomPaint(
                painter: DonutProgressPainter(
                  progress: metric.progress ?? 0.0,
                  progressColor: const Color(0xFFF28500), // Readiness orange
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStandardLayout(BuildContext context, bool isSleep) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          metric.title,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        _buildValueWidget(),
        SizedBox(height: 4.h),
        Text(
          metric.subtitle ?? "",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: metric.subtitleColor ?? AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 38.h,
          width: double.infinity,
          child: isSleep ? _buildSleepChart() : _buildLineChart(),
        ),
      ],
    );
  }

  Widget _buildValueWidget() {
    final val = metric.value;
    final titleLower = metric.title.toLowerCase();

    if (titleLower == 'sleep') {
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
                fontSize: 13.sp,
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
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        );
      }
    }

    if (titleLower == 'health score') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            val,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            metric.unit,
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

    // Weight or standard
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          val,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 30.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          metric.unit,
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

  Widget _buildSleepChart() {
    final bars = metric.chartData ?? [];
    if (bars.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(bars.length, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.5.w),
            height: (bars[index] * 32.h).clamp(4.0, 32.h),
            decoration: BoxDecoration(
              color: const Color(0xFFC5B3F9), // Sleep purple
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLineChart() {
    final data = metric.chartData ?? [];
    if (data.isEmpty) return const SizedBox.shrink();

    final isWeight = metric.title.toLowerCase() == 'weight';
    final lineColor = isWeight
        ? const Color(0xFF4285F4)
        : const Color(0xFFF28500);
    final fillColors = isWeight
        ? [const Color(0x334285F4), const Color(0x004285F4)]
        : [const Color(0x33F28500), const Color(0x00F28500)];

    return CustomPaint(
      painter: SparklinePainter(
        data: data,
        lineColor: lineColor,
        fillGradientColors: fillColors,
      ),
    );
  }
}

class SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final List<Color> fillGradientColors;

  SparklinePainter({
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
      double y = size.height - (normalizedY * (size.height - 6) + 3);
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
      ..strokeWidth = 1.8.w
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant SparklinePainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.fillGradientColors != fillGradientColors;
  }
}

class DonutProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color trackColor;

  DonutProgressPainter({
    required this.progress,
    required this.progressColor,
    this.trackColor = const Color(0xFFECECEC),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 6.5.w;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, trackPaint);

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double startAngle = -3.1415926535 / 2; // 12 o'clock
    final double sweepAngle = 2 * 3.1415926535 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant DonutProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.trackColor != trackColor;
  }
}
