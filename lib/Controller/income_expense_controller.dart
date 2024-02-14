import 'package:get/get.dart';

class IncomeExpenseController extends GetxController {
  bool isSubmitButtonLoading = false;
  String incomeExpenseCategoryValue = 'Category';
  List<String> incomeExpenseCategoryList = ['Category'];
  String incomeExpenseCategoryIDValue = 'Category';
  List<String> incomeExpenseCategoryIDList = ['Category'];

  String walletCategoryValue = 'Select Wallet';
  List<String> walletCategoryList = ['Select Wallet'];
  String walletCategoryIDValue = 'Select Wallet';
  List<String> walletCategoryIDList = ['Select Wallet'];

  buttonLoadingStatusModifier({required bool buttonStatus}) {
    isSubmitButtonLoading = buttonStatus;
    update();
  }

  addIncomeExpenseCategories(
      {required List<String> categoryList,
      required List<String> categoryIDList}) {
    incomeExpenseCategoryList.addAll(categoryList);
    incomeExpenseCategoryIDList.addAll(categoryIDList);
  }

  changeIncomeExpenseCategoryValue(
      {required String categoryValue, required String categoryID}) {
    incomeExpenseCategoryValue = categoryValue;
    incomeExpenseCategoryIDValue = categoryID;
  }

  addWalletCategories(
      {required List<String> walletList, required List<String> walletIDList}) {
    walletCategoryList.addAll(walletList);
    walletCategoryIDList.addAll(walletIDList);
  }

  changeWalletCategoryValue(
      {required String walletValue, required String walletID}) {
    walletCategoryValue = walletValue;
    walletCategoryIDValue = walletID;
  }
}
