import 'package:flutter/material.dart';

class Getting {
  static String getGreeting() {
    TimeOfDay time = TimeOfDay.now();
    if (time.hour < 12) {
      return "Good Morning";
    } else if (time.hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }
}
