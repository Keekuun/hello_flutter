import 'class_test.dart';

interface class People {
  void eat() {
    // TODO: implement eat
  }
}
class Man extends People {
  void work() {
    print('I am working');
  }

  @override
  void eat() {
    print('I am eating');
  }
}

void main() {
  Man man = Man();
  man.eat();
}

class x1 extends XX {}

class x2 implements XX {}

