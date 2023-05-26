import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:intl/intl.dart';

class StatusPayment extends StatelessWidget {
  const StatusPayment({
    super.key,
    this.amountPaid = 0,
    this.owner = "Turle",
    required this.status,
    this.image = 'assets/images/payment_successful.png',
    required this.callback,
    required this.textButton,
    required this.productOwner,
  });
  final int amountPaid;
  final String owner;
  final String status;
  final String productOwner;
  final String image;
  final VoidCallback callback;
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Assets.svgs.mainIcon.svg(),
        elevation: 0.0,
        title: Text(
          context.localizations.paymentConfirmation,
          style: const TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
          child: Center(
            child: Column(
              children: [
                Image.asset(image),
                Text(
                  status,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "${context.localizations.amountPaid}: ${NumberFormat('#,##0').format(amountPaid)} ${Constant.VN_CURRENCY}",
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  '${context.localizations.paidFor}: $productOwner',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  '${context.localizations.paidBy}: $owner',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 50,
                  child: PrimaryButton(
                    customFunction: callback,
                    text: textButton,
                    textColor: Colors.white,
                    fontSize: 16,
                    buttonColor: Colors.black,
                    radius: 24,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
