import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:orange/routes/app_routes.dart';



class aura_health extends StatefulWidget {
  const aura_health({super.key});

  @override
  State<aura_health> createState() => _aura_healthState();
}

class _aura_healthState extends State<aura_health> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   unawaited(AlarmNotificationService.instance.initialize());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'aura_health',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.bottomNavBarScreen,
         getPages: AppRoutes.routes,
         // initialBinding: ControllerBinder(),
          themeMode: ThemeMode.system,
          // theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}
