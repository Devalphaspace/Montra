import 'dart:developer';

import 'package:get/get.dart';

class TransactionsController extends GetxController {
  List<String> transactionCategoryList = [];
  List<String> transactionCategoryIDList = [];
  bool isIncome = false;
  bool isExpense = false;
  bool isHighest = false;
  bool isLowest = false;
  bool isNewest = false;
  bool isOldest = false;
  List<String> selectedCategory = [];
  List<String> selectedCategoryID = [];
  bool filterCounter = false;

  increaseFilterCount() {
    filterCounter = isIncome ||
        isExpense ||
        isHighest ||
        isLowest ||
        isOldest ||
        isNewest ||
        selectedCategory.isNotEmpty;

    log('start'.toString());
    log(isIncome.toString());
    log(isExpense.toString());
    log(isHighest.toString());
    log(isLowest.toString());
    log(isOldest.toString());
    log(isNewest.toString());
    log(filterCounter.toString());
    log('end'.toString());
    update();
  }

  transactionCategories({
    required List<String> categoryList,
    required List<String> categoryIDList,
  }) {
    transactionCategoryList.addAll(categoryList);
    transactionCategoryIDList.addAll(categoryIDList);
  }

  selectTransactionsCategory({
    required List<String> categories,
  }) {
    categories.forEach((element) {
      selectedCategory.add(element);
    });
    // selectedCategory.addAll(categories);
  }

  isIncomeStatusModifier({required bool status}) {
    isIncome = status;
  }

  isExpenseStatusModifier({required bool status}) {
    isExpense = status;
  }

  isHighestStatusModifier({required bool status}) {
    if (status == true) {
      isHighest = status;
      isLowest = false;
      isNewest = false;
      isOldest = false;
    } else {
      isHighest = status;
    }
  }

  isLowestStatusModifier({required bool status}) {
    if (status == true) {
      isHighest = false;
      isLowest = status;
      isNewest = false;
      isOldest = false;
    } else {
      isLowest = status;
    }
  }

  isNewestStatusModifier({required bool status}) {
    if (status == true) {
      isHighest = false;
      isLowest = false;
      isNewest = status;
      isOldest = false;
    } else {
      isNewest = status;
    }
  }

  isOldestStatusModifier({required bool status}) {
    if (status == true) {
      isHighest = false;
      isLowest = false;
      isNewest = false;
      isOldest = status;
    } else {
      isOldest = status;
    }
  }

  resetController() {
    isIncome = false;
    isExpense = false;
    isHighest = false;
    isLowest = false;
    isNewest = false;
    isOldest = false;
    selectedCategory.clear();
    selectedCategoryID.clear();
    filterCounter = false;
    update();
  }
}
