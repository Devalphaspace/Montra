import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:ui' as ui;

import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Screens/Profile/wallet_transactions_screen.dart';
import 'package:montra/Services/database_services.dart';

class AccountScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const AccountScreen({
    super.key,
    required this.user,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
          'Account',
          style: title3.copyWith(
            color: dark50,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: FutureBuilder<DocumentList?>(
              future: fetchWallets(userID: widget.user['userID']),
              builder: (walletContext, walletSnapshot) {
                log(walletSnapshot.connectionState.toString());
                if (walletSnapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: Get.height * 0.8,
                    width: Get.width,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: violet,
                      ),
                    ),
                  );
                } else if (walletSnapshot.connectionState ==
                        ConnectionState.done &&
                    walletSnapshot.data != null) {
                  List<Document> wallets = walletSnapshot.data!.documents;
                  double totalAmount = 0;
                  for (var element in walletSnapshot.data!.documents) {
                    totalAmount += element.data['walletAmount'];
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.3,
                          width: Get.width,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: Get.width * 0.025,
                                right: -Get.width * 0.1,
                                child: Container(
                                  width: Get.width * 0.3,
                                  height: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: violet,
                                    borderRadius:
                                        BorderRadius.circular(Get.width * 0.3),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: Get.width * 0.025,
                                left: -Get.width * 0.01,
                                child: Container(
                                  width: Get.width * 0.15,
                                  height: Get.width * 0.15,
                                  decoration: BoxDecoration(
                                    color: violet.withOpacity(0.75),
                                    borderRadius:
                                        BorderRadius.circular(Get.width * 0.3),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: Get.width * 0.15,
                                left: Get.width * 0.15,
                                child: Container(
                                  width: Get.width * 0.15,
                                  height: Get.width * 0.15,
                                  decoration: BoxDecoration(
                                    color: violet.withOpacity(0.5),
                                    borderRadius:
                                        BorderRadius.circular(Get.width * 0.3),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: Get.width * 0.1,
                                right: Get.width * 0.15,
                                child: Container(
                                  width: Get.width * 0.1,
                                  height: Get.width * 0.1,
                                  decoration: BoxDecoration(
                                    color: violet,
                                    borderRadius:
                                        BorderRadius.circular(Get.width * 0.3),
                                  ),
                                ),
                              ),
                              BackdropFilter(
                                  filter: ui.ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                    tileMode: TileMode.repeated,
                                  ),
                                  child: SizedBox(
                                    height: Get.height * 0.3,
                                    width: Get.width,
                                  )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Account Balance',
                                    style: body3.copyWith(
                                      color: light20,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '\$$totalAmount',
                                    style: GoogleFonts.inter(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: dark75,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        ListView.separated(
                          itemCount: wallets.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => WalletTransactionsScreen(
                                    walletName:
                                        wallets[index].data['walletName'],
                                    walletID: wallets[index].$id,
                                    walletBalance: wallets[index]
                                        .data['walletAmount']
                                        .toString(),
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
                                      color: const Color(0xFFF1F1FA),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Iconsax.wallet,
                                      color: violet,
                                      size: 36,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: Get.width * 0.45,
                                    ),
                                    child: Text(
                                      wallets[index].data['walletName'],
                                      style: title3.copyWith(
                                        color: dark25,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: Get.width * 0.25,
                                    ),
                                    child: Text(
                                      "\$${wallets[index].data['walletAmount']}",
                                      style: title3.copyWith(
                                        color: dark25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: light20.withOpacity(0.25),
                            height: 36,
                          ),
                        )
                      ],
                    ),
                  );
                } else if (walletSnapshot.hasError) {
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
              }),
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: Get.height * 0.1,
        color: Colors.transparent,
        padding: const EdgeInsets.all(16),
        child: PrimaryElevatedButton(
          onPressed: () {},
          buttonName: '+ Add new wallet',
        ),
      ),
    );
  }
}
