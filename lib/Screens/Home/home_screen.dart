import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light80,
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            'Welcome to the Home Screen',
            style: title3.copyWith(
              color: dark,
            ),
          ),
        ),
      ),
    );
  }
}
