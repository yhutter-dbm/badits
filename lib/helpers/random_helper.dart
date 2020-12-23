/*
Implemented with reference to:
- https://stackoverflow.com/questions/17476718/how-do-get-a-random-element-from-a-list-in-dart
*/

import 'dart:math';

class RandomHelper {
  static final _random = new Random();
  static T getRandomElementFromList<T>(List<T> elements) {
    final randomIndex = _random.nextInt(elements.length);
    return elements[randomIndex];
  }
}
