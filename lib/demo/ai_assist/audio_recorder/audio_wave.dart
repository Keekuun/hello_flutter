

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  WavePainter(this.items) : super(repaint: items);

  /// values 0.0 ~ 1.0
  final ValueNotifier<List<double>> items;

  @override
  void paint(Canvas canvas, Size size) {
    const count = 13;
    const centerCount = count ~/ 2;

    const lineSize = Size(3, 16);
    const lineSpec = 2.0;
    const radius = Radius.circular(1.5);

    final center = Offset(size.width / 2, size.height / 2);

    final tempList = List.generate(count, (index) {
      if (index < items.value.length - 1) {
        return items.value[index];
      }
      return 0.0;
    });

    final paint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: center,
              width: lineSize.width,
              height: getWaveHeight(lineSize.height, tempList[centerCount])),
          radius,
        ),
        paint);

    for (var i = 0; i <= centerCount; i++) {
      canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(
                    center.dx + (lineSize.width + lineSpec) * i, center.dy),
                width: lineSize.width,
                height: getWaveHeight(lineSize.height, tempList[i])),
            radius,
          ),
          paint);

      canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(
                    center.dx - (lineSize.width + lineSpec) * i, center.dy),
                width: lineSize.width,
                height: getWaveHeight(lineSize.height, tempList[i])),
            radius,
          ),
          paint);
    }
  }

  double getWaveHeight(double height, double wave) {
    final double newWave = max(height / 2.0, height * (wave + 1));
    return newWave;
  }
  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(WavePainter oldDelegate) => false;
}
