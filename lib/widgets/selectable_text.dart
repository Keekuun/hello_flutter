import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SelectableTextDemo extends HookWidget {
  const SelectableTextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final msg = useState('我是可选文本我是可选文本我是可选文本我是可选文本');

    void handleTap() {
      msg.value = '我被点击了我被点击了我被点击了我被点击了';
    }

    void handleSelectionChanged(
        TextSelection selection, SelectionChangedCause? cause) {
      log(selection.toString());
      log(cause.toString());
      log('我被选择了');
    }

    useEffect(() {
      log('我来了');
      log(msg.value);
      return () {
        log('离开了');
      };
    }, [msg.value]);

    return SelectableText(
      msg.value.toString(),
      style: const TextStyle(fontSize: 20, color: Colors.blue),
      showCursor: true,
      autofocus: true,
      onTap: handleTap,
      onSelectionChanged: handleSelectionChanged, //onTap//showCursor
    );
  }
}
