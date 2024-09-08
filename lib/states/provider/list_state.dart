import 'package:flutter/material.dart';

class WidgetListState with ChangeNotifier {
  final List<Widget> _widgets = [];

  List<Widget> get widgets => _widgets;

  void addWidget(Widget widget) {
    _widgets.add(widget);
    notifyListeners();
  }

  void removeWidgetAt(int index) {
    _widgets.removeAt(index);
    notifyListeners();
  }

  void updateWidgetAt(int index, Widget newWidget) {
    if (index >= 0 && index < _widgets.length) {
      _widgets[index] = newWidget;
      notifyListeners();
    }
  }
}
