import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aurahealth/feature/home/model/home_model.dart';

class HomeController extends GetxController {
  final Rxn<HomeModel> homeData = Rxn<HomeModel>();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  void loadHomeData() {
    isLoading.value = true;

    // Simulate loading data matching the design in the mock image
    homeData.value = HomeModel(
      userName: "Thomas",
      subGreeting: "Here's your health overview",
      hasNotification: true,
      weightTrend: const WeightTrend(
        title: "Trends since Monday",
        startValue: "92.1",
        startUnit: "kg",
        startLabel: "MON",
        endValue: "87.3",
        endUnit: "kg",
        endLabel: "TODAY",
        changeText: "- 4.8 kg",
        changeColor: Color(0xFF4285F4),
        chartData: [92.1, 90.5, 89.2, 88.5, 88.0, 87.6, 87.3],
        chartLabels: ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"],
      ),
      sleepDurationTrend: const SleepDurationTrend(
        title: "Sleep Duration",
        value: "2h 58m",
        subtitle: "Yesterday",
        chartData: [4.5, 3.5, 6.2, 4.5, 2.8, 2.4, 1.8],
        chartLabels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
      ),
      todayMeal: const TodayMeal(
        mealType: "Lunch",
        mealName: "Quinoa Chicken Bowl",
        ingredients: "Quinoa, avocado, steamed broccoli",
        calories: "520",
        unit: "kcal",
        imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=200&q=80',
      ),
      todayPlanProgress: "1,842 / 2,200 kcal",
      biomarkers: const [
        BiomarkerHomeModel(
          name: "Vitamin D",
          value: "42",
          unit: "ng/mL",
          status: "Optimal",
          statusColor: Color(0xFF00B366),
        ),
        BiomarkerHomeModel(
          name: "Ferritin",
          value: "28",
          unit: "ng/mL",
          status: "Optimal",
          statusColor: Color(0xFF00B366),
        ),
        BiomarkerHomeModel(
          name: "Omega-3 Index",
          value: "8.2",
          unit: "%",
          status: "Good",
          statusColor: Color(0xFF00B366),
        ),
      ],
      weight: const HealthMetric(
        title: "Weight",
        value: "87.3",
        unit: "Kg",
        subtitle: "-4.8 Kg",
        subtitleColor: Color(0xFF4285F4), // Health Blue
        chartData: [
          87.5,
          87.1,
          87.4,
          87.6,
          87.5,
          87.3,
          87.4,
          87.5,
          87.4,
          87.2,
          87.3,
        ],
      ),
      sleep: const HealthMetric(
        title: "Sleep",
        value: "2h 58m",
        unit: "",
        subtitle: "Poor",
        subtitleColor: Color(0xFFD32F2F), // Red/Poor status
        // Normalized heights for sleep stages bars
        chartData: [
          0.35,
          0.5,
          0.4,
          0.75,
          0.25,
          0.3,
          0.45,
          0.25,
          0.55,
          0.6,
          0.35,
          0.5,
          0.7,
          0.4,
          0.3,
          0.55,
          0.75,
        ],
      ),
      readiness: const HealthMetric(
        title: "Readiness",
        value: "63",
        unit: "%",
        subtitle: "Fair",
        subtitleColor: Color(0xFFF28500), // Orange status
        progress: 0.63,
      ),
      healthScore: const HealthMetric(
        title: "Health Score",
        value: "67",
        unit: "/100",
        subtitle: "Need attention",
        subtitleColor: Color(0xFFF28500), // Orange status
        chartData: [
          65.0,
          65.2,
          66.0,
          65.5,
          66.2,
          65.8,
          66.0,
          66.5,
          66.1,
          65.9,
          66.3,
          65.8,
          66.0,
        ],
      ),
      calories: const HealthMetric(
        title: "Calories",
        value: "1,842",
        unit: "kcal",
        subtitle: "Goal 2,200",
        chartData: [1850.0, 1846.0, 1849.0, 1845.0, 1841.0, 1845.0, 1842.0],
      ),
      steps: const HealthMetric(
        title: "Steps",
        value: "8,456",
        unit: "",
        subtitle: "Goal 10,000",
        chartData: [0.35, 0.5, 0.75, 0.3, 0.45, 0.65, 0.8, 0.35, 0.55, 0.7, 0.45, 0.6, 0.8],
      ),
      activeMinutes: const HealthMetric(
        title: "Active Minutes",
        value: "58",
        unit: "min",
        subtitle: "Goal 60",
        progress: 58 / 60,
      ),
      heartRate: const HealthMetric(
        title: "Heart Rate",
        value: "54",
        unit: "bpm",
        subtitle: "Resting",
        chartData: [55.5, 55.0, 54.8, 54.2, 54.6, 54.1, 54.0],
      ),
      hrv: const HealthMetric(
        title: "HRV",
        value: "84",
        unit: "ms",
        subtitle: "Balanced",
        chartData: [82.5, 83.2, 82.8, 83.5, 84.1, 83.6, 84.0],
      ),
      stress: const HealthMetric(
        title: "Stress",
        value: "28",
        unit: "",
        subtitle: "Low",
        chartData: [0.65, 0.45, 0.8, 0.55, 0.75, 0.35, 0.2],
      ),
    );

    isLoading.value = false;
  }

  void toggleNotification() {
    if (homeData.value != null) {
      homeData.value = HomeModel(
        userName: homeData.value!.userName,
        subGreeting: homeData.value!.subGreeting,
        hasNotification: !homeData.value!.hasNotification,
        weightTrend: homeData.value!.weightTrend,
        sleepDurationTrend: homeData.value!.sleepDurationTrend,
        todayMeal: homeData.value!.todayMeal,
        todayPlanProgress: homeData.value!.todayPlanProgress,
        biomarkers: homeData.value!.biomarkers,
        weight: homeData.value!.weight,
        sleep: homeData.value!.sleep,
        readiness: homeData.value!.readiness,
        healthScore: homeData.value!.healthScore,
        calories: homeData.value!.calories,
        steps: homeData.value!.steps,
        activeMinutes: homeData.value!.activeMinutes,
        heartRate: homeData.value!.heartRate,
        hrv: homeData.value!.hrv,
        stress: homeData.value!.stress,
      );
    }
  }
}
