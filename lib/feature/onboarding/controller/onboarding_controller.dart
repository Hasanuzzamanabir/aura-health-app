import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aurahealth/feature/onboarding/screen/plan_ready_screen.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentStep = 0.obs;

  // Step 1: Tell us about yourself
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  var selectedGender = "".obs; // "Male", "Female", or empty

  // Step 2: Choose goals
  var selectedGoal = "".obs;
  final List<Map<String, String>> goalsOptions = [
    {"title": "Lose Weight", "desc": "Burn fat and get leaner"},
    {"title": "Gain Muscle", "desc": "Build strength and size"},
    {"title": "Improve Wellness", "desc": "Better sleep and recovery"},
  ];

  // Step 3: Activity level
  var selectedActivity = "".obs;
  final List<Map<String, String>> activityOptions = [
    {"title": "Sedentary", "desc": "Little or no exercise, desk job"},
    {"title": "Lightly Active", "desc": "Light exercise 1-3 days/week"},
    {"title": "Moderately Active", "desc": "Moderate exercise 3-5 days/week"},
    {"title": "Very Active", "desc": "Hard exercise 6-7 days/week"},
  ];

  // Step 3: Food Preferences
  var dietType = "".obs; // "Vegetarian" or "Non-Vegetarian" or ""
  var selectedAllergies = <String>[].obs;
  final List<String> allergiesOptions = [
    "Nuts",
    "Dairy",
    "Gluten",
    "Shellfish",
    "Soy",
  ];

  // Step 4: Connect your devices
  var connectedDevices = <String, bool>{
    "Apple Health": true,
    "Apple Watch": true,
    "Fitbit": false,
    "Garmin": false,
    "WHOOP": false,
    "Oura": false,
    "Google Fit": false,
  }.obs;

  // Step 5: Lifestyle
  var workoutFrequency = 0.4.obs;
  var averageSleep = 0.5.obs;
  var stressLevel = 0.4.obs;

  // Step 6: AI Generation
  var aiProgress = 0.obs;
  var aiStatusText = "Initializing analysis...".obs;

  @override
  void onClose() {
    pageController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.onClose();
  }

  // Set gender
  void setGender(String gender) {
    selectedGender.value = gender;
  }

  // Set goal selection
  void selectGoal(String goal) {
    selectedGoal.value = goal;
  }

  // Set activity level
  void setActivity(String activity) {
    selectedActivity.value = activity;
  }

  // Set Diet Type
  void setDietType(String type) {
    dietType.value = type;
  }

  // Toggle Allergy
  void toggleAllergy(String allergy) {
    if (selectedAllergies.contains(allergy)) {
      selectedAllergies.remove(allergy);
    } else {
      selectedAllergies.add(allergy);
    }
  }

  // Set Workout Frequency
  void setWorkoutFrequency(double value) {
    workoutFrequency.value = value;
  }

  // Set Average Sleep
  void setAverageSleep(double value) {
    averageSleep.value = value;
  }

  // Set Stress Level
  void setStressLevel(double value) {
    stressLevel.value = value;
  }

  // Toggle Connected Device switch
  void toggleDevice(String device) {
    connectedDevices[device] = !(connectedDevices[device] ?? false);
  }

  // Navigation: Go to next step
  void nextStep() {
    if (!validateCurrentStep()) return;

    if (currentStep.value < 5) {
      currentStep.value++;
      pageController.animateToPage(
        currentStep.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      // Start AI plan generation on Step 6 (index 5)
      if (currentStep.value == 5) {
        startAiPlanGeneration();
      }
    }
  }

  // Navigation: Go to previous step
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      pageController.animateToPage(
        currentStep.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.back();
    }
  }

  // Validate the current step
  bool validateCurrentStep() {
    if (currentStep.value == 0) {
      if (ageController.text.trim().isEmpty) {
        Get.snackbar(
          "Required",
          "Please enter your age",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
      if (weightController.text.trim().isEmpty) {
        Get.snackbar(
          "Required",
          "Please enter your weight",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
      if (heightController.text.trim().isEmpty) {
        Get.snackbar(
          "Required",
          "Please enter your height",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
      if (selectedGender.value.isEmpty) {
        Get.snackbar(
          "Required",
          "Please select your gender",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
    } else if (currentStep.value == 1) {
      if (selectedGoal.value.isEmpty) {
        Get.snackbar(
          "Required",
          "Please select your main goal",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
    } else if (currentStep.value == 2) {
      if (dietType.value.isEmpty) {
        Get.snackbar(
          "Required",
          "Please select your diet type",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
    } else if (currentStep.value == 3) {
      // Connect devices is optional, so we just proceed without validation
      return true;
    } else if (currentStep.value == 4) {
      // Sliders always have a default valid value
      return true;
    }
    return true;
  }

  // Simulate AI Plan Generation
  void startAiPlanGeneration() async {
    aiProgress.value = 0;
    aiStatusText.value = "Initializing AI analysis...";

    List<Map<String, dynamic>> stages = [
      {"progress": 20, "text": "Analyzing physical dimensions & BMI..."},
      {
        "progress": 45,
        "text": "Calculating personalized macro/calorie targets...",
      },
      {
        "progress": 70,
        "text": "Structuring active schedule based on activity level...",
      },
      {"progress": 90, "text": "Assembling dynamic meal plan preferences..."},
      {
        "progress": 100,
        "text": "Configuring your custom AI health dashboard...",
      },
    ];

    for (var stage in stages) {
      await Future.delayed(const Duration(milliseconds: 700));
      aiProgress.value = stage["progress"] as int;
      aiStatusText.value = stage["text"] as String;
    }

    await Future.delayed(const Duration(milliseconds: 500));
    // Navigate to Plan Ready Screen instead of direct dashboard
    Get.offNamed(PlanReadyScreen.planReadyScreen);
  }

  // Mifflin-St Jeor Dynamic Calorie Calculations
  int get dailyCaloriesTarget {
    final double w = double.tryParse(weightController.text) ?? 70.0;
    final double h = double.tryParse(heightController.text) ?? 170.0;
    final double a = double.tryParse(ageController.text) ?? 25.0;
    final isMale = selectedGender.value == "Male";

    double bmr = 10 * w + 6.25 * h - 5 * a + (isMale ? 5 : -161);
    double tdee = bmr * 1.375; // assume moderately active

    if (selectedGoal.value == "Lose Weight") {
      tdee -= 350;
    } else if (selectedGoal.value == "Gain Muscle") {
      tdee += 400;
    }
    
    return tdee < 1200 ? 1200 : tdee.round();
  }

  int get dailyCaloriesMaintenanceGoal {
    final double w = double.tryParse(weightController.text) ?? 70.0;
    final double h = double.tryParse(heightController.text) ?? 170.0;
    final double a = double.tryParse(ageController.text) ?? 25.0;
    final isMale = selectedGender.value == "Male";

    double bmr = 10 * w + 6.25 * h - 5 * a + (isMale ? 5 : -161);
    double tdee = bmr * 1.375; // maintenance calories

    return tdee.round();
  }

  int get targetProtein {
    final double w = double.tryParse(weightController.text) ?? 70.0;
    return (w * 1.8).round(); // 1.8g per kg body weight
  }

  int get targetFat {
    final int cal = dailyCaloriesTarget;
    // 25% of calories from fat, 9 calories per gram of fat
    return ((cal * 0.25) / 9).round();
  }

  int get targetCarbs {
    final int cal = dailyCaloriesTarget;
    final int pCal = targetProtein * 4;
    final int fCal = targetFat * 9;
    // Remaining calories from carbs, 4 calories per gram of carb
    int cCal = cal - pCal - fCal;
    if (cCal < 0) cCal = 0;
    return (cCal / 4).round();
  }
}
