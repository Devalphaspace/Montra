import 'package:get/get.dart';

class IncomeExpenseController extends GetxController {
  String expenseCategoryValue = 'Category';
  List<String> expenseCategoryList = ['Category'];

  addExpenseCategories({required List<String> categoryList}) {
    expenseCategoryList.addAll(categoryList);
  }

  changeExpenseCategoryValue({required String categoryValue}) {
    expenseCategoryValue = categoryValue;
  }
}
