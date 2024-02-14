import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Screens/AccountSetup/setup_account_screen.dart';
import 'package:montra/Screens/PageNavigator/page_navigator.dart';

class PrimaryElevatedButton extends StatefulWidget {
  final Function()? onPressed;
  final String buttonName;
  const PrimaryElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  State<PrimaryElevatedButton> createState() => _PrimaryElevatedButtonState();
}

class _PrimaryElevatedButtonState extends State<PrimaryElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(Get.width, 56),
        backgroundColor: violet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        widget.buttonName,
        style: title3.copyWith(color: light80),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomTextButton extends StatefulWidget {
  final String buttonName;
  final double buttonMinWidth;
  final double buttonMinHeight;
  final Function()? onPressed;
  bool isActive;
  CustomTextButton({
    super.key,
    required this.buttonName,
    required this.buttonMinWidth,
    required this.buttonMinHeight,
    required this.onPressed,
    required this.isActive,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(widget.buttonMinWidth, widget.buttonMinHeight),
        backgroundColor: widget.isActive ? violet20 : Colors.transparent,
        side: BorderSide(
          color: widget.isActive ? Colors.transparent : light40,
          width: widget.isActive ? 0 : 1,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 0,
        ),
      ),
      child: Text(
        widget.buttonName,
        style: body3.copyWith(
          color: widget.isActive ? violet : dark,
        ),
      ),
    );
  }
}

class PrimaryChildWidgetElevatedButton extends StatefulWidget {
  final Function()? onPressed;
  final Widget buttonWidget;
  const PrimaryChildWidgetElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonWidget,
  });

  @override
  State<PrimaryChildWidgetElevatedButton> createState() =>
      _PrimaryChildWidgetElevatedButtonState();
}

class _PrimaryChildWidgetElevatedButtonState
    extends State<PrimaryChildWidgetElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(Get.width, 56),
        backgroundColor: violet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: widget.buttonWidget,
    );
  }
}

class PrimaryElevatedIconButton extends StatefulWidget {
  final Function()? onPressed;
  final String buttonName;
  final String iconString;
  const PrimaryElevatedIconButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
    required this.iconString,
  });

  @override
  State<PrimaryElevatedIconButton> createState() =>
      _PrimaryElevatedIconButtonState();
}

class _PrimaryElevatedIconButtonState extends State<PrimaryElevatedIconButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(Get.width, 56),
        backgroundColor: violet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(widget.iconString),
          const SizedBox(width: 12),
          Text(
            widget.buttonName,
            style: title3.copyWith(color: light80),
          ),
        ],
      ),
    );
  }
}

class SecondaryElevatedButton extends StatefulWidget {
  final Function()? onPressed;
  final String buttonName;
  const SecondaryElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  State<SecondaryElevatedButton> createState() =>
      _SecondaryElevatedButtonState();
}

class _SecondaryElevatedButtonState extends State<SecondaryElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(Get.width, 56),
        backgroundColor: violet20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        widget.buttonName,
        style: title3.copyWith(color: violet),
      ),
    );
  }
}

class CustomOutlinedButton extends StatefulWidget {
  final Function() onPressed;
  final String iconString;
  final String buttonName;
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.iconString,
    required this.buttonName,
  });

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(Get.width, 56),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: light20,
              width: 1,
            )),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(widget.iconString),
          const SizedBox(width: 12),
          Text(
            widget.buttonName,
            style: title3.copyWith(color: dark50),
          ),
        ],
      ),
    );
  }
}

class CustomSquareOutlinedButton extends StatefulWidget {
  final Function() onPressed;
  final IconData iconData;
  final String buttonName;
  final double? size;
  const CustomSquareOutlinedButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    required this.buttonName,
    this.size,
  });

  @override
  State<CustomSquareOutlinedButton> createState() =>
      _CustomSquareOutlinedButtonState();
}

class _CustomSquareOutlinedButtonState
    extends State<CustomSquareOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          widget.size != null ? widget.size! : Get.width * 0.3,
          widget.size != null ? widget.size! : Get.width * 0.3,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: light20,
              width: 1,
            )),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            widget.iconData,
            color: dark50,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            widget.buttonName,
            style: title3.copyWith(color: dark50),
          ),
        ],
      ),
    );
  }
}

class DashedBorderButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonName;
  const DashedBorderButton({
    super.key,
    required this.buttonName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [8, 8],
        radius: const Radius.circular(16),
        color: light20,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -45,
              child: Icon(
                Icons.attachment_rounded,
                color: light20,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              buttonName,
              style: title3.copyWith(color: light20),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryTextFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String fieldName;
  final bool isObscure;
  final String? Function(String?)? validator;
  final Color labelColor;
  final TextStyle errorTextStyle;
  const PrimaryTextFormField({
    super.key,
    required this.textEditingController,
    required this.fieldName,
    required this.isObscure,
    required this.validator,
    this.labelColor = const Color(0xFF91919F),
    this.errorTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
  });

  @override
  State<PrimaryTextFormField> createState() => _PrimaryTextFormFieldState();
}

class _PrimaryTextFormFieldState extends State<PrimaryTextFormField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: isObscure,
      validator: widget.validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: light60,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: light60,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1.5,
            color: violet60,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1.5,
            color: violet60,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: red,
          ),
        ),
        labelText: widget.fieldName,
        labelStyle: body1.copyWith(
          color: widget.labelColor,
        ),
        errorStyle: widget.errorTextStyle,
        suffixIcon: widget.isObscure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  Icons.visibility_outlined,
                  color: light20,
                  size: 24,
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ),
    );
  }
}

class NumericTextFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final Color labelColor;
  final TextStyle errorTextStyle;
  const NumericTextFormField({
    super.key,
    required this.textEditingController,
    required this.validator,
    this.labelColor = const Color(0xFF91919F),
    this.errorTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
  });

  @override
  State<NumericTextFormField> createState() => _NumericTextFormFieldState();
}

class _NumericTextFormFieldState extends State<NumericTextFormField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: isObscure,
      validator: widget.validator,
      style: title1.copyWith(
        color: light,
        fontSize: 64,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: true,
      ),
      decoration: InputDecoration(
        hintText: '00',
        hintStyle: title1.copyWith(
          color: light,
          fontSize: 64,
        ),
        contentPadding: const EdgeInsets.all(0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        errorStyle: widget.errorTextStyle,
        prefixIcon: Icon(
          Icons.currency_rupee_rounded,
          color: light,
          size: 36,
        ),
      ),
    );
  }
}

primaryFlutterToast({required String msg}) {
  return Fluttertoast.showToast(
    msg: msg,
    timeInSecForIosWeb: 3,
    backgroundColor: dark,
    textColor: light,
  );
}

class DoneScreen extends StatefulWidget {
  final int routeNo;
  final String userID;
  final String sessionID;
  const DoneScreen({
    super.key,
    required this.routeNo,
    required this.userID,
    required this.sessionID,
  });

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).push(_doneRoute(
            routeNo: widget.routeNo,
            userID: widget.userID,
            sessionID: widget.sessionID));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: violet,
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: LottieBuilder.asset(
          'assets/json/done.json',
        ),
      ),
    );
  }
}

Route _doneRoute({
  required int routeNo,
  required String userID,
  required String sessionID,
}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) =>
        // IF ROUTE NUMBER IS NOT 0 PASS THE USERID
        routeNo == 0
            ? SetupAccountScreen(
                userID: userID,
                sessionID: sessionID,
              )
            : PageNavigator(
                userID: userID,
                sessionID: sessionID,
              ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class TransactionCards extends StatelessWidget {
  final IconData transactionCardIcon;
  final String transactionCardName;
  final String transactionCardDesc;
  final String transactionCardAmount;
  final DateTime transactionCardTime;
  const TransactionCards({
    super.key,
    required this.transactionCardIcon,
    required this.transactionCardName,
    required this.transactionCardDesc,
    required this.transactionCardAmount,
    required this.transactionCardTime,
  });

  @override
  Widget build(BuildContext context) {
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
              transactionCardIcon,
              color: yellow,
              size: 36,
            ),
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.4,
                  child: Text(
                    transactionCardName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: dark25,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.4,
                  child: Text(
                    transactionCardDesc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '-\$$transactionCardAmount',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: red,
                  ),
                ),
                Text(
                  DateFormat("hh:mm a").format(transactionCardTime).toString(),
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
  }
}

// ignore: must_be_immutable
class PrimarySwitch extends StatefulWidget {
  bool switchState;
  PrimarySwitch({
    super.key,
    required this.switchState,
  });

  @override
  State<PrimarySwitch> createState() => _PrimarySwitchState();
}

class _PrimarySwitchState extends State<PrimarySwitch> {
  bool switchSt = false;

  @override
  void initState() {
    super.initState();
    switchSt = widget.switchState;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: switchSt,
      activeColor: light80,
      activeTrackColor: violet,
      inactiveThumbColor: light,
      inactiveTrackColor: violet20,
      onChanged: (bool value) {
        setState(() {
          switchSt = value;
        });
      },
    );
  }
}
