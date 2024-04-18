class XX {}

mixin class A {}

interface class B {}

class C implements A, B {}

class D extends C {}

sealed class E extends D with A {}

base class F extends E {}
class G implements E {}

final class H {}

final class I implements H {}

class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  void sayHello() {
    print('Hello, my name is $name and I am $age years old.');
  }
}

class Student extends Person {
  final String school;

  Student(super.name, super.age, this.school);

  void study() {
    print('$name is now studying.');
  }

  // 子类重写父类的方法
  @override
  void sayHello() {
    print(
        'Hello, my name is $name and I am $age years old. I am a student at $school.');
  }
}


abstract class Animal {
  void eat();
}

abstract class Mammal implements Animal {
  void sleep();
}

class Human implements Mammal {
  @override
  void eat() {
    print('I am eating.');
  }

  @override
  void sleep() {
    print('I am sleeping.');
  }

  void work() {
    print('I am working.');
  }
}

mixin Flyable {
  void fly() {
    print('I can fly.');
  }
}

mixin Walkable {
  void walk() {
    print('I can walk.');
  }
}

class Bird with Flyable, Walkable {
  void sing() {
    print('I can sing.');
  }

  @override
  void fly() {
    print('I am flying.');
  }

  @override
  void walk() {
    print('I am walking.');
  }
}

void main() {
  // E e = E();

  // Abstract classes can't be instantiated.
  // var animal = Animal();

  var human = Human();
  human.eat();
  human.sleep();
  human.work();


  // error: Mixins can't be instantiated.
  // var flyable = Flyable();

  var bird = Bird();
  bird.fly();
  bird.walk();
  bird.sing();
}