import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:orange/core/utils/app_colors.dart';
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
          initialRoute: AppRoutes.bottomNavBarScreen,
          getPages: AppRoutes.routes,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.background,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.background,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
          ),
        );
      },
    );
  }
}
