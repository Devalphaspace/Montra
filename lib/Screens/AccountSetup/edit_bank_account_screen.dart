import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'dart:io';

import 'package:montra/Services/database_services.dart';

class EditBankAccountScreen extends StatefulWidget {
  final String walletType;
  final String walletName;
  final String walletBalance;
  final String walletID;
  final String userID;
  const EditBankAccountScreen({
    super.key,
    required this.walletType,
    required this.walletName,
    required this.walletBalance,
    required this.walletID,
    required this.userID,
  });

  @override
  State<EditBankAccountScreen> createState() => _EditBankAccountScreenState();
}

class _EditBankAccountScreenState extends State<EditBankAccountScreen>
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
    'Cash',
    'Bank',
    'Digital Payment',
    'UPI',
    'Credit/Debit Card',
  ];

  double popUpHeight =
      Platform.isIOS ? (Get.height * 0.35) : (Get.height * 0.45);

  late String dropDownValue;

  void _showDialog({
    required BuildContext context,
    required String walletID,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: light,
          title: Text(
            "Warning!!",
            style: title3.copyWith(color: red),
          ),
          content: Text(
            "Are you sure you want to delete this account?",
            style: body3.copyWith(color: red),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56),
                    ),
                    minimumSize: Size(Get.width * 0.3, 48),
                    maximumSize: Size(Get.width * 0.3, 48),
                  ),
                  child: Text(
                    'Yes'.toUpperCase(),
                    style: title3.copyWith(color: light),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    deleteWallet(walletID: walletID).then((value) {
                      Get.back();
                    });
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56),
                      side: BorderSide(
                        width: 1,
                        color: violet,
                      ),
                    ),
                    minimumSize: Size(Get.width * 0.3, 48),
                    maximumSize: Size(Get.width * 0.3, 48),
                  ),
                  child: Text(
                    'cancel'.toUpperCase(),
                    style: title3.copyWith(color: violet),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    nameController.text = widget.walletName;
    dropDownValue = widget.walletType;
    numericController.text = widget.walletBalance;

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

    slideAnimationController.forward();

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
            'Edit account',
            style: title3.copyWith(color: light),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                _showDialog(
                  context: context,
                  walletID: widget.walletID,
                );
              },
              icon: Icon(
                Iconsax.trash,
                color: light,
              ),
            ),
          ],
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
                  },
                ),
                AnimatedBuilder(
                  animation: opacityAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: opacityAnimation.value,
                      child: NumericTextFormField(
                        textEditingController: numericController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            primaryFlutterToast(msg: 'Please enter the Amount');
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
                  },
                ),
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
                                      });
                                    },
                                  ),
                                ),
                                SlideTransition(
                                  position: slideAnimation,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      PrimaryTextFormField(
                                        textEditingController: nameController,
                                        fieldName: dropDownValue == 'Cash'
                                            ? 'E.g. Cash'
                                            : dropDownValue == 'Bank'
                                                ? 'E.g. HDFC'
                                                : dropDownValue ==
                                                        'Digital Payment'
                                                    ? 'E.g. Paypal'
                                                    : dropDownValue == 'UPI'
                                                        ? 'E.g. PhonePe'
                                                        : dropDownValue
                                                                    .toLowerCase() ==
                                                                'Credit/Debit Card'
                                                                    .toLowerCase()
                                                            ? 'HDFC Credit Card'
                                                            : 'Name',
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
                                      // GridView.builder(
                                      //   padding: const EdgeInsets.all(0),
                                      //   itemCount: bankLogoPaths.length,
                                      //   shrinkWrap: true,
                                      //   physics:
                                      //       const NeverScrollableScrollPhysics(),
                                      //   gridDelegate:
                                      //       const SliverGridDelegateWithFixedCrossAxisCount(
                                      //     crossAxisCount: 4,
                                      //     childAspectRatio: 1.5,
                                      //     mainAxisSpacing: 8,
                                      //     crossAxisSpacing: 8,
                                      //   ),
                                      //   itemBuilder: (context, index) {
                                      //     return Container(
                                      //       height: 56,
                                      //       width: 56 * 2,
                                      //       padding: const EdgeInsets.all(4),
                                      //       decoration: BoxDecoration(
                                      //         color: light40,
                                      //         borderRadius:
                                      //             BorderRadius.circular(8),
                                      //       ),
                                      //       child: Image.asset(
                                      //         bankLogoPaths[index],
                                      //         fit: BoxFit.contain,
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
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
                                      Map<String, dynamic> walletData = {
                                        'walletName': nameController.text,
                                        'walletAmount': double.parse(
                                            numericController.text),
                                        'walletType': dropDownValue,
                                      };
                                      updateWallet(
                                        walletID: widget.walletID,
                                        walletData: walletData,
                                      ).then((value) {});
                                      Get.back();
                                    } else {
                                      primaryFlutterToast(
                                          msg: 'Please select Account Type!');
                                    }
                                  },
                                  buttonName: 'Update',
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
