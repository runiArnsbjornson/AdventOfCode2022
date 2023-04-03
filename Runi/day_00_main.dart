import 'elf.dart';
import 'dart:io';

void main() {
  List<String> listInput = File('../input/day1_input.txt').readAsLinesSync();
  List<Elf> allElfs = [];
  int weight = 0;

  for (final input in listInput) {
    if (input.isEmpty) {
      allElfs.add(Elf(calories: weight));
      weight = 0;
    } else {
      weight += int.parse(input);
    }
  }

  sortElfs(allElfs);
  for (int i = 0; i < 3; i++) {
    allElfs[i].introduceMe();
  }
}

void sortElfs(List<Elf> elves) {
  elves.sort((a, b) => -a.calories.compareTo(b.calories));
}