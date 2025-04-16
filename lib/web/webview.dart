import 'package:flutter/material.dart';
import 'package:hello_flutter/web/web_view_page.dart';

class WebViewDemo extends StatelessWidget {
  const WebViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const WebViewPage(
      url: 'https://www.yydsok.com/',
    );
  }
}
