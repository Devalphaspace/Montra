import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Screens/AccountSetup/add_new_bank_account_screen.dart';

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({super.key});

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: Get.height * 0.1,
            bottom: 32,
            right: 16,
            left: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's setup your account!",
                style: GoogleFonts.inter(
                  color: dark50,
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 36),
              Text(
                "Account can be your bank, credit card or\nyour wallet.",
                style: body3,
              ),
              const Spacer(),
              PrimaryElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(_createRoute());
                  });
                },
                buttonName: "Let's go",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) =>
        const AddNewBankAccountScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {


      return FadeTransition(
        opacity: animation,
        
        child: child,
      );
    },
  );
}