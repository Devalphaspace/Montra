import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Controller/session_controller.dart';
import 'package:montra/Screens/AuthScreen/login_screen.dart';
import 'package:montra/Screens/Profile/account_screen.dart';
import 'package:montra/Screens/Profile/profile_edit_screen.dart';
import 'package:montra/Services/auth.dart';
import 'package:montra/Services/database_services.dart';
import 'package:montra/Services/storage_services.dart';
import 'package:montra/git_ignore.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfileScreen extends StatefulWidget {
  final String userID;
  final String sessionID;
  const ProfileScreen({
    super.key,
    required this.userID,
    required this.sessionID,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SessionController _sessionController = Get.put(SessionController());
  String svgCode = RandomAvatarString('saytoonz', trBackground: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder<DocumentList?>(
            future: fetchProfile(userID: widget.userID),
            builder: (profileContext, profileSnapshot) {
              if (profileSnapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: Get.height * 0.8,
                  width: Get.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: violet,
                    ),
                  ),
                );
              } else if (profileSnapshot.connectionState ==
                      ConnectionState.done &&
                  profileSnapshot.data != null) {
                Map<String, dynamic> userData =
                    profileSnapshot.data!.documents[0].data;

                return Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: Get.width * 0.25,
                            width: Get.width * 0.25,
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
                              child: userData['profilePictureFileID'] != null
                                  ? FutureBuilder(
                                      future: storage.getFileView(
                                        bucketId: profilePictureBucketID,
                                        fileId: userData['userID'],
                                      ),
                                      builder: (profilePiccontext,
                                          profilePicsnapshot) {
                                        log(profilePicsnapshot.connectionState
                                            .toString());
                                        if (profilePicsnapshot
                                                .connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: violet,
                                            ),
                                          );
                                        } else if (profilePicsnapshot
                                                    .connectionState ==
                                                ConnectionState.done &&
                                            profilePicsnapshot.data != null) {
                                          return Image.memory(
                                            profilePicsnapshot.data!,
                                            fit: BoxFit.cover,
                                          );
                                        } else {
                                          return SvgPicture.string(
                                            svgCode,
                                            fit: BoxFit.cover,
                                          );
                                        }
                                      })
                                  : SvgPicture.string(
                                      svgCode,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: Get.width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Username',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: light20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  userData['name'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    color: dark75,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Get.to(
                                () => ProfileEditScreen(
                                  user: userData,
                                  svgCode: svgCode,
                                  sessionID: widget.sessionID,
                                ),
                              );
                            },
                            icon: Icon(
                              Iconsax.pen_add,
                              color: dark50,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: dark.withOpacity(0.10),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => AccountScreen(
                                    user: userData,
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: violet20,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Iconsax.wallet,
                                      color: violet,
                                      size: 36,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Account",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: dark25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: light20.withOpacity(0.25),
                              height: 36,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: violet20,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Iconsax.setting,
                                      color: violet,
                                      size: 36,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Settings",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: dark25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: light20.withOpacity(0.25),
                              height: 36,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: violet20,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Iconsax.export,
                                      color: violet,
                                      size: 36,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Export Data",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: dark25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: light20.withOpacity(0.25),
                              height: 36,
                            ),
                            InkWell(
                              onTap: () async {
                                final bool isLoggedOut =
                                    await signOut(sessionID: widget.sessionID);
                                if (isLoggedOut) {
                                  _sessionController
                                      .deleteSessionID()
                                      .then((value) {
                                    setState(() {
                                      Get.offAll(
                                        () => const LoginScreen(),
                                      );
                                    });
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: red20,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Iconsax.logout,
                                      color: red,
                                      size: 36,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Logout",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: dark25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (profileSnapshot.hasError) {
                return SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Center(
                    child: Text(
                      'Something went wrong from ourside!',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: dark75,
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: Get.height * 0.8,
                  width: Get.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: violet,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
