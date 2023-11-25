import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/shared.dart';

import '../../Constants/constants.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  String transactionTypeValue = 'All';
  String dateRangeValue = 'Last 30 days';
  String downloadFormatValue = 'CSV';
  List<String> transactionTypeList = ['All', 'Income', 'Expense'];
  List<String> dateRangeList = ['Last 30 days', 'Last 7 days', 'Last 365 days'];
  List<String> downloadFormatList = ['CSV', 'PDF'];
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
          'Export Data',
          style: title3.copyWith(
            color: dark50,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What data do your want to export?',
                style: body1.copyWith(
                  color: dark75,
                ),
              ),
              const SizedBox(height: 16),
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: DropdownButton(
                  value: transactionTypeValue,
                  style: title3,
                  alignment: AlignmentDirectional.centerStart,
                  borderRadius: BorderRadius.circular(8),
                  underline: Container(
                    height: 0,
                    width: 0,
                    color: Colors.transparent,
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.625),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: light20,
                      size: 24,
                    ),
                  ),
                  items: transactionTypeList.map(
                    (String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: body1.copyWith(color: light20),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      transactionTypeValue = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'When date range?',
                style: body1.copyWith(
                  color: dark75,
                ),
              ),
              const SizedBox(height: 16),
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: DropdownButton(
                  value: dateRangeValue,
                  style: title3,
                  alignment: AlignmentDirectional.centerStart,
                  borderRadius: BorderRadius.circular(8),
                  underline: Container(
                    height: 0,
                    width: 0,
                    color: Colors.transparent,
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.525),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: light20,
                      size: 24,
                    ),
                  ),
                  items: dateRangeList.map(
                    (String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: body1.copyWith(color: light20),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dateRangeValue = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'What format do you want to export?',
                style: body1.copyWith(
                  color: dark75,
                ),
              ),
              const SizedBox(height: 16),
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: DropdownButton(
                  value: downloadFormatValue,
                  style: title3,
                  alignment: AlignmentDirectional.centerStart,
                  borderRadius: BorderRadius.circular(8),
                  underline: Container(
                    height: 0,
                    width: 0,
                    color: Colors.transparent,
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.675),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: light20,
                      size: 24,
                    ),
                  ),
                  items: downloadFormatList.map(
                    (String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: body1.copyWith(color: light20),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      downloadFormatValue = value!;
                    });
                  },
                ),
              ),
              const Spacer(),
              PrimaryElevatedIconButton(
                onPressed: () {},
                buttonName: 'Export',
                iconString: 'assets/icons/upload.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
