import 'dart:io';

class Elf {
  Elf({required String input}) {
    for (int i = int.parse(input.split('-')[0]);
        i <= int.parse(input.split('-')[1]);
        i++) {
      sections.add(i);
    }
  }

  Set<int> sections = <int>{};
}

class Pair {
  Pair({required this.elf1, required this.elf2}) {}

  final Elf elf1;
  final Elf elf2;

  bool contained() =>
      this.elf1.sections.containsAll(this.elf2.sections) ||
      this.elf2.sections.containsAll(this.elf1.sections);

  bool overlap() =>
      this.elf1.sections.intersection(this.elf2.sections).isNotEmpty;
}

void main() {
  final List<String> listInput =
      File('./input/day4_input.txt').readAsLinesSync();

  final List<Pair> pairs = parseInput(listInput);

  final int fullyContainedPair = pairs.fold(
      0, (int count, Pair element) => element.contained() ? count + 1 : count);
  print('there is $fullyContainedPair fully contained pair');

  final int overlappingPair = pairs.fold(
      0, (int count, Pair element) => element.overlap() ? count + 1 : count);
  print('there is $overlappingPair overlapping pair');
}

List<Pair> parseInput(List<String> listInput) {
  List<Pair> pairs = <Pair>[];
  listInput.forEach((String input) => pairs.add(Pair(
      elf1: Elf(input: input.split(',')[0]),
      elf2: Elf(input: input.split(',')[1]))));
  return pairs;
}
