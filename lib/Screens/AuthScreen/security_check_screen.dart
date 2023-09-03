import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Controller/pin_controller.dart';
import 'package:montra/Screens/Home/home_screen.dart';

class SecurityCheckScreen extends StatefulWidget {
  final int isFirstLoggedIn;
  const SecurityCheckScreen({
    super.key,
    this.isFirstLoggedIn = 1,
    /* isFirstLoggedIn == 0 MEANS FIRST TIME LOGGED [NEW USER TO THIS APP] IN 
    isFirstLoggedIn == 1 MEANS USER IS ALREADY LOGGED IN JUST NEED TO PUT THE 
    SECURITY PIN isFirstLoggedIn == 2 MEANS USER IS NOT LOGGED IN BUT HE HAS 
    JUST LOGGED IN AND DID'T NEED TO PUT THE PIN */
  });

  @override
  State<SecurityCheckScreen> createState() => _SecurityCheckScreenState();
}

class _SecurityCheckScreenState extends State<SecurityCheckScreen> {
  int? firstPin;
  int? secondPin;
  int? thirdPin;
  int? fourthPin;
  String? finalPin;
  bool enteredWrongPin = false;
  PinController pinController = Get.put(PinController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: violet,
      body: GetBuilder<PinController>(builder: (context) {
        return FutureBuilder<Box<String>>(
          future: Hive.openBox<String>('securityBox'),
          builder: (context, securitySnapshot) {
            if (securitySnapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: light80,
                    strokeWidth: 5.00,
                  ),
                ),
              );
            } else if (securitySnapshot.hasError) {
              log(securitySnapshot.error.toString());
              return Container(
                height: Get.height,
                width: Get.width,
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        'assets/json/something_went_wrong.json',
                      ),
                      Text(
                        'Oops, a little hiccup in the digital dance! Give it another whirl after a short intermission.',
                        textAlign: TextAlign.center,
                        style: title3.copyWith(color: light80),
                      ),
                    ],
                  ),
                ),
              );
            } else if (securitySnapshot.hasData &&
                securitySnapshot.data != null &&
                widget.isFirstLoggedIn == 0) {
              return SafeArea(
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
                        'Craft your digital key: Let\'s conjure up\nyour security pin!',
                        textAlign: TextAlign.center,
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                  HapticFeedback.selectionClick().then((value) {
                                    log('Vibrated');
                                  });
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
                                finalPin =
                                    '$firstPin$secondPin$thirdPin$fourthPin';
                                pinController
                                    .initializeSecurityPin(
                                        enteredSecurityPin: finalPin!)
                                    .then((value) {
                                  setState(() {
                                    Get.offAll(
                                      () => const DoneScreen(
                                        routeNo: 0,
                                      ),
                                    );
                                  });
                                });
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
              );
            } else if (widget.isFirstLoggedIn == 2) {
              Get.offAll(
                () => const HomeScreen(),
              );
            }

            String? securityPin = securitySnapshot.data!.get('securityPin');
            return securityPin != null
                ? SafeArea(
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
                            'Step into security: Enter the code.',
                            style: title3.copyWith(color: light80),
                          ),
                          Container(
                            width: Get.width * 0.7,
                            height: 68,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                              top: 16,
                              right: 16,
                              left: 16,
                              bottom: 0,
                            ),
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
                          if (enteredWrongPin)
                            Text(
                              'Wrong PIN! Please try again.',
                              style: title3.copyWith(color: red80),
                            ),
                          const Spacer(),
                          GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    finalPin =
                                        '$firstPin$secondPin$thirdPin$fourthPin';
                                    Future<bool> isMatched =
                                        pinController.checkSecurityPin(
                                            enteredSecurityPin: finalPin!);
                                    isMatched.then((value) {
                                      if (value == true) {
                                        setState(() {
                                          Get.offAll(
                                            () => const HomeScreen(),
                                          );
                                        });
                                      } else {
                                        setState(() {
                                          enteredWrongPin = true;
                                          firstPin = null;
                                          secondPin = null;
                                          thirdPin = null;
                                          fourthPin = null;
                                        });
                                      }
                                    });
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
                  )
                : SafeArea(
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
                            'Craft your digital key: Let\'s conjure up\nyour security pin!',
                            textAlign: TextAlign.center,
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
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    finalPin =
                                        '$firstPin$secondPin$thirdPin$fourthPin';
                                    pinController
                                        .initializeSecurityPin(
                                            enteredSecurityPin: finalPin!)
                                        .then((value) {
                                      setState(() {
                                        Get.offAll(
                                          () => const DoneScreen(
                                            routeNo: 0,
                                          ),
                                        );
                                      });
                                    });
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
                  );
          },
        );
      }),
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
