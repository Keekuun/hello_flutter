import 'package:flutter/material.dart';
import 'package:hello_flutter/navigator/pageview.dart';
import 'package:hello_flutter/network/http.dart';
import 'package:hello_flutter/web/webview.dart';

import 'contents/button.dart';
import 'contents/form.dart';
import 'contents/icon.dart';
import 'contents/image.dart';
import 'contents/rich_text.dart';
import 'contents/selectable_text.dart';
import 'contents/text.dart';
import 'contents/text_field.dart';
import 'demo/todo_list/page.dart';
import 'home_page.dart';
import 'layouts/column.dart';
import 'layouts/container.dart';
import 'layouts/expanded.dart';
import 'layouts/row.dart';
import 'layouts/stack.dart';
import 'layouts/wrap.dart';
import 'lists/grid.dart';
import 'lists/list.dart';
import 'network/dio.dart';
import 'others/lifecycle1.dart';
import 'others/lifecycle2.dart';
import 'others/lifecycle3.dart';
import 'states/blocs/bloc_counter/counter_page.dart';
import 'states/blocs/cubit_counter/counter_page.dart';
import 'wrap_page.dart';

final List<Map<String, dynamic>> routesList = [
  {
    'id': 'Contents',
    'title': '内容组件',
    'icon': Icons.widgets_rounded,
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
    'icon': Icons.layers_rounded,
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
      MyWidget(
          id: 'Stack',
          title: 'Stack容器',
          description: 'Stack组件-堆叠布局',
          widget: const StackDemo()),
      MyWidget(
          id: 'Expanded',
          title: 'Expanded容器',
          description: 'Expanded组件-自动填充',
          widget: const ExpandedDemo()),
    ],
  },
  {
    'id': 'Lists',
    'title': '列表组件',
    'icon': Icons.list_alt_rounded,
    'children': [
      MyWidget(
          id: 'ListView',
          title: 'ListView列表',
          description: 'ListView-列表',
          widget: const ListViewDemo()),
      MyWidget(
          id: 'GridList',
          title: 'GridList列表',
          description: 'GridList-网格列表',
          widget: const GridDemo()),
    ],
  },
  {
    'id': 'Navigator',
    'title': '路由导航',
    'icon': Icons.route_rounded,
    'children': [
      MyWidget(
          id: 'PageView',
          title: 'PageView组件',
          description: 'PageView组件-页面滑动切换',
          widget: PageViewDemo()),
    ],
  },
  {
    'id': 'Network',
    'title': '网络请求',
    'icon': Icons.network_check_rounded,
    'children': [
      MyWidget(
          id: 'Http',
          title: 'Http请求数据',
          description: 'Http请求数据',
          widget: const HttpDemo()),
      MyWidget(
          id: 'Dio',
          title: 'Dio请求数据',
          description: 'Dio请求数据',
          widget: const DioDemo()),
    ],
  },
  {
    'id': 'States',
    'title': '状态管理',
    'icon': Icons.recycling_rounded,
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
  },
  {
    'id': 'WebView',
    'title': 'WebView',
    'icon': Icons.html_rounded,
    'children': [
      MyWidget(
          id: 'WebView',
          title: 'WebView',
          description: 'WebView',
          widget: const WebViewDemo()),
    ],
  },
  {
    'id': 'Others',
    'title': '其他组件',
    'icon': Icons.more_horiz_rounded,
    'children': [
      MyWidget(
          id: 'Lifecycle1',
          title: '生命周期测试1',
          description: '生命周期测试1',
          widget: const LifecycleDemo1()),
      MyWidget(
          id: 'Lifecycle2',
          title: '生命周期测试2',
          description: '生命周期测试2',
          widget: const LifecycleDemo2()),
      MyWidget(
          id: 'Lifecycle3',
          title: '生命周期测试3',
          description: '生命周期测试3',
          widget: const LifecycleDemo3()),
    ],
  },
  {
    'id': 'Demo',
    'title': '练习案例',
    'icon': Icons.assessment_rounded,
    'children': [
      MyWidget(
        id: 'todo_list',
        title: 'TodoList案例',
        description: 'TodoList案例',
        widget: const TodoListDemo(),
      )
    ]
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

final List<Map<String, dynamic>> homeTabsData = [
  {
    'id': 'home',
    'title': '首页',
    'icon': Icons.home,
    'route': '/',
  },
  {
    'id': 'demo',
    'title': '案例',
    'icon': Icons.assessment_rounded,
    'route': '/demo',
  },
  {
    'id': 'setting',
    'title': '设置',
    'icon': Icons.settings,
    'route': '/setting',
  },
  {
    'id': 'about',
    'title': '关于',
    'icon': Icons.info,
    'route': '/about',
  }
];

final baseRoutes = _getRoutes();
final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => const HomePage(),
  '/demo': (BuildContext context) => baseRoutes['/Contents/Form']!(context),
  '/setting': (BuildContext context) => baseRoutes['/Lists/GridList']!(context),
  '/about': (BuildContext context) => baseRoutes['/Lists/GridList']!(context),
  ...baseRoutes,
};
