import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Screens/Notification/notification_screen.dart';
import 'package:montra/Services/database_services.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../Controller/home_controller.dart';
import '../../Services/storage_services.dart';
import '../../git_ignore.dart';

class HomeScreen extends StatefulWidget {
  final String userID;
  const HomeScreen({
    super.key,
    required this.userID,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String svgCode = RandomAvatarString('saytoonz', trBackground: true);
  HomeController homeController = Get.put(HomeController());
  DateTime now = DateTime.now();
  int sideTitleIndex = 2;
  late SideTitles _sideTitles;

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
    final _lineBarsData = [
      LineChartBarData(
        spots: homeController.points
            .map((point) => FlSpot(point.x, point.y))
            .toList(),
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
        leading: FutureBuilder<DocumentList?>(
            future: fetchProfile(userID: widget.userID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: violet,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                return FutureBuilder(
                    future: storage.getFileView(
                      bucketId: profilePictureBucketID,
                      fileId: widget.userID,
                    ),
                    builder: (profilePiccontext, profilePicsnapshot) {
                      log(profilePicsnapshot.connectionState.toString());
                      if (profilePicsnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: violet,
                          ),
                        );
                      } else if (profilePicsnapshot.connectionState ==
                              ConnectionState.done &&
                          profilePicsnapshot.data != null) {
                        return Container(
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
                            child: Image.memory(
                              profilePicsnapshot.data!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        return SvgPicture.string(
                          svgCode,
                          fit: BoxFit.cover,
                        );
                      }
                    });
              } else {
                return SvgPicture.string(
                  svgCode,
                  fit: BoxFit.cover,
                );
              }
            }),
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
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const NotificationScreen());
            },
            icon: Icon(
              Iconsax.notification1,
              color: violet,
              size: 24,
            ),
          ),
        ],
      ),
      body: GetBuilder<HomeController>(builder: (homeCtlContext) {
        return FutureBuilder<DocumentList?>(
            future: fetchTransactionsWithUserID(userID: widget.userID),
            builder: (databaseContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                List<Document> transactions = snapshot.data!.documents;
                return FutureBuilder<DocumentList?>(
                    future: fetchWallets(userID: widget.userID),
                    builder: (fetchWalletContext, fetchWalletsnapshot) {
                      if (fetchWalletsnapshot.connectionState ==
                              ConnectionState.done &&
                          fetchWalletsnapshot.data != null) {
                        double totalAmount = 0;
                        for (var element
                            in fetchWalletsnapshot.data!.documents) {
                          totalAmount += element.data['walletAmount'];
                        }
                        double totalIncome = 0;
                        double totalExpense = 0;
                        for (var element in snapshot.data!.documents) {
                          if (element.data['transactionType'] == 'Expense') {
                            totalExpense += element.data['amount'];
                          } else if (element.data['transactionType'] ==
                              'Income') {
                            totalIncome += element.data['amount'];
                          }
                        }

                        log('This Month: ${DateFormat.yMd().format(DateTime(now.year, now.month, now.day))}');
                        return SafeArea(
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
                                    '\$$totalAmount',
                                    style: GoogleFonts.inter(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                      color: dark75,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // INCOME EXPENSE CONTAINER
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 80,
                                          width: Get.width * 0.445,
                                          decoration: BoxDecoration(
                                            color: green,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 4,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 36,
                                                width: 36,
                                                decoration: BoxDecoration(
                                                  color: light,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: SvgPicture.asset(
                                                    'assets/icons/income.svg'),
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
                                                      text: '\$$totalIncome',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 22,
                                                        color: light80,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 4,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 36,
                                                width: 36,
                                                decoration: BoxDecoration(
                                                  color: light,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: SvgPicture.asset(
                                                    'assets/icons/expense.svg'),
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
                                                      text: '\$$totalExpense',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 22,
                                                        color: light80,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: AspectRatio(
                                      aspectRatio: 1.5,
                                      child: LineChart(
                                        LineChartData(
                                          lineBarsData: _lineBarsData,
                                          borderData: FlBorderData(
                                            border: const Border(),
                                          ),
                                          gridData:
                                              const FlGridData(show: false),
                                          titlesData: FlTitlesData(
                                            bottomTitles: AxisTitles(
                                                sideTitles: _sideTitles),
                                            leftTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            topTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            rightTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                          ),
                                          showingTooltipIndicators:
                                              showingTooltipSpot != -1
                                                  ? [
                                                      ShowingTooltipIndicators([
                                                        LineBarSpot(
                                                            _lineBarsData[0],
                                                            showingTooltipSpot,
                                                            _lineBarsData[0]
                                                                    .spots[
                                                                showingTooltipSpot]),
                                                      ])
                                                    ]
                                                  : [],
                                          lineTouchData: LineTouchData(
                                            enabled: true,
                                            touchTooltipData:
                                                LineTouchTooltipData(
                                              tooltipBgColor: violet,
                                              tooltipRoundedRadius: 20.0,
                                              fitInsideHorizontally: true,
                                              tooltipMargin: 0,
                                              getTooltipItems: (touchedSpots) {
                                                return touchedSpots.map(
                                                  (LineBarSpot touchedSpot) {
                                                    const textStyle = TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    );
                                                    return LineTooltipItem(
                                                      homeController
                                                          .points[touchedSpot
                                                              .spotIndex]
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
                                              if (response?.lineBarSpots !=
                                                      null &&
                                                  event is FlTapUpEvent) {
                                                setState(
                                                  () {
                                                    final spotIndex = response
                                                            ?.lineBarSpots?[0]
                                                            .spotIndex ??
                                                        -1;
                                                    if (spotIndex ==
                                                        showingTooltipSpot) {
                                                      showingTooltipSpot = -1;
                                                    } else {
                                                      showingTooltipSpot =
                                                          spotIndex;
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            sideTitleIndex = 0;
                                            _sideTitles = _bottomTitlesHourly;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: sideTitleIndex == 0
                                              ? yellow20
                                              : light,
                                          maximumSize:
                                              Size(Get.width * 0.2, 36),
                                          minimumSize:
                                              Size(Get.width * 0.2, 36),
                                          foregroundColor: sideTitleIndex == 0
                                              ? yellow
                                              : light20,
                                        ),
                                        child: Text(
                                          'Today',
                                          style: GoogleFonts.inter(
                                            color: sideTitleIndex == 0
                                                ? yellow
                                                : light20,
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
                                          backgroundColor: sideTitleIndex == 1
                                              ? yellow20
                                              : light,
                                          maximumSize:
                                              Size(Get.width * 0.2, 36),
                                          minimumSize:
                                              Size(Get.width * 0.2, 36),
                                          foregroundColor: sideTitleIndex == 1
                                              ? yellow
                                              : light20,
                                        ),
                                        child: Text(
                                          'Week',
                                          style: GoogleFonts.inter(
                                            color: sideTitleIndex == 1
                                                ? yellow
                                                : light20,
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

                                            double firstValue = 0.0;
                                            double secondValue = 0.0;
                                            double thirdValue = 0.0;
                                            double fourthValue = 0.0;

                                            snapshot.data!.documents
                                                .forEach((element) {
                                              if (DateFormat.yMMMM().format(DateTime.parse(element.data['datetime'])) ==
                                                  DateFormat.yMMMM().format(
                                                      DateTime(
                                                          now.year,
                                                          now.month,
                                                          now.day))) {
                                                firstValue +=
                                                    element.data['amount'];
                                              } else if (DateFormat.yMMMM().format(DateTime.parse(element.data['datetime'])) ==
                                                  DateFormat.yMMMM().format(
                                                      DateTime(
                                                          now.year,
                                                          now.month - 1,
                                                          now.day))) {
                                                firstValue +=
                                                    element.data['amount'];
                                              } else if (DateFormat.yMMMM().format(DateTime.parse(element.data['datetime'])) ==
                                                  DateFormat.yMMMM().format(
                                                      DateTime(
                                                          now.year,
                                                          now.month - 2,
                                                          now.day))) {
                                                firstValue +=
                                                    element.data['amount'];
                                              } else if (DateFormat.yMMMM().format(
                                                      DateTime.parse(element.data['datetime'])) ==
                                                  DateFormat.yMMMM().format(DateTime(now.year, now.month - 3, now.day))) {
                                                firstValue +=
                                                    element.data['amount'];
                                              }
                                            });

                                            homeController.updatePoints(
                                                firstValue: firstValue,
                                                secondValue: secondValue,
                                                thirdValue: thirdValue,
                                                fourthValue: fourthValue);
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: sideTitleIndex == 2
                                              ? yellow20
                                              : light,
                                          maximumSize:
                                              Size(Get.width * 0.2, 36),
                                          minimumSize:
                                              Size(Get.width * 0.2, 36),
                                          foregroundColor: sideTitleIndex == 2
                                              ? yellow
                                              : light20,
                                        ),
                                        child: Text(
                                          'Month',
                                          style: GoogleFonts.inter(
                                            color: sideTitleIndex == 2
                                                ? yellow
                                                : light20,
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

                                            double firstValue = 0.0;
                                            double secondValue = 0.0;
                                            double thirdValue = 0.0;
                                            double fourthValue = 0.0;

                                            snapshot.data!.documents.forEach((element) {
                                              if (DateFormat.y().format(
                                                      DateTime.parse(element.data['datetime'])) ==
                                                  DateFormat.y().format(
                                                      DateTime(now.year, now.month, now.day))) {
                                                firstValue += element.data['amount'];
                                              } else if (DateFormat.y().format(
                                                      DateTime.parse(element.data['datetime'])) ==
                                                  DateFormat.y().format(DateTime(
                                                      now.year - 1, now.month, now.day))) {
                                                firstValue += element.data['amount'];
                                              } else if (DateFormat.y().format(
                                                      DateTime.parse(element.data['datetime'])) ==
                                                  DateFormat.y().format(DateTime(
                                                      now.year - 2, now.month, now.day))) {
                                                firstValue += element.data['amount'];
                                              } else if (DateFormat.y().format(
                                                      DateTime.parse(element.data['datetime'])) ==
                                                  DateFormat.y()
                                                      .format(DateTime(now.year - 3, now.month, now.day))) {
                                                firstValue += element.data['amount'];
                                              }
                                            });

                                            homeController.updatePoints(
                                                firstValue: firstValue,
                                                secondValue: secondValue,
                                                thirdValue: thirdValue,
                                                fourthValue: fourthValue);
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: sideTitleIndex == 3
                                              ? yellow20
                                              : light,
                                          maximumSize:
                                              Size(Get.width * 0.2, 36),
                                          minimumSize:
                                              Size(Get.width * 0.2, 36),
                                          foregroundColor: sideTitleIndex == 3
                                              ? yellow
                                              : light20,
                                        ),
                                        child: Text(
                                          'Year',
                                          style: GoogleFonts.inter(
                                            color: sideTitleIndex == 3
                                                ? yellow
                                                : light20,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Recent Transaction',
                                        style: title3.copyWith(color: dark25),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          backgroundColor: violet20,
                                          maximumSize:
                                              Size(Get.width * 0.2, 36),
                                          minimumSize:
                                              Size(Get.width * 0.2, 36),
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
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 10,
                                    itemBuilder: (context, transactionIndex) {
                                      return TransactionCards(
                                        transactionCardIcon:
                                            Iconsax.shopping_bag,
                                        transactionCardName:
                                            transactions[transactionIndex]
                                                .data['category']
                                                    ['categoryName']
                                                .toString(),
                                        transactionCardDesc:
                                            transactions[transactionIndex]
                                                .data['transactionDescription']
                                                .toString(),
                                        transactionCardAmount:
                                            transactions[transactionIndex]
                                                .data['amount']
                                                .toString(),
                                        transactionCardTime: DateTime.parse(
                                            transactions[transactionIndex]
                                                .data['datetime']),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (fetchWalletsnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (fetchWalletsnapshot.hasError) {
                        log('Has Error: ${snapshot.hasError}');
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        log(snapshot.connectionState.toString());
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                log(snapshot.connectionState.toString());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                log('Has Error: ${snapshot.hasError}');
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                log(snapshot.connectionState.toString());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      }),
    );
  }
}
