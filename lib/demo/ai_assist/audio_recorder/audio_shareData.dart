import 'package:flutter/cupertino.dart';

import 'audio_recoder.dart';
import 'recorder_data.dart';

class PolymerData {
  PolymerData(this.controller, this.data);

  final AudioRecorder controller;

  final RecordingMaskOverlayData data;
}

class PolymerState extends InheritedWidget {
  const PolymerState({
    super.key,
    required this.data,
    required super.child,
  });

  final PolymerData data;

  static PolymerData of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<PolymerState>();
    return scope!.data;
  }

  @override
  bool updateShouldNotify(covariant PolymerState oldWidget) {
    return oldWidget.data != data;
  }
}
