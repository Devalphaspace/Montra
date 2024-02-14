import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:montra/Constants/shared.dart';

import '../../Constants/constants.dart';
import '../../Controller/transactions_controller.dart';
import '../../Services/database_services.dart';

class TransactionScreen extends StatefulWidget {
  final String userID;
  const TransactionScreen({
    super.key,
    required this.userID,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TransactionsController transactionsController =
      Get.put(TransactionsController());
  String selectedMonth = 'Month';
  List<String> transactionMonth = ['Month'];
  String today = DateTime.now().toString().substring(0, 10);
  String yesterday = DateTime.now()
      .subtract(const Duration(days: 1))
      .toString()
      .substring(0, 10);
  List<String> distinctDatetimes = [];
  List<Document> transactions = [];

  @override
  void initState() {
    super.initState();
    transactionMonth.addAll(months);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<TransactionsController>(builder: (getXContext) {
        return Scaffold(
          backgroundColor: light,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: light,
            foregroundColor: light,
            automaticallyImplyLeading: false,
            title: SizedBox(
              width: Get.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                    // Initial Value
                    value: selectedMonth,
                    underline: const SizedBox(
                      height: 0,
                      width: 0,
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: light20,
                    ),

                    items: transactionMonth.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: dark50,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () async {
                    bool isIncome = transactionsController.isIncome;
                    bool isExpense = transactionsController.isExpense;
                    bool isHighest = transactionsController.isHighest;
                    bool isLowest = transactionsController.isLowest;
                    bool isNewest = transactionsController.isNewest;
                    bool isOldest = transactionsController.isOldest;
                    List<String> documentList = [];
                    List<String> documentIDList = [];
                    List<String> selectedCategory =
                        transactionsController.selectedCategory;
                    List<String> selectedCategoryIDs =
                        transactionsController.selectedCategoryID;

                    fetchCategories(userID: widget.userID).then(
                      (documents) {
                        documents!.forEach((element) {
                          documentList.add(element.data['categoryName']);
                          documentIDList.add(element.$id.toString());
                        });
                        transactionsController.transactionCategories(
                            categoryList: documentList,
                            categoryIDList: documentIDList);
                      },
                    );

                    await showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      showDragHandle: true,
                      barrierColor: dark.withOpacity(0.16),
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              StateSetter setModalState) {
                            return Container(
                              width: Get.width,
                              height: Get.height * 0.6,
                              padding: const EdgeInsets.only(
                                right: 16,
                                left: 16,
                                bottom: 24,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Filter Transaction',
                                        style: body2.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      CustomTextButton(
                                        buttonName: 'Reset',
                                        buttonMinWidth: Get.width * 0.2,
                                        buttonMinHeight: 40,
                                        isActive: true,
                                        onPressed: () {
                                          setModalState(() {
                                            transactionsController
                                                .resetController();
                                            isIncome = false;
                                            isExpense = false;
                                            isHighest = false;
                                            isLowest = false;
                                            isNewest = false;
                                            isOldest = false;
                                            selectedCategory.clear();
                                            selectedCategoryIDs.clear();
                                            Get.back();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Filter By',
                                    style: body2.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomTextButton(
                                        buttonName: 'Income',
                                        buttonMinWidth: Get.width * 0.45,
                                        buttonMinHeight: 40,
                                        isActive: isIncome,
                                        onPressed: () {
                                          setModalState(() {
                                            isIncome = !isIncome;
                                            log(isIncome.toString());
                                          });
                                        },
                                      ),
                                      CustomTextButton(
                                        buttonName: 'Expense',
                                        buttonMinWidth: Get.width * 0.45,
                                        buttonMinHeight: 40,
                                        isActive: isExpense,
                                        onPressed: () {
                                          setModalState(() {
                                            isExpense = !isExpense;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Sort By',
                                    style: body2.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: Get.width * 0.01,
                                    children: [
                                      CustomTextButton(
                                        buttonName: 'Highest',
                                        buttonMinWidth: Get.width * 0.3,
                                        buttonMinHeight: 40,
                                        isActive: isHighest,
                                        onPressed: () {
                                          setModalState(() {
                                            isHighest = !isHighest;
                                            isLowest = false;
                                            isNewest = false;
                                            isOldest = false;
                                          });
                                        },
                                      ),
                                      CustomTextButton(
                                        buttonName: 'Lowest',
                                        buttonMinWidth: Get.width * 0.3,
                                        buttonMinHeight: 40,
                                        isActive: isLowest,
                                        onPressed: () {
                                          setModalState(() {
                                            isHighest = false;
                                            isLowest = !isLowest;
                                            isNewest = false;
                                            isOldest = false;
                                          });
                                        },
                                      ),
                                      CustomTextButton(
                                        buttonName: 'Newest',
                                        buttonMinWidth: Get.width * 0.3,
                                        buttonMinHeight: 40,
                                        isActive: isNewest,
                                        onPressed: () {
                                          setModalState(() {
                                            isHighest = false;
                                            isLowest = false;
                                            isNewest = !isNewest;
                                            isOldest = false;
                                          });
                                        },
                                      ),
                                      CustomTextButton(
                                        buttonName: 'Oldest',
                                        buttonMinWidth: Get.width * 0.3,
                                        buttonMinHeight: 40,
                                        isActive: isOldest,
                                        onPressed: () {
                                          setModalState(() {
                                            isHighest = false;
                                            isLowest = false;
                                            isNewest = false;
                                            isOldest = !isOldest;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Category',
                                    style: body2.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        showDragHandle: true,
                                        barrierColor: dark.withOpacity(0.16),
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (BuildContext context,
                                                StateSetter setCategoryState) {
                                              return Container(
                                                width: Get.width,
                                                padding: const EdgeInsets.only(
                                                  right: 16,
                                                  left: 16,
                                                  bottom: 24,
                                                ),
                                                child: Wrap(
                                                  spacing: Get.width * 0.01,
                                                  children: documentList.map(
                                                    (e) {
                                                      return selectedCategory
                                                              .contains(
                                                                  e.toString())
                                                          ? CustomTextButton(
                                                              buttonName:
                                                                  e.toString(),
                                                              buttonMinWidth:
                                                                  Get.width *
                                                                      0.3,
                                                              buttonMinHeight:
                                                                  40,
                                                              isActive: true,
                                                              onPressed: () {
                                                                setModalState(
                                                                    () {
                                                                  setCategoryState(
                                                                      () {
                                                                    if (selectedCategory
                                                                        .contains(
                                                                            e.toString())) {
                                                                      selectedCategory
                                                                          .remove(
                                                                              e.toString());
                                                                    } else {
                                                                      selectedCategory
                                                                          .add(e
                                                                              .toString());
                                                                    }
                                                                  });
                                                                });
                                                              },
                                                            )
                                                          : CustomTextButton(
                                                              buttonName:
                                                                  e.toString(),
                                                              buttonMinWidth:
                                                                  Get.width *
                                                                      0.3,
                                                              buttonMinHeight:
                                                                  40,
                                                              isActive: false,
                                                              onPressed: () {
                                                                setModalState(
                                                                    () {
                                                                  setCategoryState(
                                                                    () {
                                                                      if (selectedCategory
                                                                          .contains(
                                                                              e.toString())) {
                                                                        selectedCategory
                                                                            .remove(e.toString());
                                                                      } else {
                                                                        selectedCategory
                                                                            .add(e.toString());
                                                                      }
                                                                    },
                                                                  );
                                                                });
                                                              },
                                                            );
                                                    },
                                                  ).toList(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Choose Category',
                                            style: GoogleFonts.inter(
                                              color: dark25,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '${selectedCategory.length} Selected',
                                            style: GoogleFonts.inter(
                                              color: light20,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right_rounded,
                                            color: violet,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  PrimaryElevatedButton(
                                    onPressed: () {
                                      if (isHighest ||
                                          isLowest ||
                                          isOldest ||
                                          isNewest) {
                                        transactionsController
                                            .isHighestStatusModifier(
                                                status: isHighest);
                                        transactionsController
                                            .isLowestStatusModifier(
                                                status: isLowest);
                                        transactionsController
                                            .isNewestStatusModifier(
                                                status: isNewest);
                                        transactionsController
                                            .isOldestStatusModifier(
                                                status: isOldest);
                                        transactionsController
                                            .increaseFilterCount();
                                      }
                                      if (isIncome || isExpense) {
                                        transactionsController
                                            .isIncomeStatusModifier(
                                                status: isIncome);
                                        transactionsController
                                            .isExpenseStatusModifier(
                                                status: isExpense);
                                        transactionsController
                                            .increaseFilterCount();
                                      }
                                      if (selectedCategory.isNotEmpty) {
                                        transactionsController
                                            .selectTransactionsCategory(
                                          categories: selectedCategory,
                                        );
                                        transactionsController
                                            .increaseFilterCount();
                                      }

                                      Get.back();
                                    },
                                    buttonName: 'Apply',
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: Badge(
                    label: transactionsController.filterCounter
                        ? Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                    backgroundColor: transactionsController.filterCounter
                        ? violet
                        : Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/hamburger.svg',
                      theme: SvgTheme(
                        currentColor: dark50,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: FutureBuilder<DocumentList?>(
              future: transactionsController.filterCounter
                  ? fetchFilteredTransactionsWithUserID(
                      userID: widget.userID,
                      isIncome: transactionsController.isIncome,
                      isExpense: transactionsController.isExpense,
                      isHighest: transactionsController.isHighest,
                      isLowest: transactionsController.isLowest,
                      isNewest: transactionsController.isNewest,
                      isOldest: transactionsController.isOldest,
                    )
                  : fetchTransactionsWithUserID(userID: widget.userID),
              builder: (transactionContext, transactionSnapshot) {
                if (transactionSnapshot.connectionState ==
                        ConnectionState.done &&
                    transactionSnapshot.data != null) {
                  transactions = transactionSnapshot.data!.documents;
                  List<DateTime> transactionDates = [];
                  for (var element in transactions) {
                    // print(element.data['datetime'].toString());
                    DateTime elementDateTimeString =
                        DateTime.parse(element.data['datetime']);
                    if (!transactionDates.contains(elementDateTimeString)) {
                      transactionDates.add(elementDateTimeString);
                    }
                  }

                  transactionDates.sort((a, b) => b.millisecondsSinceEpoch
                      .compareTo(a.millisecondsSinceEpoch));

                  for (var dates in transactionDates) {
                    if (!distinctDatetimes
                        .contains(dates.toString().substring(0, 10))) {
                      distinctDatetimes.add(dates.toString().substring(0, 10));
                    }
                  }

                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: violet20,
                                  borderRadius: BorderRadius.circular(8)),
                              height: Get.height * 0.05,
                              width: Get.width,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'See your financial report',
                                    style: GoogleFonts.inter(
                                      color: violet,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: violet,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: distinctDatetimes.length,
                              itemBuilder: (context, index) {
                                List<Map<String, dynamic>> filteredData = [];
                                for (var element in transactions) {
                                  if (DateTime.parse(element.data['datetime'])
                                          .toString()
                                          .substring(0, 10) ==
                                      distinctDatetimes[index]
                                          .toString()
                                          .substring(0, 10)) {
                                    filteredData.add(element.data);
                                  }
                                }
                                return SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        distinctDatetimes[index]
                                                    .toString()
                                                    .substring(0, 10) ==
                                                today
                                            ? 'Today'
                                            : distinctDatetimes[index]
                                                        .toString()
                                                        .substring(0, 10) ==
                                                    yesterday
                                                ? 'Yesterday'
                                                : distinctDatetimes[index]
                                                    .toString()
                                                    .substring(0, 10),
                                        style: title3.copyWith(
                                          color: dark,
                                        ),
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: filteredData.length,
                                        itemBuilder: (context, filteredIndex) {
                                          return TransactionCards(
                                            transactionCardIcon:
                                                Iconsax.shopping_bag,
                                            transactionCardName:
                                                filteredData[filteredIndex]
                                                            ['category']
                                                        ['categoryName']
                                                    .toString(),
                                            transactionCardDesc: filteredData[
                                                        filteredIndex]
                                                    ['transactionDescription']
                                                .toString(),
                                            transactionCardAmount:
                                                filteredData[filteredIndex]
                                                        ['amount']
                                                    .toString(),
                                            transactionCardTime: DateTime.parse(
                                                filteredData[filteredIndex]
                                                    ['datetime']),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 16),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (transactionSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (transactionSnapshot.hasError) {
                  log('Has Error: ${transactionSnapshot.hasError}');
                  return Center(
                    child: Text(transactionSnapshot.error.toString()),
                  );
                } else {
                  // log(transactionSnapshot.connectionState.toString());
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        );
      }),
    );
  }
}
