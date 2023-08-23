import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Screens/AuthScreen/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
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
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.05),
              PrimaryTextFormField(
                textEditingController: newPasswordController,
                fieldName: 'New Password',
                isObscure: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  } else if (value.length < 6) {
                    return 'Password must be more than 6 chars';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              PrimaryTextFormField(
                textEditingController: retypePasswordController,
                fieldName: 'Retype Password',
                isObscure: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  } else if (value.length < 6) {
                    return 'Password must be more than 6 chars';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              PrimaryElevatedButton(
                onPressed: () {
                  setState(() {
                    Get.offAll(
                      () => const LoginScreen(),
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
