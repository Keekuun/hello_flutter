import 'package:flutter/material.dart';

class RecordingMaskOverlayData {
  double sendAreaHeight = 173;

  final double iconSize;

  final double iconFocusSize;

  // final EdgeInsets soundsMargin;

  final Color iconColor;

  final Color iconFocusColor;

  final Color iconTxtColor;

  final Color iconFocusTxtColor;

  TextStyle maskTxtStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0x8CFFFFFF),
  );

  RecordingMaskOverlayData({
    this.iconSize = 68,
    this.iconFocusSize = 80,
    this.iconColor = const Color(0xff393939),
    this.iconFocusColor = const Color(0xffffffff),
    this.iconTxtColor = const Color(0xff909090),
    this.iconFocusTxtColor = const Color(0xff000000),
  });
}
