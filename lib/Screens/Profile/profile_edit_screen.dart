import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Screens/PageNavigator/page_navigator.dart';
import 'package:montra/Services/database_services.dart';
import 'package:montra/Services/image_services.dart';
import 'package:montra/Services/storage_services.dart';
import 'package:montra/git_ignore.dart';
import 'package:path/path.dart' as p;

class ProfileEditScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final String svgCode;
  final String sessionID;
  const ProfileEditScreen({
    super.key,
    required this.user,
    required this.svgCode,
    required this.sessionID,
  });

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  io.File? image;

  @override
  void initState() {
    _nameController.text = widget.user['name'];
    _phoneController.text = widget.user['phoneNumber'];
    super.initState();
  }

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
          'Edit Profile',
          style: title3.copyWith(
            color: dark50,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.only(
                top: 36,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: Get.width * 0.3,
                    width: Get.width * 0.3,
                    margin: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: violet,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(Get.width * 0.3),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(56),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: Get.width * 0.3,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Get.width * 0.3),
                              ),
                              child: image == null
                                  ? widget.user['profilePictureFileID'] != null
                                      ? FutureBuilder(
                                          future: storage.getFileView(
                                            bucketId: profilePictureBucketID,
                                            fileId: widget.user['userID'],
                                          ),
                                          builder: (profilePiccontext,
                                              profilePicsnapshot) {
                                            log(profilePicsnapshot
                                                .connectionState
                                                .toString());
                                            if (profilePicsnapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: violet,
                                                ),
                                              );
                                            } else if (profilePicsnapshot
                                                        .connectionState ==
                                                    ConnectionState.done &&
                                                profilePicsnapshot.data !=
                                                    null) {
                                              return Image.memory(
                                                profilePicsnapshot.data!,
                                                fit: BoxFit.cover,
                                              );
                                            } else {
                                              return SvgPicture.string(
                                                widget.svgCode,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                          })
                                      : SvgPicture.string(
                                          widget.svgCode,
                                          fit: BoxFit.cover,
                                        )
                                  : Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: Get.height * 0.3,
                                      width: Get.width,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomSquareOutlinedButton(
                                            onPressed: () async {
                                              Get.back();
                                              image = await getFromCamera();
                                              setState(() {});
                                            },
                                            iconData: Iconsax.camera,
                                            buttonName: 'Camera',
                                            size: Get.width * 0.4,
                                          ),
                                          CustomSquareOutlinedButton(
                                            onPressed: () async {
                                              Get.back();
                                              image = await getFromGallery();
                                              setState(() {});
                                            },
                                            iconData: Iconsax.gallery,
                                            buttonName: 'Gallery',
                                            size: Get.width * 0.4,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: Get.width * 0.1,
                                width: Get.width * 0.3,
                                decoration: BoxDecoration(
                                  color: violet.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        Radius.circular(Get.width * 0.3),
                                    bottomRight:
                                        Radius.circular(Get.width * 0.3),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'EDIT',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 3,
                                    color: light,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.user['email'],
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      color: dark75,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 36),
                  PrimaryTextFormField(
                    textEditingController: _nameController,
                    fieldName: 'Name',
                    isObscure: false,
                    validator: (name) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 36),
                  PrimaryTextFormField(
                    textEditingController: _phoneController,
                    fieldName: 'Phone Number',
                    isObscure: false,
                    validator: (name) {
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.1,
        color: Colors.transparent,
        padding: const EdgeInsets.all(16),
        child: PrimaryElevatedButton(
          onPressed: () async {
            if (image != null) {
              if (widget.user['profilePictureFileID'] != null) {
                log('Updated profile and updated profile image');
                deleteFile(
                  bucketID: profilePictureBucketID,
                  fileID: widget.user['userID'],
                ).then((value) {
                  createFile(
                    bucketID: profilePictureBucketID,
                    fileID: widget.user['userID'],
                    userID: widget.user['userID'],
                    filePath: image!.path,
                    extension: p.extension(image!.path),
                  ).then((response) {
                    Map<String, dynamic> userData = {
                      "name": _nameController.text,
                      "phoneNumber": _phoneController.text,
                      "profilePictureFileID": widget.user['userID'],
                    };
                    updateProfile(
                      documentID: widget.user['userID'],
                      data: userData,
                    ).then((value) {
                      Get.offAll(
                        () => PageNavigator(
                          userID: widget.user['userID'],
                          sessionID: widget.sessionID,
                        ),
                      );
                    });
                  });
                });
              } else {
                log('Updated profile and created new profile picture');
                createFile(
                  bucketID: profilePictureBucketID,
                  fileID: widget.user['userID'],
                  userID: widget.user['userID'],
                  filePath: image!.path,
                  extension: p.extension(image!.path),
                ).then((response) {
                  Map<String, dynamic> userData = {
                    "name": _nameController.text,
                    "phoneNumber": _phoneController.text,
                    "profilePictureFileID": widget.user['userID'],
                  };
                  updateProfile(
                    documentID: widget.user['userID'],
                    data: userData,
                  ).then((value) {
                    Get.offAll(
                      () => PageNavigator(
                        userID: widget.user['userID'],
                        sessionID: widget.sessionID,
                      ),
                    );
                  });
                });
              }
            } else {
              log('Updated profile without profile image');
              Map<String, dynamic> userData = {
                "name": _nameController.text,
                "phoneNumber": _phoneController.text,
              };
              updateProfile(
                documentID: widget.user['userID'],
                data: userData,
              ).then((value) {
                Get.offAll(
                  () => PageNavigator(
                    userID: widget.user['userID'],
                    sessionID: widget.sessionID,
                  ),
                );
              });
            }
          },
          buttonName: 'Update',
        ),
      ),
    );
  }
}
