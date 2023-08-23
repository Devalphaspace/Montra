import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Screens/AuthScreen/login_screen.dart';
import 'package:montra/Screens/AuthScreen/signup_screen.dart';

import '../../Constants/shared.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> carouselTitles = [
    'Gain total control of your money',
    'Know where your money goes',
    'Planning ahead',
  ];
  final List<String> carouselImages = [
    'assets/images/Ilustration.png',
    'assets/images/Illustration2.png',
    'assets/images/Ilustration3.png',
  ];
  final List<String> carouselDesc = [
    'Become your own money manager and make every cent count',
    'Track your transaction easily, with categories and financial report ',
    'Setup your budget for each category so you in control',
  ];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: Get.height * 0.65,
                child: PageView.builder(
                  itemCount: 3,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          carouselImages[index],
                          filterQuality: FilterQuality.high,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: Get.width * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                carouselTitles[index],
                                textAlign: TextAlign.center,
                                style: title1,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                carouselDesc[index],
                                textAlign: TextAlign.center,
                                style: body1.copyWith(
                                  color: light20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  3,
                  (listIndex) => listIndex == currentPage
                      ? AnimatedContainer(
                          margin: const EdgeInsets.all(8),
                          duration: const Duration(milliseconds: 300),
                          height: 16,
                          width: 16,
                          constraints: const BoxConstraints(
                            maxHeight: 16,
                            maxWidth: 16,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: violet),
                        )
                      : AnimatedContainer(
                          margin: const EdgeInsets.all(8),
                          duration: const Duration(milliseconds: 300),
                          height: 8,
                          width: 8,
                          constraints: const BoxConstraints(
                            maxHeight: 8,
                            maxWidth: 8,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: violet20),
                        ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PrimaryElevatedButton(
                    onPressed: () {
                      setState(() {
                        Get.to(
                          () => const SignUpScreen(),
                        );
                      });
                    },
                    buttonName: 'Sign Up',
                  ),
                  const SizedBox(height: 16),
                  SecondaryElevatedButton(
                    onPressed: () {
                      setState(() {
                        Get.to(
                          () => const LoginScreen(),
                        );
                      });
                    },
                    buttonName: 'Login',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
