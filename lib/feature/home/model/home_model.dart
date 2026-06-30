import 'package:flutter/material.dart';

class HealthMetric {
  final String title;
  final String value;
  final String unit;
  final String? subtitle;
  final Color? subtitleColor;
  final List<double>? chartData;
  final double? progress;

  const HealthMetric({
    required this.title,
    required this.value,
    required this.unit,
    this.subtitle,
    this.subtitleColor,
    this.chartData,
    this.progress,
  });
}

class WeightTrend {
  final String title;
  final String startValue;
  final String startUnit;
  final String startLabel;
  final String endValue;
  final String endUnit;
  final String endLabel;
  final String changeText;
  final Color changeColor;
  final List<double> chartData;
  final List<String> chartLabels;

  const WeightTrend({
    required this.title,
    required this.startValue,
    required this.startUnit,
    required this.startLabel,
    required this.endValue,
    required this.endUnit,
    required this.endLabel,
    required this.changeText,
    required this.changeColor,
    required this.chartData,
    required this.chartLabels,
  });
}

class SleepDurationTrend {
  final String title;
  final String value;
  final String subtitle;
  final List<double> chartData;
  final List<String> chartLabels;

  const SleepDurationTrend({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.chartData,
    required this.chartLabels,
  });
}

class TodayMeal {
  final String mealType;
  final String mealName;
  final String ingredients;
  final String calories;
  final String unit;
  final String imageUrl;

  const TodayMeal({
    required this.mealType,
    required this.mealName,
    required this.ingredients,
    required this.calories,
    required this.unit,
    required this.imageUrl,
  });
}

class BiomarkerHomeModel {
  final String name;
  final String value;
  final String unit;
  final String status;
  final Color statusColor;

  const BiomarkerHomeModel({
    required this.name,
    required this.value,
    required this.unit,
    required this.status,
    required this.statusColor,
  });
}

class HomeModel {
  final String userName;
  final String subGreeting;
  final bool hasNotification;
  final WeightTrend weightTrend;
  final SleepDurationTrend sleepDurationTrend;
  final TodayMeal todayMeal;
  final String todayPlanProgress;
  final List<BiomarkerHomeModel> biomarkers;
  final HealthMetric weight;
  final HealthMetric sleep;
  final HealthMetric readiness;
  final HealthMetric healthScore;
  final HealthMetric calories;
  final HealthMetric steps;
  final HealthMetric activeMinutes;
  final HealthMetric heartRate;
  final HealthMetric hrv;
  final HealthMetric stress;

  const HomeModel({
    required this.userName,
    required this.subGreeting,
    required this.hasNotification,
    required this.weightTrend,
    required this.sleepDurationTrend,
    required this.todayMeal,
    required this.todayPlanProgress,
    required this.biomarkers,
    required this.weight,
    required this.sleep,
    required this.readiness,
    required this.healthScore,
    required this.calories,
    required this.steps,
    required this.activeMinutes,
    required this.heartRate,
    required this.hrv,
    required this.stress,
  });
}
