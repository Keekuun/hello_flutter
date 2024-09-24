import 'package:get/get.dart';

class CounterLogic extends GetxController {
  int count = 0;

  void increase() {
    count++;
    update();
  }

  void decrease() {
    count--;
    update();
  }
}

final CounterLogic controller = CounterLogic();
