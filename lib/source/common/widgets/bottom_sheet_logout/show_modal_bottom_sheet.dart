import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:goodwill/source/common/widgets/bottom_sheet_logout/my_custom_bottom_sheet.dart';
import 'package:goodwill/source/common/widgets/snack_bar/snack_bar.dart';

void showModelBottomSheetFunction(BuildContext context, double radius) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return CustomBottomSheet(
          bottomSheetHeight: 250,
          title: 'Logout',
          content: const Text('Logout?'),
          negativeButtonText: 'No',
          positiveButtonText: 'Yes',
          negativeButtonFunction: () {
            Navigator.pop(context);
            log('NO');
            ScaffoldMessenger.of(context).showSnackBar(
                showSnackBar('You\'ve clicked on No Button', 'Confirm'));
          },
          positiveButtonFunction: () {
            Navigator.pop(context);
            log('YES');
            ScaffoldMessenger.of(context).showSnackBar(
                showSnackBar('You\'ve clicked on Yes Button', 'Confirm'));
          },
        );
      });
}
