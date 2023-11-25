import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Controller/income_expense_controller.dart';
import 'package:montra/Services/database_services.dart';

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
  String categoryvalue = 'Category';
  String expensevalue = 'Wallet';
  bool switchValue = false;
  File? image;
  IncomeExpenseController expenseController =
      Get.put(IncomeExpenseController());
  List<String> expenseCategoryList = [
    'Category',
  ];

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
        documents!.forEach((element) {
          documentList.add(element.data['categoryName']);
        });
        expenseController.addExpenseCategories(categoryList: documentList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IncomeExpenseController>(builder: (context) {
      return GestureDetector(
        onTap: () {
          setState(() {});
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
                          value: expenseController.expenseCategoryValue,
                          underline: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          icon: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.525 - categoryvalue.length),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: light20,
                            ),
                          ),

                          items: expenseController.expenseCategoryList
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
                              expenseController.changeExpenseCategoryValue(
                                  categoryValue: newValue!);
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
                          value: expensevalue,
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

                          items: expenseFrom.map((String items) {
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
                              expensevalue = newValue!;
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
                      PrimaryElevatedButton(
                        onPressed: () {
                          log(expenseCategoryList.toString());
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
      );
    });
  }
}
