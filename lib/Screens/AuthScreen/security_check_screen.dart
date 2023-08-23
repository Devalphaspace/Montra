import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/constants.dart';

class SecurityCheckScreen extends StatefulWidget {
  const SecurityCheckScreen({super.key});

  @override
  State<SecurityCheckScreen> createState() => _SecurityCheckScreenState();
}

class _SecurityCheckScreenState extends State<SecurityCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: violet,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Let’s  setup your Account',
                style: title3.copyWith(color: light80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
