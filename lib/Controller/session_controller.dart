import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SessionController extends GetxController {
  String? sessionID;

  Future<void> initializeSessionID({required String passedSessionID}) async {
    var sessionBox = await Hive.openBox<String>('sessionIDBox');
    if (!sessionBox.containsKey('sessionID')) {
      await sessionBox.put('sessionID', passedSessionID);
    }
    update();
  }
  Future<void> deleteSessionID() async {
    var sessionBox = await Hive.openBox<String>('sessionIDBox');
    if (sessionBox.containsKey('sessionID')) {
      await sessionBox.delete('sessionID');
    }
    update();
  }

  Future<String?> getSecurityPin() async {
    try {
      var sessionBox = await Hive.openBox<String>('sessionIDBox');
      String? sessionID = sessionBox.get('sessionID', defaultValue: null);
      return sessionID;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
