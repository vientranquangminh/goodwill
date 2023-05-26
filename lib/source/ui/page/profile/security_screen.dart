import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/ui/page/profile/dummy/security.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.localizations.security,
        leading: IconButton(
            onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(children: [
        SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: listSecurity.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      listSecurity[index].title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    FlutterSwitch(
                        padding: 1,
                        width: 35.0,
                        height: 17.0,
                        toggleSize: 16.5,
                        activeColor: Colors.blue.shade600,
                        value: listSecurity[index].status,
                        onToggle: (val) {
                          setState(() {
                            listSecurity[index].status = val;
                          });
                        }),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 25),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Google Authenticator',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
            margin: const EdgeInsets.all(10),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: PrimaryButton(
              text: 'Change Pin',
              buttonColor: ColorName.black,
              fontSize: 16,
              textColor: ColorName.white,
              customFunction: (() {
                log('Change pin');
              }),
            )),
        Container(
            margin: const EdgeInsets.all(10),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: PrimaryButton(
              text: 'Change password',
              buttonColor: ColorName.black,
              fontSize: 16,
              textColor: ColorName.white,
              customFunction: (() {
                log('Change password');
              }),
            )),
      ]),
    );
  }
}
