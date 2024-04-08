import 'package:flutter/material.dart';
import 'package:hello_flutter/contents/icon.dart';
import 'package:hello_flutter/contents/rich_text.dart';
import 'package:hello_flutter/contents/selectable_text.dart';
import 'package:hello_flutter/contents/text.dart';
import 'package:hello_flutter/layouts/container.dart';
import 'package:hello_flutter/wrap_page.dart';

import 'home_page.dart';

final List<Map<String, Object>> routesList = [
  {
    'id': 'Contents',
    'title': '内容组件',
    'icon': const Icon(Icons.widgets_rounded),
    'children': [
      MyWidget(
          id: 'Text',
          title: '普通文本',
          description: '普通文本',
          widget: const TextDemo()),
      MyWidget(
          id: 'Icon',
          title: '内置图标',
          description: '内置图标',
          widget: const IconDemo()),
      MyWidget(
          id: 'SelectableText',
          title: '可选文本',
          description: '可选文本',
          widget: const SelectableTextDemo()),
      MyWidget(
          id: 'RichText',
          title: '富文本',
          description: '富文本',
          widget: const RichTextDemo()),
    ]
  },
  {
    'id': 'Layouts',
    'title': '布局组件',
    'icon': const Icon(Icons.layers_rounded),
    'children': [
      MyWidget(
          id: 'Container',
          title: '容器组件',
          description: '容器组件',
          widget: const ContainerDemo()),
    ],
  },
  {
    'id': 'Lists',
    'title': '列表组件',
    'icon': const Icon(Icons.list_alt_rounded),
    'children': [],
  }
];

class MyWidget {
  final String id;
  final String title; // 标题
  final String? description; // 描述
  final Widget widget; // 组件
  late final WidgetBuilder child; // 子组件

  MyWidget({
    required this.id,
    required this.title,
    this.description = '',
    required this.widget,
  }) {
    child = (BuildContext context) => WrapPage(
          title: title,
          child: widget,
        );
  }
}

Map<String, WidgetBuilder> _getRoutes() {
  final Map<String, WidgetBuilder> routes = {};

  for (var d in routesList) {
    final String category = d['id']! as String;
    final List children = d['children']! as List;

    for (var dd in children) {
      routes['/$category/${dd.id}'] = dd.child as WidgetBuilder;
    }
  }
  return routes;
}

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => const HomePage(),
  ..._getRoutes(),
};
