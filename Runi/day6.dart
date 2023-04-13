import 'dart:io';

void main() {
  final String input = File('./input/day6_input.txt').readAsStringSync();

  print('First packet is at ${findFirstByLength(input, 4)}');
  print('First marker is at ${findFirstByLength(input, 14)}');
}

int findFirstByLength(String input, int length) {
  for (int i = 0; i < input.length - length; i++) {
    final String buff = input.substring(i, i + length);
    final Set<String> tester = Set<String>.from(buff.split(''));
    if (tester.length == length) {
      return i + length;
    }
  }
  return 0;
}
