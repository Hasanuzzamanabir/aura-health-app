import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/utils/image_path.dart';
import 'package:aurahealth/feature/auth/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String splashScreen = '/SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.1, 1.0, curve: Curves.easeOutCubic),
          ),
        );
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Get.offAllNamed(LoginScreen.loginScreen);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            // ── Background hero image ──────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: size.height,
              child: RotatedBox(
                quarterTurns: 2,
                child: Image.asset(ImagePath.splashScreen, fit: BoxFit.cover),
              ),
            ),

            // ── Bottom dark gradient ───────────────────────────────────────
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000), // transparent top half
                    Color(0x00000000), // transparent mid-section
                    Color(0x990D1A12), // deep dark-green tint lower half
                    Color(0xFF0A1610), // nearly-opaque dark bottom
                  ],
                  stops: [0.0, 0.5, 0.75, 1.0],
                ),
              ),
            ),

            // ── Content ────────────────────────────────────────────────────
            SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.08,
                  ), // Push logo down slightly
                  // Logo row
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Leaf icon in green container
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(7),
                          child: const Icon(
                            Icons.eco_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'AURA',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Text(
                          'HEALTH',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // ── Bottom text content ──────────────────────────────────
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 56),
                        child: Column(
                          children: [
                            Text(
                              'Health plans that\nevolve with your body.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.25,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'AI-powered nutrition, recovery & fitness\nplans made just for you.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
