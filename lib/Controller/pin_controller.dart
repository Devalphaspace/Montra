import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PinController extends GetxController {
  String? securityPin;

  Future<void> initializeSecurityPin(
      {required String enteredSecurityPin}) async {
    var securityBox = await Hive.openBox<String>('securityBox');
    if (!securityBox.containsKey('securityPin')) {
      await securityBox.put('securityPin', enteredSecurityPin);
    }

    update();
  }

  Future<bool> checkSecurityPin({required String enteredSecurityPin}) async {
    var securityBox = await Hive.openBox<String>('securityBox');
    String? securityPin = securityBox.get('securityPin', defaultValue: null);
    bool isMatched;

    if (securityPin != null) {
      isMatched = securityPin == enteredSecurityPin;
    } else {
      log('Security Pin is Null');
      isMatched = false;
    }

    update();

    return isMatched;
  }

  Future<bool> updateSecurityPin({required String enteredSecurityPin}) async {
    var securityBox = await Hive.openBox<String>('securityBox');
    bool isUpdated = false;
    try {
      await securityBox.put('securityPin', enteredSecurityPin).then((value) {
        isUpdated = true;
      });
    } catch (e) {
      log(e.toString());
      isUpdated = false;
    }

    update();

    return isUpdated;
  }
}
