import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';
import 'package:goodwill/source/ui/page/profile/dummy/notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: ColorName.white,
        title: context.localizations.notification,
        leading: IconButton(
            onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listNotification[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  FlutterSwitch(
                      padding: 1,
                      width: 35.0,
                      height: 17.0,
                      toggleSize: 16.5,
                      activeColor: ColorName.black,
                      value: listNotification[index].status,
                      onToggle: (val) {
                        setState(() {
                          listNotification[index].status = val;
                        });
                      }),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: listNotification.length),
      ),
    );
  }
}
