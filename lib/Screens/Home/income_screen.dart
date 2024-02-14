import 'dart:io';
import 'dart:developer';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Services/image_services.dart';

import '../../Constants/shared.dart';
import '../../Controller/income_expense_controller.dart';
import '../../Services/database_services.dart';

class IncomeScreen extends StatefulWidget {
  final String userID;
  const IncomeScreen({
    super.key,
    required this.userID,
  });

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  TextEditingController numericController = TextEditingController();
  TextEditingController descController = TextEditingController();
  // String categoryvalue = 'Category';
  // String expensevalue = 'Wallet';
  bool switchValue = false;
  File? image;
  IncomeExpenseController incomeController = Get.put(IncomeExpenseController());

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
        incomeController.addIncomeExpenseCategories(
            categoryList: documentList, categoryIDList: documentIDList);
      });
      fetchWallets(userID: widget.userID).then((documents) {
        List<String> documentList = [];
        List<String> documentIDList = [];
        documents!.documents.forEach((element) {
          documentList.add(element.data['walletName']);
          documentIDList.add(element.$id.toString());
        });
        incomeController.addWalletCategories(
            walletList: documentList, walletIDList: documentIDList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: GetBuilder<IncomeExpenseController>(builder: (context) {
        return GestureDetector(
          onTap: () {
            setState(() {
              FocusManager.instance.primaryFocus!.unfocus();
            });
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: green,
            appBar: AppBar(
              backgroundColor: green,
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
                'Income',
                style: title3.copyWith(
                  color: light,
                ),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              child: Column(
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
                              value:
                                  incomeController.incomeExpenseCategoryValue,
                              underline: const SizedBox(
                                height: 0,
                                width: 0,
                              ),
                              icon: Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.525 -
                                        incomeController
                                            .incomeExpenseCategoryValue.length),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: light20,
                                ),
                              ),

                              items: incomeController.incomeExpenseCategoryList
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
                                  incomeController
                                      .changeIncomeExpenseCategoryValue(
                                          categoryValue: newValue!,
                                          categoryID: incomeController
                                                  .incomeExpenseCategoryIDList[
                                              incomeController
                                                  .incomeExpenseCategoryList
                                                  .indexWhere((element) =>
                                                      element == newValue)]);
                                });
                              },
                            ),
                          ),
                          PrimaryTextFormField(
                            textEditingController: descController,
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
                              value: incomeController.walletCategoryValue,
                              underline: const SizedBox(
                                height: 0,
                                width: 0,
                              ),
                              icon: Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.525),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: light20,
                                ),
                              ),

                              items: incomeController.walletCategoryList
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
                                  incomeController.changeWalletCategoryValue(
                                      walletValue: newValue!,
                                      walletID: incomeController
                                              .walletCategoryIDList[
                                          incomeController.walletCategoryList
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
                              Switch(
                                value: switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    log(value.toString());
                                    switchValue = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 36),
                          PrimaryElevatedButton(
                            onPressed: () {
                              try {
                                Map<String, dynamic> transactionData = {
                                  'ID': getRandomString(36),
                                  'amount': numericController.text,
                                  'transactionDescription': descController.text,
                                  'datetime': DateTime.now().toString(),
                                  'user': widget.userID,
                                  'transactionType': 'Income',
                                  'wallet':
                                      incomeController.walletCategoryIDValue,
                                  'category': incomeController
                                      .incomeExpenseCategoryIDValue,
                                };
                                createTransaction(
                                        transactionData: transactionData)
                                    .then((value) {
                                  Fluttertoast.showToast(
                                      msg: 'Transaction Created Successfully!');
                                  Get.back();
                                });
                              } catch (e) {
                                log('Expense Screen Continue Button Exception: $e');
                              }
                            },
                            buttonName: 'Continue',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
