import 'dart:developer';

import 'package:flutter/material.dart';

SnackBar showSnackBar(String message, String acceptMessage) {
  return SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: acceptMessage,
      onPressed: () {
        log('close snackbar');
      },
    ),
  );
}

// de su dung snack_bar thi su dng scaffoldMessenger.of(context).showSnackBar()...

// ScaffoldMessenger.of(context).showSnackBar(
//                 showSnackBar('You\'ve clicked on No Button', 'Confirm'));