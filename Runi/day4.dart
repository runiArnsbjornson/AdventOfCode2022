import 'dart:io';

class Elf {
  Elf({required this.input}) {
    _first = int.parse(input.split('-')[0]);
    _last = int.parse(input.split('-')[1]);
    for (int i = _first; i <= _last; i++) {
      sections.add(i);
    }
  }

  Set<int> sections = <int>{};
  final String input;
  int _first = 0;
  int _last = 0;
}

void main() {
  final List<String> listInput =
      File('./input/day4_input.txt').readAsLinesSync();

  List<List<Elf>> pairs = parseInput(listInput);

  countContained(pairs);
  countOverlap(pairs);
}

List<List<Elf>> parseInput(List<String> listInput) {
  List<List<Elf>> pairs = <List<Elf>>[];
  listInput.forEach((String input) => pairs.add(makePair(input)));
  return pairs;
}

List<Elf> makePair(String input) {
  return <Elf>[
    Elf(input: input.split(',')[0]),
    Elf(input: input.split(',')[1])
  ];
}

void countContained(List<List<Elf>> pairs) {
  int contained = 0;

  pairs.forEach((List<Elf> pair) {
    containedSection(pair[0], pair[1]) ? contained++ : 0;
  });
  print('There is $contained pairs have sections fully contained');
}

bool containedSection(Elf elf1, Elf elf2) {
  return elf1.sections.containsAll(elf2.sections)
      ? true
      : (elf2.sections.containsAll(elf1.sections) ? true : false);
}

void countOverlap(List<List<Elf>> pairs) {
  int overlap = 0;

  pairs.forEach((List<Elf> pair) {
    pair[0].sections.intersection(pair[1].sections).isNotEmpty ? overlap++ : 0;
  });
  print('There is $overlap pairs with overlap}');
}
