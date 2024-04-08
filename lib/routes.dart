import 'package:flutter/material.dart';
import 'package:hello_flutter/widgets/icon.dart';
import 'package:hello_flutter/widgets/selectable_text.dart';
import 'package:hello_flutter/widgets/text.dart';
import 'package:hello_flutter/wrap_page.dart';

import 'home_page.dart';

final Map<String, Map<String, WidgetBuilder>> routesMap = {
  'widgets': {
    'Text': (BuildContext context) => const WrapPage(title: '普通文本', child: TextDemo(),),
    'SelectableText': (BuildContext context) => const WrapPage(title: '可选文本', child: SelectableTextDemo(),),
    'Icon': (BuildContext context) => const WrapPage(title: '内置图标', child: IconDemo(),),
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
