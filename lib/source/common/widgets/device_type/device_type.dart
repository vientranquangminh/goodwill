import 'package:flutter/material.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  final Orientation orientation = mediaQuery.orientation;
  double deviceWidth = 0;
  if (orientation == Orientation.landscape) {
    deviceWidth = mediaQuery.size.height;
  } else {
    deviceWidth = mediaQuery.size.width;
  }
  if (deviceWidth > 950) {
    return DeviceScreenType.desktop;
  }
  if (deviceWidth > 600) {
    return DeviceScreenType.tablet;
  }
  return DeviceScreenType.mobile;
}

enum DeviceScreenType { mobile, tablet, desktop }

