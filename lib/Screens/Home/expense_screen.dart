import 'dart:io';
import 'dart:developer';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Services/database_services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:montra/Controller/income_expense_controller.dart';

import '../../Constants/shared.dart';
import '../../Services/image_services.dart';

class ExpenseScreen extends StatefulWidget {
  final String userID;
  const ExpenseScreen({
    super.key,
    required this.userID,
  });

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  TextEditingController numericController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool switchValue = false;
  File? image;
  IncomeExpenseController expenseController =
      Get.put(IncomeExpenseController());

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final math.Random _rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchCategories(userID: widget.userID).then((documents) {
        List<String> documentList = [];
        List<String> documentIDList = [];
        documents!.forEach((element) {
          documentList.add(element.data['categoryName']);
          documentIDList.add(element.$id.toString());
        });
        expenseController.addIncomeExpenseCategories(
            categoryList: documentList, categoryIDList: documentIDList);
      });
      fetchWallets(userID: widget.userID).then((documents) {
        List<String> documentList = [];
        List<String> documentIDList = [];
        documents!.documents.forEach((element) {
          documentList.add(element.data['walletName']);
          documentIDList.add(element.$id.toString());
        });
        expenseController.addWalletCategories(
            walletList: documentList, walletIDList: documentIDList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IncomeExpenseController>(builder: (context) {
      return GestureDetector(
        onTap: () {
          setState(() {
            FocusManager.instance.primaryFocus!.unfocus();
          });
        },
        child: Scaffold(
          backgroundColor: red,
          appBar: AppBar(
            backgroundColor: red,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(
                'assets/icons/arrow_left.svg',
                height: 20,
                width: 20,
                color: light,
              ),
            ),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Expense',
              style: title3.copyWith(
                color: light,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'How much?',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: light80,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              ),
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: light,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: light,
                          border: Border.all(
                            color: light60,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButton(
                          // Initial Value
                          value: expenseController.incomeExpenseCategoryValue,
                          underline: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          icon: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.525 -
                                    expenseController
                                        .incomeExpenseCategoryValue.length),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: light20,
                            ),
                          ),

                          items: expenseController.incomeExpenseCategoryList
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: light20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              expenseController
                                  .changeIncomeExpenseCategoryValue(
                                      categoryValue: newValue!,
                                      categoryID: expenseController
                                              .incomeExpenseCategoryIDList[
                                          expenseController
                                              .incomeExpenseCategoryList
                                              .indexWhere((element) =>
                                                  element == newValue)]);
                            });
                          },
                        ),
                      ),
                      PrimaryTextFormField(
                        textEditingController: descriptionController,
                        fieldName: 'Description',
                        isObscure: false,
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: Get.width,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: light,
                          border: Border.all(
                            color: light60,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButton(
                          // Initial Value
                          value: expenseController.walletCategoryValue,
                          underline: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          icon: Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.525),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: light20,
                            ),
                          ),

                          items: expenseController.walletCategoryList
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: light20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              expenseController.changeWalletCategoryValue(
                                  walletValue: newValue!,
                                  walletID:
                                      expenseController.walletCategoryIDList[
                                          expenseController.walletCategoryList
                                              .indexWhere((element) =>
                                                  element == newValue)]);
                            });
                          },
                        ),
                      ),
                      DashedBorderButton(
                        buttonName: 'Add Attachment',
                        onTap: () async {
                          try {
                            image = await getFromCamera();
                            log(image.toString());
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Repeat',
                                style: body1.copyWith(
                                  color: dark25,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Repeat transaction',
                                style: small.copyWith(
                                  color: light20,
                                ),
                              ),
                            ],
                          ),
                          PrimarySwitch(switchState: false)
                        ],
                      ),
                      const SizedBox(height: 36),
                      PrimaryChildWidgetElevatedButton(
                        onPressed: () {
                          expenseController.buttonLoadingStatusModifier(
                              buttonStatus: true);
                          try {
                            Map<String, dynamic> transactionData = {
                              'ID': getRandomString(36),
                              'amount': numericController.text,
                              'transactionDescription':
                                  descriptionController.text,
                              'datetime': DateTime.now().toString(),
                              'user': widget.userID,
                              'transactionType': 'Expense',
                              'wallet': expenseController.walletCategoryIDValue,
                              'category': expenseController
                                  .incomeExpenseCategoryIDValue,
                            };
                            fetchSingleWallet(
                                    walletID:
                                        expenseController.walletCategoryIDValue)
                                .then((walletDetails) {
                              try {
                                log('NUM TEXT: ${numericController.text} ----- NUM PARSE: ${int.parse(numericController.text)}');
                                double walletAmount =
                                    walletDetails!.data['walletAmount'];
                                double deductedAmount = (walletAmount -
                                    double.parse(numericController.text));
                                log('DED AMT: $deductedAmount');
                                updateWallet(
                                    walletID:
                                        expenseController.walletCategoryIDValue,
                                    walletData: {
                                      "walletAmount": deductedAmount,
                                    }).then((value) {
                                  try {
                                    createTransaction(
                                            transactionData: transactionData)
                                        .then((value) {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Transaction Created Successfully!');
                                      Get.back();
                                    });
                                  } catch (e) {
                                    log('createTransactionException: $e');
                                    updateWallet(
                                        walletID: expenseController
                                            .walletCategoryIDValue,
                                        walletData: {
                                          "walletAmount": walletAmount,
                                        });
                                    primaryFlutterToast(
                                        msg: 'Something went wrong');
                                    Get.back();
                                  }
                                });
                              } catch (e) {
                                log('updateWalletException: $e');
                                    Get.back();
                                primaryFlutterToast(
                                    msg: 'Something went wrong');
                              }
                            });
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: 'Something went wrong! Try again later');
                            log('fetchSingleWalletException: $e');
                            expenseController.buttonLoadingStatusModifier(
                                buttonStatus: false);
                          }
                        },
                        buttonWidget: expenseController.isSubmitButtonLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator.adaptive(
                                    backgroundColor: light80,
                                  ),
                                  const Spacer(),
                                  AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        'Adding Expense',
                                        textStyle:
                                            title3.copyWith(color: light80),
                                        speed:
                                            const Duration(milliseconds: 100),
                                      ),
                                      TyperAnimatedText(
                                        'Almont done',
                                        textStyle:
                                            title3.copyWith(color: light80),
                                        speed:
                                            const Duration(milliseconds: 100),
                                      ),
                                    ],
                                    totalRepeatCount: 1,
                                    pause: const Duration(milliseconds: 3000),
                                    displayFullTextOnTap: false,
                                    stopPauseOnTap: false,
                                  ),
                                  const Spacer(),
                                ],
                              )
                            : Text(
                                'Continue',
                                style: title3.copyWith(color: light80),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
