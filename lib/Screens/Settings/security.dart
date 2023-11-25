import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Constants/constants.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  List<String> supportedThemes = [
    'PIN',
    'Fingerprint',
    'Face ID',
  ];

  String selectedTheme = 'PIN';

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
          'Security',
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
              itemCount: supportedThemes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      supportedThemes[index] == 'PIN'
                          ? selectedTheme = supportedThemes[index]
                          : Fluttertoast.showToast(
                              msg:
                                  'This option is not supported till now! We\'re implementating :)');
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
                          supportedThemes[index],
                          style: body3.copyWith(
                            color: dark,
                          ),
                        ),
                        if (selectedTheme == supportedThemes[index])
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
