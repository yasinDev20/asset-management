import 'package:flutter/material.dart';

enum ResponsiveDevice { mobile, tablet, desktop }

ResponsiveDevice getDevicesize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  if (width >= 1024) return ResponsiveDevice.desktop;
  if (width >= 600) return ResponsiveDevice.tablet;
  return ResponsiveDevice.mobile;
}