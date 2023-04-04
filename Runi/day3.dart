import 'dart:io';

void main() {
  final List<String> listInput =
      File('../input/day3_input.txt').readAsLinesSync();

  print('The sum of priorities is : ${solutionPart1(listInput)}');
  print('The sum of safety badges is : ${solutionPart2(listInput)}');
}

int solutionPart1(List<String> listInput) {
  String solutionPart1 = '';
  for (final input in listInput) {
    int halfLength = input.length ~/ 2;
    solutionPart1 += findCommonRunes(
        input.substring(0, halfLength), input.substring(halfLength));
  }
  return sumPriority(solutionPart1);
}

int solutionPart2(List<String> listInput) {
  String solutionPart2 = '';
  for (int i = 2; i < listInput.length; i++) {
    if ((i + 1) % 3 == 0) {
      solutionPart2 += findCommonRunes(
          listInput[i], findCommonRunes(listInput[i - 1], listInput[i - 2]));
    }
  }
  return sumPriority(solutionPart2);
}

String findCommonRunes(String str1, String str2) {
  String commons = '';
  for (int i = 0; i < str1.length; i++) {
    if (str2.contains(str1[i]) && !commons.contains(str1[i])) {
      commons += str1[i];
    }
  }
  return commons;
}

int sumPriority(String str) {
  String ref = '0abcdefghijklmnopqrstuvwxyz';
  ref += ref.substring(1).toUpperCase();
  int sum = 0;
  for (int i = 0; i < str.length; i++) {
    sum += ref.indexOf(str[i]);
  }
  return sum;
}
