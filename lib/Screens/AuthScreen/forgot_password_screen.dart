import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Screens/AuthScreen/email_confirmation_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        backgroundColor: light,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            setState(() {
              Get.back();
            });
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            theme: SvgTheme(
              currentColor: dark50,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.1),
              Text(
                'Don’t worry. Enter your email and we’ll send you a link to reset your password.',
                style: title2.copyWith(color: dark),
              ),
              const SizedBox(height: 36),
              PrimaryTextFormField(
                textEditingController: forgotPasswordController,
                fieldName: 'Email',
                isObscure: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.isEmail) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 36),
              PrimaryElevatedButton(
                onPressed: () {
                  setState(() {
                    Get.to(
                      () => const EmailConfirmationScreen(),
                    );
                  });
                },
                buttonName: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
