import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra/Constants/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: violet,
      body: SafeArea(
        child: Container(
          color: violet,
          height: Get.height,
          width: Get.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: Get.width / 2,
                child: Container(
                  height: 74,
                  width: 74,
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(37),
                    backgroundBlendMode: BlendMode.overlay,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: Container(
                  height: 74,
                  width: 74,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(37),
                    // backgroundBlendMode: BlendMode.overlay,
                  ),
                ),
              ),
              Text(
                'Montra',
                style: GoogleFonts.inter(
                  fontSize: 56,
                  color: light,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
