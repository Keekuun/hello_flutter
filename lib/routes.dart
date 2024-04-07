import 'package:flutter/material.dart';
import 'package:hello_flutter/widgets/icon.dart';
import 'package:hello_flutter/wrap_page.dart';

import 'home_page.dart';

final Map<String, Map<String, WidgetBuilder>> routesMap = {
  'widgets': {
    'icon': (BuildContext context) => const WrapPage(
      title: 'icon',
      description: 'icon',
      child: IconDemo(),
    ),
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
