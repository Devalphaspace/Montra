import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/constants.dart';

class SecurityCheckScreen extends StatefulWidget {
  const SecurityCheckScreen({super.key});

  @override
  State<SecurityCheckScreen> createState() => _SecurityCheckScreenState();
}

class _SecurityCheckScreenState extends State<SecurityCheckScreen> {
  int? firstPin;
  int? secondPin;
  int? thirdPin;
  int? fourthPin;
  String? finalPin;
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
              const Spacer(),
              Text(
                'Let’s  setup your Pin',
                style: title3.copyWith(color: light80),
              ),
              Container(
                width: Get.width * 0.7,
                height: 68,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(16),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(
                          color: firstPin != null
                              ? Colors.transparent
                              : Colors.white,
                          width: firstPin != null ? 0 : 3,
                        ),
                        color: firstPin != null
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(
                          color: secondPin != null
                              ? Colors.transparent
                              : Colors.white,
                          width: secondPin != null ? 0 : 3,
                        ),
                        color: secondPin != null
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(
                          color: thirdPin != null
                              ? Colors.transparent
                              : Colors.white,
                          width: thirdPin != null ? 0 : 3,
                        ),
                        color: thirdPin != null
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(
                          color: fourthPin != null
                              ? Colors.transparent
                              : Colors.white,
                          width: fourthPin != null ? 0 : 3,
                        ),
                        color: fourthPin != null
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                children: [
                  CustomSecurityPinButton(
                    pinNumber: '1',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 1;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 1;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 1;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 1;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '2',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 2;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 2;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 2;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 2;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '3',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 3;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 3;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 3;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 3;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '4',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 4;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 4;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 4;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 4;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '5',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 5;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 5;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 5;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 5;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '6',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 6;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 6;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 6;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 6;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '7',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 7;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 7;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 7;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 7;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '8',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 8;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 8;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 8;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 8;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '9',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 9;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 9;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 9;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 9;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: 'x',
                    onPressed: () {
                      if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin != null) {
                        setState(() {
                          fourthPin = null;
                          log('Fourth Pin: $fourthPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = null;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = null;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = null;
                          log('First Pin: $firstPin');
                          ;
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '0',
                    onPressed: () {
                      if (firstPin == null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          firstPin = 0;
                          log('First Pin: $firstPin');
                        });
                      } else if (firstPin != null &&
                          secondPin == null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          secondPin = 0;
                          log('Second Pin: $secondPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin == null &&
                          fourthPin == null) {
                        setState(() {
                          thirdPin = 0;
                          log('Third Pin: $thirdPin');
                        });
                      } else if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin == null) {
                        setState(() {
                          fourthPin = 0;
                          log('Fourth Pin: $fourthPin');
                        });
                      }
                    },
                  ),
                  CustomSecurityPinButton(
                    pinNumber: '->',
                    onPressed: () {
                      if (firstPin != null &&
                          secondPin != null &&
                          thirdPin != null &&
                          fourthPin != null) {
                        finalPin = '$firstPin$secondPin$thirdPin$fourthPin';
                        log('Pin Number: $finalPin');
                      } else {
                        log('Something is Null!!!');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSecurityPinButton extends StatelessWidget {
  final String pinNumber;
  final Function()? onPressed;
  const CustomSecurityPinButton({
    super.key,
    required this.pinNumber,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        pinNumber,
        style: title1.copyWith(
          fontSize: 48,
          color: light80,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
