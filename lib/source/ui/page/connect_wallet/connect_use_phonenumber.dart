import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/ui/page/profile/widgets/edit_profile_widgets/textfield_custom.dart';

class ConnectWalletUsePhoneNumber extends StatelessWidget {
  const ConnectWalletUsePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _phoneNumberController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          "Connect Use Phone Number",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/wallet/unnamed.jpg',
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Enter the phone number you used to register your MoMo account',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            TextFieldCustom(
              suffixIcon: const Icon(Icons.phone_android),
              hint: context.localizations.phoneNumber,
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return context.localizations.plsEnterYourPhone;
                } else if (value!.length > 10 ||
                    value[0] != '0' ||
                    value.length < 10) {
                  return context.localizations.plsEnterValid;
                } else if (value[0] == '0' && value[1] == '0') {
                  return context.localizations.plsEnterValid;
                } else {
                  return null;
                }
              },
            ),
            Container(
              margin: const EdgeInsets.all(16),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: PrimaryButton(
                text: 'Connect',
                customFunction: () {},
                textColor: Colors.white,
                buttonColor: Colors.black,
                fontSize: 14,
                radius: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
