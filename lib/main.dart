import 'package:aurahealth/app.dart';
import 'package:flutter/material.dart';
import 'package:aurahealth/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // await TokenStorage.clearTokens();

  // Initialize AuthService
  // Get.put(AuthService());
  // Initialize CartController
  // Get.put(CartController());

  runApp(const AuraHealthApp());
}
