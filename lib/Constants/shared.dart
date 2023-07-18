
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:montra/Constants/constants.dart';

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



class PrimaryTextFormField extends StatefulWidget {
  final TextEditingController nameController;
  final String fieldName;
  final bool isObscure;
  String? Function(String?)? validator;
  PrimaryTextFormField({
    super.key,
    required this.nameController,
    required this.fieldName,
    required this.isObscure,
    required this.validator,
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
      controller: widget.nameController,
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
          labelStyle: body1,
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
                )),
    );
  }
}

