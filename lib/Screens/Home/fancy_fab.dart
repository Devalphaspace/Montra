import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra/Constants/constants.dart';


class FancyFab extends StatefulWidget {
  const FancyFab({super.key});

  @override
  State<FancyFab> createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  final Curve _curve = Curves.easeOut;
  final double _fabHeight = 56;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: violet,
      end: violet,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0,
          0.75,
          curve: _curve,
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget expense() {
    return FloatingActionButton(
      onPressed: null,
      tooltip: 'Expense',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0,
      backgroundColor: red,
      child: SvgPicture.asset(
        'assets/icons/expense.svg',
        height: 24,
        width: 24,
        color: light,
      ),
    );
  }

  Widget income() {
    return FloatingActionButton(
      onPressed: null,
      elevation: 0,
      tooltip: 'Income',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      backgroundColor: green,
      child: SvgPicture.asset(
        'assets/icons/income.svg',
        height: 24,
        width: 24,
        color: light,
      ),
    );
  }

  Widget transaction() {
    return FloatingActionButton(
      onPressed: null,
      tooltip: 'Transaction',
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      backgroundColor: blue,
      child: SvgPicture.asset(
        'assets/icons/transaction.svg',
        height: 24,
        width: 24,
        color: light,
      ),
    );
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: animate,
      elevation: 0,
      tooltip: 'Toggle',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
        color: light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: transaction(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: income(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: expense(),
        ),
        toggle(),
      ],
    );
  }
}
