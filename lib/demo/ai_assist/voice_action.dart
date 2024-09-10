import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'audio_recorder/audio_recoder.dart';
import 'audio_recorder/audio_recoder_mask.dart';
import 'audio_recorder/audio_shareData.dart';
import 'audio_recorder/recorder_data.dart';

class VoiceAction extends StatefulWidget {
  final Function(SoundsMessageStatus status)? onStatusChange;

  final Function(String content, int duration)? onEnd;
  final void Function()? onStart;

  const VoiceAction({super.key, this.onStatusChange, this.onEnd, this.onStart});

  @override
  State<VoiceAction> createState() => _VoiceActionState();
}

class _VoiceActionState extends State<VoiceAction> {
  OverlayEntry? lay;

  AudioRecorder recorder = AudioRecorder();
  final RecordingMaskOverlayData maskData = RecordingMaskOverlayData();

  @override
  void initState() {
    super.initState();
    recorder.status.addListener(() {
      widget.onStatusChange?.call(recorder.status.value);
    });
  }

  void showMaskView() async {
    lay = await showAudioRecord(context, PolymerData(recorder, maskData));
  }

  void beginPress() async {
    var permission = Permission.microphone;
    bool isGrantedAlready = await permission.isGranted;

    if (!isGrantedAlready) {
      bool hasPermission = !await recorder.hasPermission();
      if (!hasPermission) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('没有麦克风权限'),
            ),
          );
        }
      }
      return;
    }

    showMaskView();

    widget.onStart?.call();
    recorder.beginRec(
      onStateChanged: (state) {},
      onAmplitudeChanged: (amplitude) {},
      onDurationChanged: (time) {},
      onCompleted: (path, duration) {
        debugPrint('________  onCompleted: $path , $duration ');

        if (duration.inSeconds < 1) {
          removeMaskView();
          Fluttertoast.showToast(msg: '说话时间太短');
          return;
        }

        if (recorder.status.value == SoundsMessageStatus.recording) {
          widget.onEnd?.call(path!, duration.inSeconds);
          removeMaskView();
        } else if (recorder.status.value == SoundsMessageStatus.canceling) {
          removeMaskView();
        }
      },
    );
  }

  void pressMove(LongPressMoveUpdateDetails details) {
    if (recorder.status.value == SoundsMessageStatus.none) {
      return;
    }
    final offset = details.globalPosition;
    if ((MediaQuery.of(context).size.height - offset.dy.abs()) >
        maskData.sendAreaHeight) {
      recorder.updateStatus(SoundsMessageStatus.canceling);
    } else {
      recorder.updateStatus(SoundsMessageStatus.recording);
    }
  }

  void removeMaskView() {
    if (lay != null) {
      lay!.remove();
      lay = null;
      recorder.updateStatus(SoundsMessageStatus.none);
    }
  }

  @override
  void dispose() {
    recorder.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPressStart: (d) {
          beginPress();
        },
        onLongPressEnd: (d) {
          recorder.endRec();
        },
        onLongPressMoveUpdate: (d) {
          pressMove(d);
        },
        child: const Icon(Icons.mic));
  }
}
