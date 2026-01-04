// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:safari_egypt_app/core/app_images.dart';
import 'package:safari_egypt_app/core/app_string.dart';
import 'package:safari_egypt_app/features/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  Timer? _autoAdvanceTimer;

  @override
  void initState() {
    super.initState();
    _startAutoAdvance();
  }

  @override
  void dispose() {
    _cancelAutoAdvance();
    _controller.dispose();
    super.dispose();
  }

  final List<String> images = [
    AppImages.onboarding1,
    AppImages.onboarding2,
    AppImages.onboarding3,
    AppImages.onboarding4,
  ];

  final List<String> descriptions = [
    AppStrings.onboardingTitle1,
    AppStrings.onboardingTitle2,
    AppStrings.onboardingTitle3,
    AppStrings.onboardingTitle4,
  ];

  void _startAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      if (currentIndex < images.length - 1) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        _cancelAutoAdvance();
      }
    });
  }

  void _cancelAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
  }

  void _resetAutoAdvance() {
    _cancelAutoAdvance();
    _startAutoAdvance();
  }

  Future<void> _finishOnboarding() async {
    _cancelAutoAdvance();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;
            final isLandscape = width > height;
            final imageHeight = isLandscape ? height * 0.5 : height * 0.35;
            final titleFontSize = (width / 24).clamp(14.0, 22.0);
            final buttonFontSize = (width / 28).clamp(12.0, 18.0);
            final indicatorWidthActive = (width * 0.05).clamp(16.0, 24.0);
            final indicatorWidthInactive = (width * 0.02).clamp(6.0, 12.0);

            return Column(
              children: [
                // Skip button
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.02,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: _finishOnboarding,

                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: const Color(0xFF1570EE),
                          fontSize: buttonFontSize,
                        ),
                      ),
                    ),
                  ),
                ),

                // Slider
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                      if (index == images.length - 1) {
                        _cancelAutoAdvance();
                      } else {
                        _resetAutoAdvance();
                      }
                    },
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: height * 0.6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: isLandscape ? 12 : 24),
                              Image.asset(
                                images[index],
                                height: imageHeight,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: height * 0.03),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.08,
                                ),
                                child: Text(
                                  descriptions[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Indicators + Next
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            images.length,
                            (index) => Container(
                              margin: EdgeInsets.only(right: width * 0.015),
                              width:
                                  currentIndex == index
                                      ? indicatorWidthActive
                                      : indicatorWidthInactive,
                              height: (indicatorWidthInactive).clamp(6.0, 12.0),
                              decoration: BoxDecoration(
                                color:
                                    currentIndex == index
                                        ? const Color(0xFF1570EE)
                                        : Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (currentIndex == images.length - 1) {
                          _finishOnboarding();
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                          _resetAutoAdvance();
                        }
                      },

                      child: Text(
                        currentIndex == images.length - 1 ? 'Done' : 'Next',
                        style: TextStyle(
                          color: const Color(0xFF1570EE),
                          fontSize: buttonFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
