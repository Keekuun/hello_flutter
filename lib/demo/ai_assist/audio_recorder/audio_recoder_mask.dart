import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'audio_recoder.dart';
import 'audio_shareData.dart';
import 'audio_wave.dart';

const _duration = Duration(milliseconds: 220);

Future<OverlayEntry> showAudioRecord(
    BuildContext context, PolymerData data) async {
  var lay = OverlayEntry(builder: (BuildContext context) {
    return roomAudioRecode(data);
  });
  Overlay.of(context).insert(lay);
  return lay;
}

class roomAudioRecode extends StatelessWidget {
  const roomAudioRecode(this.polymerData);

  final PolymerData polymerData;

  @override
  Widget build(BuildContext context) {
    final data = polymerData.data;

    return Material(
      // type: MaterialType.transparency,
      color: Colors.black.withOpacity(0.7),
      // color: Colors.transparent,
      child: PolymerState(
        data: polymerData,
        child: ValueListenableBuilder(
          valueListenable: polymerData.controller.status,
          builder: (context, value, child) {
            return _MaskStackView(
              children: [
                _Bubble(),
                _RecordingTime(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(value.title, style: data.maskTxtStyle),
                    const SizedBox(height: 20),
                    CustomPaint(
                      // size: Size(double.infinity, data.sendAreaHeight),
                      painter: _RecordingPainter(
                          value == SoundsMessageStatus.recording),
                      child: Container(
                        width: double.infinity,
                        height: data.sendAreaHeight,
                        alignment: Alignment.center,
                        child: value == SoundsMessageStatus.recording
                            ? Icon(Icons.mic, color: Colors.white)
                            : Icon(Icons.mic, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MaskStackView extends StatelessWidget {
  const _MaskStackView({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final polymerState = PolymerState.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Positioned(
          child: Container(
            color: const Color(0x00000099),
          ),
        ),
        ...children,
      ]),
    );
  }
}

class _RecordingTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final polymerState = PolymerState.of(context);
    return ValueListenableBuilder(
      valueListenable: polymerState.controller.duration,
      builder: (context, value, child) {
        return Positioned(
          bottom: (polymerState.data.sendAreaHeight * 2 +
              polymerState.data.iconFocusSize -
              36),
          child: Text(
            formatFromSeconds(value.inSeconds),
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        );
      },
    );
  }

  String formatFromSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class _RecordingPainter extends CustomPainter {
  final bool isFocus;

  _RecordingPainter(this.isFocus);

  @override
  void paint(Canvas canvas, Size size) async {
    final bgOvalRect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 3 / 2),
        width: size.width * 1.8,
        height: size.height * 3);

    final paint = Paint()
      ..color = const Color(0xFF160C23)
      ..style = PaintingStyle.fill;
    Path path = Path()..addOval(bgOvalRect);

    if (isFocus) {
      paint.color = const Color(0xFF442867);
      canvas.drawPath(path, paint);

      final scale = (size.height * 3 - 8) / (size.height * 3);

      final bgShaderRect = Rect.fromCenter(
        center: bgOvalRect.center,
        width: bgOvalRect.width * scale,
        height: bgOvalRect.height * scale,
      );
      canvas.drawPath(
          Path()..addOval(bgShaderRect),
          Paint()
            ..shader = ui.Gradient.linear(
              Offset(size.width / 2, size.height),
              Offset(size.width / 2, 0),
              [
                const Color(0xff160C23),
                const Color(0xff25143B),
              ],
            ));
    } else {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_RecordingPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_RecordingPainter oldDelegate) => false;
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final polymerState = PolymerState.of(context);

    final data = polymerState.data;
    final status = polymerState.controller.status.value;

    final double height = (88).roundToDouble();
    final double side =
        ((MediaQuery.of(context).size.width - 165) / 2.0).roundToDouble();
    Rect rect = Rect.fromLTRB(side, 0, side, height);

    Color paintColor = const Color(0xFFFA3535);
    if (status == SoundsMessageStatus.recording) {
      // rect = Rect.fromLTRB(105, 0, 105, height);
      paintColor = const Color(0xFFF910F0);
    }

    return Positioned(
      left: 0,
      right: 0,
      bottom: (data.sendAreaHeight * 2 + data.iconFocusSize + 20),
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(left: rect.left, right: rect.right, bottom: 0),
        width: rect.width,
        height: rect.height,
        child: CustomPaint(
          painter: _BubblePainter(paintColor),
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: const AmpContent(),
          ),
        ),
      ),
    );
  }
}

class AmpContent extends StatelessWidget {
  const AmpContent({super.key});

  @override
  Widget build(BuildContext context) {
    final polymerState = PolymerState.of(context);
    return CustomPaint(
      painter: WavePainter(polymerState.controller.amplitudeList),
    );
  }
}

class _BubblePainter extends CustomPainter {
  final Color paintColor;

  _BubblePainter(this.paintColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill;

    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(24));

    final path = Path();

    var dx = rect.center.dx;

    path.moveTo(dx - 8, size.height);
    path.lineTo(dx, size.height + 8);
    path.lineTo(dx + 8, size.height);

    // 矩形
    path.addRRect(rrect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BubblePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_BubblePainter oldDelegate) => false;
}
