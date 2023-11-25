import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Constants/constants.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  List<String> supportedCurrencies = [
    'India (INR)',
    'United States (USD)',
    'Indonesia (IDR)',
    'Japan (JPY)',
    'Russia (RUB)',
    'Germany (EUR)',
    'Korea (WON)'
  ];

  String selectedCurrency = 'India (INR)';

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
          'Currency',
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
              itemCount: supportedCurrencies.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      supportedCurrencies[index] == 'India (INR)'
                          ? selectedCurrency = supportedCurrencies[index]
                          : Fluttertoast.showToast(
                              msg: 'This Currency is not supported till now!');
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
                          supportedCurrencies[index],
                          style: body3.copyWith(
                            color: dark,
                          ),
                        ),
                        if (selectedCurrency == supportedCurrencies[index])
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
