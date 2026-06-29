import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:orange/core/theme/app_theme.dart';
import 'package:orange/feature/splash_screen/splash_screen.dart';
import 'package:orange/routes/app_routes.dart';

class AuraHealthApp extends StatefulWidget {
  const AuraHealthApp({super.key});

  @override
  State<AuraHealthApp> createState() => _AuraHealthAppState();
}

class _AuraHealthAppState extends State<AuraHealthApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.splashScreen,
          getPages: AppRoutes.routes,
          theme: AppTheme.lightTheme,
        );
      },
    );
  }
}
