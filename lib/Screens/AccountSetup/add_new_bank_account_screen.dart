import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'dart:io';

class AddNewBankAccountScreen extends StatefulWidget {
  final String userID;
  final String sessionID;
  const AddNewBankAccountScreen({
    super.key,
    required this.userID,
    required this.sessionID,
  });

  @override
  State<AddNewBankAccountScreen> createState() =>
      _AddNewBankAccountScreenState();
}

class _AddNewBankAccountScreenState extends State<AddNewBankAccountScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController opacityAnimationController;
  late AnimationController slideAnimationController;
  late Animation<double> animation;
  late Animation<double> opacityAnimation;
  late Animation<Offset> slideAnimation;
  TextEditingController nameController = TextEditingController();
  TextEditingController numericController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> dropDownItems = [
    'Account Type',
    'Bank',
    'Post Office',
    'Mutual Fund',
    'PayTm Wallet',
    'PayPal',
  ];

  final List<String> bankLogoPaths = [
    'assets/icons/axis.png',
    'assets/icons/bob.png',
    'assets/icons/canara.png',
    'assets/icons/hdfc.png',
    'assets/icons/icici.png',
    'assets/icons/idfc.png',
    'assets/icons/sbi.png',
    'assets/icons/yes.png',
  ];

  double popUpHeight = Platform.isIOS ? (Get.height * 0.3) : (Get.height * 0.4);

  String dropDownValue = 'Account Type';

  @override
  void initState() {
    // ANIMATION CONTROLLERS
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );

    opacityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1000),
    );

    slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );

    // ANIMATIONS
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: opacityAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: slideAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // ANIMATION DELAYS
    Future.delayed(const Duration(seconds: 1), () {
      animationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      opacityAnimationController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
      child: Scaffold(
        backgroundColor: violet,
        appBar: AppBar(
          backgroundColor: violet,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: light,
            ),
          ),
          title: Text(
            'Add new account',
            style: title3.copyWith(color: light),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                AnimatedBuilder(
                    animation: opacityAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: opacityAnimation.value,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Balance',
                            style: title3.copyWith(
                              color: light80,
                            ),
                          ),
                        ),
                      );
                    }),
                AnimatedBuilder(
                    animation: opacityAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: opacityAnimation.value,
                        child: NumericTextFormField(
                          textEditingController: numericController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              primaryFlutterToast(
                                  msg: 'Please enter the Amount');
                              return '';
                            }
                            return null;
                          },
                          errorTextStyle: const TextStyle(
                            fontSize: 0,
                            color: Colors.transparent,
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 16),
                AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Container(
                      height: popUpHeight * animation.value,
                      width: Get.width,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32 * animation.value),
                          topRight: Radius.circular(32 * animation.value),
                        ),
                      ),
                      padding: EdgeInsets.all(16 * animation.value),
                      child: AnimatedBuilder(
                        animation: opacityAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: opacityAnimation.value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryTextFormField(
                                  textEditingController: nameController,
                                  fieldName: 'Name',
                                  isObscure: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      primaryFlutterToast(
                                          msg: 'Please enter the Name');
                                      return '';
                                    }
                                    return null;
                                  },
                                  errorTextStyle: const TextStyle(
                                    fontSize: 0,
                                    color: Colors.transparent,
                                  ),
                                ),
                                Container(
                                  height: 56,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: light60,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: const EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                  ),
                                  alignment: Alignment.center,
                                  child: DropdownButton(
                                    value: dropDownValue,
                                    style: title3,
                                    underline: Container(
                                      height: 0,
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.55),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: light20,
                                        size: 24,
                                      ),
                                    ),
                                    items: dropDownItems.map(
                                      (String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style:
                                                body1.copyWith(color: light20),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropDownValue = value!;
                                        if (value != 'Account Type') {
                                           popUpHeight = Platform.isIOS ? (Get.height * 0.5) * animation.value : (Get.height * 0.6) * animation.value;
                                          slideAnimationController.forward();
                                        } else {
                                          popUpHeight = Platform.isIOS ? (Get.height * 0.3) * animation.value : (Get.height * 0.4) * animation.value;
                                          slideAnimationController.reverse();
                                        }
                                      });
                                    },
                                  ),
                                ),
                                if (dropDownValue != 'Account Type')
                                  SlideTransition(
                                    position: slideAnimation,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dropDownValue,
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: dark,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        GridView.builder(
                                          padding: const EdgeInsets.all(0),
                                          itemCount: bankLogoPaths.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            childAspectRatio: 1.5,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8,
                                          ),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 56,
                                              width: 56 * 2,
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: light40,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Image.asset(
                                                bankLogoPaths[index],
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 32),
                                PrimaryElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        dropDownValue.trim().toLowerCase() !=
                                            'Account Type'
                                                .trim()
                                                .toLowerCase()) {
                                      Get.offAll(() => DoneScreen(
                                            routeNo: 1,
                                            userID: widget.userID,
                                            sessionID: widget.sessionID,
                                          ));
                                    } else {
                                      primaryFlutterToast(
                                          msg: 'Please select Account Type!');
                                    }
                                  },
                                  buttonName: 'Continue',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
