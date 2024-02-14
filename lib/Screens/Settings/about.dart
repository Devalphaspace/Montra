import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      body: SafeArea(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About App',
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  color: dark75,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/Cover.png',
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "UI Designed By: ",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: dark25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Braja Omar Justico",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  color: dark25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Twitter ID: @BrajaOmar",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: dark25,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
