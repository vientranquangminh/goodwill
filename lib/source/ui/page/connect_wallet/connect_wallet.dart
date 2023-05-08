import 'package:flutter/material.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/routes.dart';

class ConnectWallet extends StatelessWidget {
  const ConnectWallet({super.key});

  @override
  Widget build(BuildContext context) {
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
            "Connect Wallet",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Assets.svgs.moreCircle.svg(color: Colors.black),
            ),
          ]),
      body: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/wallet/momo.jpg')),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.localizations.connectToMoMoWallet,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    context.localizations
                        .afterSuccessfulWalletLinkingYourListingWillAllowBuyersToPayOnlineForYourProductViaGoodwill,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/wallet/unnamed.jpg',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              context.localizations.moMo,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        PrimaryButton(
                          text: context.localizations.connect,
                          customFunction: () {
                            context
                                .pushNamed(Routes.connectWalletUsePhoneNumber);
                          },
                          textColor: Colors.white,
                          buttonColor: Colors.black,
                          fontSize: 14,
                          radius: 16,
                        )
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "${context.localizations.note}:",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    children: [
                      TextSpan(
                        text: context.localizations
                            .youOnlyGetPaidWhenYouHaveVerifiedEnoughInformation,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
