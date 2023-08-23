import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Screens/AuthScreen/reset_password_screen.dart';

class EmailConfirmationScreen extends StatefulWidget {
  const EmailConfirmationScreen({super.key});

  @override
  State<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset('assets/images/illustration4.png'),
              const SizedBox(height: 16),
              Text(
                'Your email is on the way',
                style: title2.copyWith(color: dark),
              ),
              const SizedBox(height: 16),
              Text(
                'Check your email test@test.com and follow the instructions to reset your password',
                textAlign: TextAlign.center,
                style: body1.copyWith(color: dark25),
              ),
              const Spacer(),
              PrimaryElevatedButton(
                onPressed: () {
                  setState(() {
                    Get.to(
                      () => const ResetPasswordScreen(),
                    );
                  });
                },
                buttonName: 'Back to Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
