import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Services/database_services.dart';

class WalletTransactionsScreen extends StatefulWidget {
  final String walletName;
  final String walletID;
  final String walletBalance;
  const WalletTransactionsScreen({
    super.key,
    required this.walletName,
    required this.walletID,
    required this.walletBalance,
  });

  @override
  State<WalletTransactionsScreen> createState() =>
      _WalletTransactionsScreenState();
}

class _WalletTransactionsScreenState extends State<WalletTransactionsScreen> {
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
          'Detailed account',
          style: title3.copyWith(
            color: dark50,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.pen_add,
              color: dark50,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.3,
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(height: 8),
                      Text(
                        widget.walletName,
                        style: title3.copyWith(
                          color: dark25,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${widget.walletBalance}',
                        style: title3.copyWith(
                          color: dark25,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Today',
                  style: title3.copyWith(
                    color: dark25,
                  ),
                ),
                const SizedBox(height: 8),
                FutureBuilder<DocumentList?>(
                  future:
                      fetchTransactionsWithWalletID(walletID: widget.walletID),
                  builder: (transactionContext, transactionSnapshot) {
                    if (transactionSnapshot.connectionState ==
                            ConnectionState.waiting ||
                        transactionSnapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: violet,
                        ),
                      );
                    } else if (transactionSnapshot.connectionState ==
                            ConnectionState.done ||
                        transactionSnapshot.data != null) {
                      List<Document> transactions = transactionSnapshot.data!.documents;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        itemBuilder: (context, transactionIndex) {
                          return TransactionCards(
                            transactionCardIcon: Iconsax.shopping_bag,
                            transactionCardName: transactions[transactionIndex].data['category'].toString(),
                            transactionCardDesc: transactions[transactionIndex].data['transactionDescription'].toString(),
                            transactionCardAmount: transactions[transactionIndex].data['amount'].toString(),
                            transactionCardTime: DateTime.parse(transactions[transactionIndex].data['datetime']),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: violet,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
