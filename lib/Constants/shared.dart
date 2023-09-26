import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Screens/AccountSetup/setup_account_screen.dart';
import 'package:montra/Screens/Home/home_screen.dart';

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
  const DoneScreen({
    super.key,
    required this.routeNo,
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
        Navigator.of(context).push(_doneRoute(routeNo: widget.routeNo));
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

Route _doneRoute({required int routeNo}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) =>
        routeNo == 0 ? const SetupAccountScreen() : const HomeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
