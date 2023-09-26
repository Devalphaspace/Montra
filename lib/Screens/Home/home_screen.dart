import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:montra/Constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime now = DateTime.now();
  int sideTitleIndex = 2;
  late SideTitles _sideTitles;
  final List<FlSpot> points = const [
    FlSpot(1, 10.0),
    FlSpot(2, 11.0),
    FlSpot(3, 15),
    FlSpot(4, 12),
  ];
  late int showingTooltipSpot;

  String month = DateFormat.MMMM().format(DateTime.now());

  SideTitles get _bottomTitlesMonthly => SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = DateFormat.MMM()
                  .format(DateTime(now.year, now.month - 3, now.day));
              break;
            case 2:
              text = DateFormat.MMM()
                  .format(DateTime(now.year, now.month - 2, now.day));
              break;
            case 3:
              text = DateFormat.MMM()
                  .format(DateTime(now.year, now.month - 1, now.day));
              break;
            case 4:
              text = DateFormat.MMM().format(now);
              break;
          }

          return Text(text);
        },
      );
  SideTitles get _bottomTitlesWeekly => SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'Week 1';
              break;
            case 2:
              text = 'Week 2';
              break;
            case 3:
              text = 'Week 3';
              break;
            case 4:
              text = 'Week 4';
              break;
          }

          return Text(text);
        },
      );
  SideTitles get _bottomTitlesHourly => SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = DateFormat.Hm()
                  .format(DateTime(now.year, now.month, now.day, now.hour - 9));
              break;
            case 2:
              text = DateFormat.Hm()
                  .format(DateTime(now.year, now.month, now.day, now.hour - 6));
              break;
            case 3:
              text = DateFormat.Hm()
                  .format(DateTime(now.year, now.month, now.day, now.hour - 3));
              break;
            case 4:
              text = DateFormat.Hm()
                  .format(DateTime(now.year, now.month, now.day, now.hour));
              break;
          }

          return Text(text);
        },
      );
  SideTitles get _bottomTitlesYearly => SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = DateFormat.y()
                  .format(DateTime(now.year - 3, now.month, now.day));
              break;
            case 2:
              text = DateFormat.y()
                  .format(DateTime(now.year - 2, now.month, now.day));
              break;
            case 3:
              text = DateFormat.y()
                  .format(DateTime(now.year - 1, now.month, now.day));
              break;
            case 4:
              text =
                  DateFormat.y().format(DateTime(now.year, now.month, now.day));
              break;
          }

          return Text(text);
        },
      );

  @override
  void initState() {
    _sideTitles = _bottomTitlesMonthly;
    showingTooltipSpot = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Nothing');
    final _lineBarsData = [
      LineChartBarData(
        spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
        isCurved: true,
        dotData: const FlDotData(
          show: false,
        ),
        barWidth: 5,
        color: violet,
      ),
    ];
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        backgroundColor: light,
        scrolledUnderElevation: 0,
        leading: Container(
          height: 56,
          width: 56,
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: violet,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(56),
          ),
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(56),
            child: Image.asset(
              'assets/images/profile_pic.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        leadingWidth: 72,
        centerTitle: true,
        title: SizedBox(
          width: Get.width * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                // Initial Value
                value: month,
                underline: const SizedBox(
                  height: 0,
                  width: 0,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: light20,
                ),

                items: months.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: light20,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    month = newValue!;
                  });
                },
              ),
              // Icon(
              //   Icons.keyboard_arrow_down_rounded,
              //   color: dark50,
              //   size: 24,
              // ),
              // Text(
              //   DateFormat.MMMM().format(now),
              //   style: body3.copyWith(color: dark50),
              // ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.notification1,
              color: violet,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Account Balance',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: light20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$9400',
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: dark75,
                  ),
                ),
                const SizedBox(height: 16),
                // INCOME EXPENSE CONTAINER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 80,
                        width: Get.width * 0.445,
                        decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: light,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.all(5),
                              child:
                                  SvgPicture.asset('assets/icons/income.svg'),
                            ),
                            const SizedBox(width: 12),
                            RichText(
                              text: TextSpan(
                                text: 'Income\n',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: light80,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\$5000',
                                    style: GoogleFonts.inter(
                                      fontSize: 22,
                                      color: light80,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        height: 80,
                        width: Get.width * 0.445,
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: light,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.all(5),
                              child:
                                  SvgPicture.asset('assets/icons/expense.svg'),
                            ),
                            const SizedBox(width: 12),
                            RichText(
                              text: TextSpan(
                                text: 'Expense\n',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: light80,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\$5000',
                                    style: GoogleFonts.inter(
                                      fontSize: 22,
                                      color: light80,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // GRAPH PART
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Spend Frquency',
                    style: title3.copyWith(color: dark),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: _lineBarsData,
                        borderData: FlBorderData(
                          border: const Border(),
                        ),
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(sideTitles: _sideTitles),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        showingTooltipIndicators: showingTooltipSpot != -1
                            ? [
                                ShowingTooltipIndicators([
                                  LineBarSpot(
                                      _lineBarsData[0],
                                      showingTooltipSpot,
                                      _lineBarsData[0]
                                          .spots[showingTooltipSpot]),
                                ])
                              ]
                            : [],
                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: violet,
                            tooltipRoundedRadius: 20.0,
                            fitInsideHorizontally: true,
                            tooltipMargin: 0,
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map(
                                (LineBarSpot touchedSpot) {
                                  const textStyle = TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  );
                                  return LineTooltipItem(
                                    points[touchedSpot.spotIndex]
                                        .y
                                        .toStringAsFixed(2),
                                    textStyle,
                                  );
                                },
                              ).toList();
                            },
                          ),
                          handleBuiltInTouches: false,
                          touchCallback: (event, response) {
                            if (response?.lineBarSpots != null &&
                                event is FlTapUpEvent) {
                              setState(
                                () {
                                  final spotIndex =
                                      response?.lineBarSpots?[0].spotIndex ??
                                          -1;
                                  if (spotIndex == showingTooltipSpot) {
                                    showingTooltipSpot = -1;
                                  } else {
                                    showingTooltipSpot = spotIndex;
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          sideTitleIndex = 0;
                          _sideTitles = _bottomTitlesHourly;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: sideTitleIndex == 0 ? yellow20 : light,
                        maximumSize: Size(Get.width * 0.2, 36),
                        minimumSize: Size(Get.width * 0.2, 36),
                        foregroundColor: sideTitleIndex == 0 ? yellow : light20,
                      ),
                      child: Text(
                        'Today',
                        style: GoogleFonts.inter(
                          color: sideTitleIndex == 0 ? yellow : light20,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          sideTitleIndex = 1;
                          _sideTitles = _bottomTitlesWeekly;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: sideTitleIndex == 1 ? yellow20 : light,
                        maximumSize: Size(Get.width * 0.2, 36),
                        minimumSize: Size(Get.width * 0.2, 36),
                        foregroundColor: sideTitleIndex == 1 ? yellow : light20,
                      ),
                      child: Text(
                        'Week',
                        style: GoogleFonts.inter(
                          color: sideTitleIndex == 1 ? yellow : light20,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          sideTitleIndex = 2;
                          _sideTitles = _bottomTitlesMonthly;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: sideTitleIndex == 2 ? yellow20 : light,
                        maximumSize: Size(Get.width * 0.2, 36),
                        minimumSize: Size(Get.width * 0.2, 36),
                        foregroundColor: sideTitleIndex == 2 ? yellow : light20,
                      ),
                      child: Text(
                        'Month',
                        style: GoogleFonts.inter(
                          color: sideTitleIndex == 2 ? yellow : light20,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          sideTitleIndex = 3;
                          _sideTitles = _bottomTitlesYearly;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: sideTitleIndex == 3 ? yellow20 : light,
                        maximumSize: Size(Get.width * 0.2, 36),
                        minimumSize: Size(Get.width * 0.2, 36),
                        foregroundColor: sideTitleIndex == 3 ? yellow : light20,
                      ),
                      child: Text(
                        'Year',
                        style: GoogleFonts.inter(
                          color: sideTitleIndex == 3 ? yellow : light20,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                //RECENT TRANSACTION SECTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Recent Transaction',
                      style: title3.copyWith(color: dark25),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: violet20,
                        maximumSize: Size(Get.width * 0.2, 36),
                        minimumSize: Size(Get.width * 0.2, 36),
                        foregroundColor: violet,
                      ),
                      child: Text(
                        'See All',
                        style: GoogleFonts.inter(
                          color: violet,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.separated(
                  itemCount: 6,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: Get.height * 0.1,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: light80,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: yellow20,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Iconsax.trash,
                              color: yellow,
                              size: 36,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.4,
                                  child: Text(
                                    'Shopping',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: dark25,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: Get.width * 0.4,
                                  child: Text(
                                    'Buy some grocery',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: light20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '-\$120',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: red,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  DateFormat("hh:mm a")
                                      .format(DateTime.now())
                                      .toString(),
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: light20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
