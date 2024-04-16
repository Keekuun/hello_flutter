import 'package:flutter/material.dart';
import 'lists/grid.dart';
import 'layouts/row.dart';
import 'states/blocs/cubit_counter/counter_page.dart';
import 'contents/button.dart';
import 'contents/form.dart';
import 'contents/icon.dart';
import 'contents/image.dart';
import 'contents/rich_text.dart';
import 'contents/selectable_text.dart';
import 'contents/text.dart';
import 'contents/text_field.dart';
import 'contents/wrap.dart';
import 'layouts/column.dart';
import 'layouts/container.dart';
import 'states/blocs/bloc_counter/counter_page.dart';
import 'wrap_page.dart';

import 'home_page.dart';

final List<Map<String, Object>> routesList = [
  {
    'id': 'Contents',
    'title': '内容组件',
    'icon': const Icon(Icons.widgets_rounded),
    'children': [
      MyWidget(
          id: 'Text',
          title: 'Text普通文本',
          description: 'Text-普通文本',
          widget: const TextDemo()),
      MyWidget(
          id: 'Icon',
          title: 'Icon内置图标',
          description: 'Icon-内置图标',
          widget: const IconDemo()),
      MyWidget(
          id: 'Button',
          title: 'Button按钮',
          description: 'Button-按钮',
          widget: const ButtonDemo()),
      MyWidget(
          id: 'Image',
          title: 'Image图片',
          description: 'Image-图片展示',
          widget: const ImageDemo()),
      MyWidget(
          id: 'SelectableText',
          title: 'SelectableText可选文本',
          description: 'SelectableText-可选文本',
          widget: const SelectableTextDemo()),
      MyWidget(
          id: 'RichText',
          title: 'RichText富文本',
          description: 'RichText-富文本',
          widget: const RichTextDemo()),
      MyWidget(
          id: 'TextField',
          title: 'TextField输入框',
          description: 'TextField-普通输入框',
          widget: const TextFieldDemo()),
      MyWidget(
          id: 'Form',
          title: 'Form表单',
          description: 'Form表单-表单文本输入框',
          widget: const FormDemo()),
    ]
  },
  {
    'id': 'Layouts',
    'title': '布局组件',
    'icon': const Icon(Icons.layers_rounded),
    'children': [
      MyWidget(
          id: 'Wrap',
          title: 'Wrap组件',
          description: 'Wrap组件-自动换行',
          widget: const WrapDemo()),
      MyWidget(
          id: 'Container',
          title: 'Container容器',
          description: 'Container容器-默认撑满屏幕',
          widget: const ContainerDemo()),
      MyWidget(
          id: 'Row',
          title: 'Row容器',
          description: 'Row容器组件-水平布局',
          widget: const RowDemo()),
      MyWidget(
          id: 'Column',
          title: 'Column容器',
          description: 'Column组件-垂直布局',
          widget: const ColumnDemo()),
    ],
  },
  {
    'id': 'Lists',
    'title': '列表组件',
    'icon': const Icon(Icons.list_alt_rounded),
    'children': [
      MyWidget(
          id: 'GridList',
          title: 'GridList列表',
          description: 'GridList-网格列表',
          widget: const GridDemo()),
    ],
  },
  {
    'id': 'States',
    'title': '状态管理',
    'icon': const Icon(Icons.recycling_rounded),
    'children': [
      MyWidget(
          id: 'Bloc-Cubit',
          title: 'Bloc-Cubit状态管理',
          description: 'Bloc-Cubit状态管理',
          widget: const CounterCubitPage()),
      MyWidget(
          id: 'Bloc',
          title: 'Bloc状态管理',
          description: 'Bloc状态管理',
          widget: const CounterBlocPage()),
    ],
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
