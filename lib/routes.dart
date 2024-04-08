import 'package:flutter/material.dart';
import 'package:hello_flutter/widgets/icon.dart';
import 'package:hello_flutter/widgets/rich_text.dart';
import 'package:hello_flutter/widgets/selectable_text.dart';
import 'package:hello_flutter/widgets/text.dart';
import 'package:hello_flutter/wrap_page.dart';

import 'home_page.dart';

final Map<String, Map<String, WidgetBuilder>> routesMap = {
  'widgets': {
    'Text': (BuildContext context) => const WrapPage(title: '普通文本', child: TextDemo(),),
    'Icon': (BuildContext context) => const WrapPage( title: '内置图标',child: IconDemo(),),
    'SelectableText': (BuildContext context) => const WrapPage(title: '可选文本',child: SelectableTextDemo(),),
    'RichText': (BuildContext context) => const WrapPage(title: '富文本',child: RichTextDemo(),),
  },
};

Map<String, WidgetBuilder> getRoutes() {
  final Map<String, WidgetBuilder> routes = {};

  routesMap.forEach((category, values) {
    values.forEach((path, widgetBuilder) {
      routes['/$category/$path'] = widgetBuilder;
    });
  });
  return routes;
}

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => const HomePage(),
  ...getRoutes(),
};
