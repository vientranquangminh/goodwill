import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:intl/intl.dart';

class StatusPayment extends StatelessWidget {
  const StatusPayment(
      {super.key,
      this.amountPaid = 0,
      this.owner = "Turle",
      this.status = 'Payment Successful',
      this.image = 'assets/images/payment_successful.png'});
  final int amountPaid;
  final String owner;
  final String status;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          context.localizations.paymentConfirmation,
          style: const TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: Padding(
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
                context.localizations.amountPaid +
                    "${NumberFormat('#,##0').format(amountPaid)} ${Constant.VN_CURRENCY}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                'Paid By: $owner',
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 50,
                child: PrimaryButton(
                  customFunction: () {
                    context.pushNamed(Routes.myPageController);
                  },
                  text: context.localizations.backToHome,
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
    );
  }
}
