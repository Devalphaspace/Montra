import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Screens/Home/expense_screen.dart';
import 'package:montra/Screens/Home/home_screen.dart';
import 'package:montra/Screens/Home/income_screen.dart';

class PageNavigator extends StatefulWidget {
  const PageNavigator({super.key});

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  List<IconData> iconList = [
    Iconsax.home1,
    Iconsax.arrow_swap_horizontal,
    Iconsax.chart_15,
    Iconsax.user_octagon,
  ];

  int _bottomNavIndex = 0;

  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var mini = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(56.0, 56.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const IndexedStack(
        children: [
          HomeScreen(),
          HomeScreen(),
          HomeScreen(),
          HomeScreen(),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        mini: mini,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        backgroundColor: violet,
        iconTheme: IconThemeData(
          color: light,
          size: 24,
        ),
        dialRoot: customDialRoot
            ? (ctx, open, toggleChildren) {
                return ElevatedButton(
                  onPressed: toggleChildren,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: violet,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 18),
                  ),
                  child: const Text(
                    "Custom Dial Root",
                    style: TextStyle(fontSize: 17),
                  ),
                );
              }
            : null,
        buttonSize: buttonSize,
        label: extend ? const Text("Open") : null,
        activeLabel: extend ? const Text("Close") : null,
        childrenButtonSize: childrenButtonSize,
        visible: visible,
        direction: speedDialDirection,
        switchLabelPosition: switchLabelPosition,
        closeManually: closeManually,
        renderOverlay: renderOverlay,
        useRotationAnimation: useRAnimation,
        heroTag: 'speed-dial-hero-tag',
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        shape: customDialRoot
            ? const RoundedRectangleBorder()
            : const StadiumBorder(),
        // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          SpeedDialChild(
            child: !rmicons
                ? SvgPicture.asset(
                    'assets/icons/expense.svg',
                    height: 24,
                    width: 24,
                    color: light,
                  )
                : null,
            backgroundColor: red,
            foregroundColor: light,
            onTap: () => setState(() {
              rmicons = false;
              Get.to(() => const ExpenseScreen());
            }),
          ),
          SpeedDialChild(
            child: !rmicons
                ? SvgPicture.asset(
                    'assets/icons/income.svg',
                    height: 24,
                    width: 24,
                    color: light,
                  )
                : null,
            backgroundColor: green,
            foregroundColor: light,
            visible: true,
            onTap: () => setState(() {
              rmicons = false;
              Get.to(() => const IncomeScreen());
            }),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: light80,
        icons: iconList,
        // elevation: 0,
        activeColor: violet,
        inactiveColor: const Color(0xffC6C6C6),
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        iconSize: 28,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }
}
