import 'dart:io';
import 'elf.dart';

void main() {
  final List<String> listInput =
      File('../input/day1_input.txt').readAsLinesSync();
  final List<Elf> allElfs = <Elf>[];
  int weight = 0;

  for (final String input in listInput) {
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
  elves.sort((Elf a, Elf b) => -a.calories.compareTo(b.calories));
}
