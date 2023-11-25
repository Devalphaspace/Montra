import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/constants.dart';

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
        backgroundColor: light,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            height: 24,
            width: 24,
            color: violet,
          ),
        ),
        title: Text(
          'Notification',
          style: title3.copyWith(
            color: dark50,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: Icon(
              Icons.more_horiz_rounded,
              size: 24,
              color: dark50,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
