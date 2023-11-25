import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Constants/constants.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> supportedLanguages = [
    'English (EN)',
    'Hindi (HI)',
    'Bengali (BN)',
    'Indonesian (ID)',
    'Arabic (AR)',
    'Chinese (ZH)',
    'Dutch (NL)',
    'French (FR)',
    'German (DE)',
    'Italian (IT)',
    'Korean (KO)',
    'Portuguese (PT)',
    'Russian (RU)',
    'Spanish (ES)',
  ];

  String selectedLanguage = 'English (EN)';

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
          'Language',
          style: title3.copyWith(
            color: dark50,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: supportedLanguages.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      supportedLanguages[index] == 'English (EN)'
                          ? selectedLanguage = supportedLanguages[index]
                          : Fluttertoast.showToast(
                              msg:
                                  'This Language is not supported till now! We\'re implementating');
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          supportedLanguages[index],
                          style: body3.copyWith(
                            color: dark,
                          ),
                        ),
                        if (selectedLanguage == supportedLanguages[index])
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF5233FF),
                          )
                      ],
                    ),
                  ),
                );
              },
              // separatorBuilder: (context, index) =>
              //     SizedBox(height: Get.height * 0.02),
            ),
          ),
        ),
      ),
    );
  }
}
