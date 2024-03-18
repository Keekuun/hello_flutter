import 'dart:math';

Point? main() {
  const pair = ['1', 2];
  if (pair case [int x, int y]) return Point(x, y);

  return null;
}


class Point {
  final int x;
  final int y;

  // Sets the x and y instance variables
  // before the constructor body runs.
  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}