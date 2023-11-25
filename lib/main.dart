import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Screens/AuthScreen/login_screen.dart';
import 'package:montra/Screens/PageNavigator/page_navigator.dart';
import 'package:montra/Services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<String>('securityBox');
  await Hive.openBox<String>('sessionIDBox');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Montra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      home: FutureBuilder<Box<String>>(
        future: Hive.openBox<String>('sessionIDBox'),
        builder: (sessionContext, sessionSnapshot) {
          if (sessionSnapshot.connectionState == ConnectionState.done &&
              sessionSnapshot.data != null) {
            String? sessionID = sessionSnapshot.data!.get('sessionID');
            return sessionID != null
                ? FutureBuilder<Session?>(
                    future: getSession(sessionID: sessionID),
                    builder: (sessionIDContext, sessionIDSnapshot) {
                      if (sessionIDSnapshot.connectionState ==
                              ConnectionState.done &&
                          sessionIDSnapshot.data != null) {
                        return PageNavigator(
                          userID: sessionIDSnapshot.data!.userId,
                          sessionID: sessionID,
                        );
                      } else if (sessionIDSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          height: Get.height,
                          width: Get.width,
                          color: light,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (sessionIDSnapshot.hasError) {
                        Fluttertoast.showToast(
                            msg: 'Something went wrong. Please login again!');
                        return const LoginScreen();
                      } else {
                        return const LoginScreen();
                      }
                    },
                  )
                : const LoginScreen();
          } else if (sessionSnapshot.connectionState ==
              ConnectionState.waiting) {
            return Container(
              height: Get.height,
              width: Get.width,
              color: light,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (sessionSnapshot.hasError) {
            Fluttertoast.showToast(
                msg: 'Something went wrong. Please login again!');
            return const LoginScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
