// Import the test package and Counter class
import 'package:test/test.dart';

void main() {
  test('Test list function', () {
    var _ints = (([3, 2, 4, 5]..sort())
          ..addAll(
            [5, 3, 7],
          ))
        .where((element) => element != 3)
        .toList();
    // ignore: avoid_print
    print(_ints);
  });
}
