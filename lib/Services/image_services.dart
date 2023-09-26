import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future getFromGallery() async {
  try {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    final imageTemp = File(pickedImage.path);

    return imageTemp;
  } on PlatformException catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(),
    );
    log('Something went wrong! Reason: $e');
  }
}

Future getFromCamera() async {
  try {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage == null) return;

    final imageTemp = File(pickedImage.path);

    return imageTemp;
  } on PlatformException catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(),
    );
    log('Something went wrong! Reason: $e');
  }
}
