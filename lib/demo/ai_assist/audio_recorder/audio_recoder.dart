import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

enum SoundsMessageStatus {
  none,
  recording,
  canceling;

  String get title {
    switch (this) {
      case none:
        return '长按说话';
      case recording:
        return '松开发送';
      case canceling:
        return '松开取消';
    }
  }
}

class AudioRecorder {
  AudioRecorder();

  final path = ValueNotifier<String?>('');

  final status = ValueNotifier(SoundsMessageStatus.none);

  // final amplitude = ValueNotifier<Amplitude>(Amplitude(current: 0, max: 1));

  /// [0.0 ~ 1.0]
  final amplitudeList = ValueNotifier<List<double>>([]);

  RecorderController? recorderController;

  final duration = ValueNotifier<Duration>(Duration.zero);
  Timer? _timer;

  //  bool beforeEnd = false;
  Function(String? path, Duration duration)? _onAllCompleted;

  beginRec({
    ValueChanged<RecorderState>? onStateChanged,
    ValueChanged<List<double>>? onAmplitudeChanged,
    ValueChanged<Duration>? onDurationChanged,
    required Function(String? path, Duration duration) onCompleted,
  }) async {
    try {
      reset();
      _onAllCompleted = onCompleted;

      recorderController = RecorderController()
        ..androidEncoder = AndroidEncoder.aac
        ..androidOutputFormat = AndroidOutputFormat.mpeg4
        ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
        ..sampleRate = 44100;

      updateStatus(SoundsMessageStatus.recording);

      recorderController?.onRecorderStateChanged.listen((state) {
        onStateChanged?.call(state);
      });

      recorderController?.onCurrentDuration.listen((value) {
        duration.value = value;

        if (value.inSeconds >= 60) {
          endRec();
        }

        onDurationChanged?.call(value);

        amplitudeList.value = recorderController!.waveData.reversed.toList();
      });

      await recorderController!.record(); // Path is optional
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  Future endRec() async {
    if (recorderController!.isRecording) {
      path.value = await recorderController!.stop();

      if (path.value?.isNotEmpty == true) {
        debugPrint(path.value);
        // debugPrint("Recorded file size: ${File(path.value!).lengthSync()}");
      }

      _onAllCompleted?.call(path.value, duration.value);
    } else {
      _onAllCompleted?.call(null, Duration.zero);
    }
    reset();
  }

  reset() {
    _timer?.cancel();
    duration.value = Duration.zero;
    recorderController?.dispose();
  }

  Future<bool> hasPermission() async {
    final state = await Permission.microphone.request();

    return state == PermissionStatus.granted;
  }

  updateStatus(SoundsMessageStatus value) {
    status.value = value;
  }
}
