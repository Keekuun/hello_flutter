void main() {
  // Declaring and initialising a variable
  int age = 18;

  // Declaring another variable
  double pi = 3.14; // must declare double a value or it will throw error
  bool male = false; // must declare boolean a value or it will throw error

  // Declaring multiple variable
  String like1 = "dart", like2 = "flutter";

  // Printing values of all the variables
  print(age); // Print 10
  print(pi); // Print default double value
  print(male); // Print default string value
  print(like1); // Print default bool value
  print(like2); // Print Geeks for Geeks


  var name1 = 'dart';

  String name2 = 'dart';
  // name2 = 2 as String;
  Object name3 = 'dart';
  name3 = 3;
  dynamic name4 = 'dart';
  name4 = 4;

  print(name1);
  print(name2);
  print(name3);
  print(name3);
  print(name4);

  int a;
  // a = 10;

  late String aa;
  aa = '123';

  late int hh = 18;
  hh = 19;
  print(aa);
  print(aa);

  // var String he = 'je';

  var pm = ProfileMark(name1);
  print(pm.start);
  print(ProfileMark.age1);
  print(ProfileMark.age2);
}

class ProfileMark {
  static const age1 = 10;
  static const age2 = 10;
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}