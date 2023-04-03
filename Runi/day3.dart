import 'dart:io';

void main() {
  List<String> listInput = File('../input/day3_input.txt').readAsLinesSync();

  String solutionPart1 = '';
  for (final input in listInput) {
    int halfLength = input.length ~/ 2;
    solutionPart1 += find(input.substring(0, halfLength),
        input.substring(halfLength, input.length));
  }
  print('The sum of priorities is : ${sum(solutionPart1)}');

  String solutionPart2 = '';
  for (var i = 2; i < listInput.length; i++) {
    if ((i + 1) % 3 == 0) {
      solutionPart2 +=
          find(listInput[i], find(listInput[i - 1], listInput[i - 2]));
    }
  }
  print('The sum of safety badges is : ${sum(solutionPart2)}');
}

/// find the common runes in 2 Strings
String find(String compartment1, String compartment2) {
  String commons = '';
  for (int i = 0; i < compartment1.length; i++) {
    if (compartment2.contains(compartment1[i]) &&
        !commons.contains(compartment1[i])) {
      commons += compartment1[i];
    }
  }
  return commons;
}

int sum(String str) {
  String ref = '0abcdefghijklmnopqrstuvwxyz';
  ref += ref.substring(1).toUpperCase();
  int sum = 0;
  for (int i = 0; i < str.length; i++) {
    sum += ref.indexOf(str[i]);
  }
  return sum;
}
