import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra/Screens/Settings/notification.dart';
import 'package:montra/Screens/Settings/currency.dart';
import 'package:montra/Screens/Settings/language.dart';
import 'package:montra/Screens/Settings/security.dart';
import 'package:montra/Screens/Settings/theme.dart';

import '../../Constants/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            theme: SvgTheme(
              currentColor: dark50,
            ),
          ),
        ),
        title: Text(
          'Settings',
          style: title3.copyWith(
            color: dark50,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.all(8),
            child: ListView(
              shrinkWrap: true,
              children: [
                SettingsButtons(
                  buttonName: 'Currency',
                  buttonVal: 'INR',
                  onTap: () {
                    Get.to(() => const CurrencyScreen());
                  },
                ),
                SettingsButtons(
                  buttonName: 'Language',
                  buttonVal: 'English',
                  onTap: () {
                    Get.to(() => const LanguageScreen());
                  },
                ),
                SettingsButtons(
                  buttonName: 'Theme',
                  buttonVal: 'Light',
                  onTap: () {
                    Get.to(() => const ThemeScreen());
                  },
                ),
                SettingsButtons(
                  buttonName: 'Security',
                  buttonVal: 'PIN',
                  onTap: () {
                    Get.to(() => const SecurityScreen());
                  },
                ),
                SettingsButtons(
                  buttonName: 'Notifications',
                  onTap: () {
                    Get.to(() => const NotificationScreen());
                  },
                ),
                SettingsButtons(
                  buttonName: 'About',
                  onTap: () {},
                ),
                SettingsButtons(
                  buttonName: 'Help',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsButtons extends StatelessWidget {
  final String buttonName;
  final String? buttonVal;
  final Function()? onTap;
  const SettingsButtons({
    super.key,
    required this.buttonName,
    this.buttonVal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonName,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: dark25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (buttonVal != null)
              Text(
                buttonVal!,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: light20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            Icon(
              Icons.chevron_right_rounded,
              color: light20,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
