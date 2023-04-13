import 'dart:io';

class Elf {
  Elf({required String input}) {
    final int start = int.parse(input.split('-')[0]);
    final int end = int.parse(input.split('-')[1]);
    for (int i = start; i <= end; i++) {
      sections.add(i);
    }
  }

  Set<int> sections = <int>{};
}

class Pair {
  Pair({required this.elf1, required this.elf2});

  final Elf elf1;
  final Elf elf2;

  bool contained() =>
      elf1.sections.containsAll(elf2.sections) ||
      elf2.sections.containsAll(elf1.sections);

  bool overlap() => elf1.sections.intersection(elf2.sections).isNotEmpty;
}

void main() {
  final List<String> listInput =
      File('./input/day4_input.txt').readAsLinesSync();

  final List<Pair> pairs = parseInput(listInput);

  final int fullyContainedPair =
      pairs.fold(0, (int count, Pair p) => p.contained() ? count + 1 : count);
  print('there is $fullyContainedPair fully contained pair');

  final int overlappingPair =
      pairs.fold(0, (int count, Pair p) => p.overlap() ? count + 1 : count);
  print('there is $overlappingPair overlapping pair');
}

List<Pair> parseInput(List<String> listInput) {
  final List<Pair> pairs = <Pair>[];
  for (final String input in listInput) {
    final List<String> pair = input.split(',');
    pairs.add(Pair(elf1: Elf(input: pair[0]), elf2: Elf(input: pair[1])));
  }
  return pairs;
}
