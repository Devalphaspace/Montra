import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/shared.dart';

import '../../Constants/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            theme: SvgTheme(
              currentColor: dark50,
            ),
          ),
        ),
        title: Text(
          'Notification',
          style: title3.copyWith(
            color: dark50,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Expense Alert',
                    style: body1.copyWith(
                      color: dark25,
                    ),
                  ),
                  subtitle: Text(
                    'Get notification about you’re expense',
                    style: small.copyWith(
                      color: light20,
                    ),
                  ),
                  trailing: PrimarySwitch(
                    switchState: true,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Budget',
                    style: body1.copyWith(
                      color: dark25,
                    ),
                  ),
                  subtitle: Text(
                    'Get notification when you’re budget exceeding the limit',
                    style: small.copyWith(
                      color: light20,
                    ),
                  ),
                  trailing: PrimarySwitch(
                    switchState: true,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Tips & Articles',
                    style: body1.copyWith(
                      color: dark25,
                    ),
                  ),
                  subtitle: Text(
                    'Small & useful pieces of pratical financial advice',
                    style: small.copyWith(
                      color: light20,
                    ),
                  ),
                  trailing: PrimarySwitch(
                    switchState: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
