import 'package:flutter/material.dart';

void goBack(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    Navigator.pushReplacementNamed(context, '/');
  }
}

bool isMarkdown(String text) {
  RegExp regExp = RegExp(
      r'^(#{1,6} )|(\*\*|\_\_|\*|_)|(https?:\/\/[\w.\/-]+)|(-|\+|\d+\.)|\|\s+[-:]+\s+\||(`{1,3})',
      multiLine: true);
  return regExp.hasMatch(text);
}
