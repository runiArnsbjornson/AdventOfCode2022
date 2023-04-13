import 'dart:io';

void main() {
  final List<String> listInput = File('./input/day1_input.txt').readAsLinesSync();

  int weight = 0;
  final List<int> maxWeight = [];
  for (final String input in listInput) {
    if (input.isEmpty) {
      maxWeight.add(weight);
      weight = 0;
    } else {
      weight += int.parse(input);
    }
  }
  maxWeight
    ..sort((int a, int b) => a.compareTo(b))
    ..removeRange(0, maxWeight.length - 3)
    ..reduce((int value, int element) => value + element);
  print('total weight is ${maxWeight.reduce((int v, int e) => v + e)}');
}
