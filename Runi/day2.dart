import 'dart:io';

void main() {
  final List<String> listInput =
      File('../input/day2_input.txt').readAsLinesSync();

  int scorePart1 = 0;
  final Map<String, int> rounds = <String, int>{};
  for (final String input in listInput) {
    rounds.update(input, (int value) => value + 1, ifAbsent: () => 1);
    scorePart1 += compare(convert(input).split(' ')) +
        1 +
        int.parse(convert(input.substring(2, 3)));
  }
  print('part1, score : $scorePart1');
  print('part2, score : ${scoring(rounds)}');
}

int compare(List<String> players) {
  final int p1 = int.parse(players[0]);
  final int p2 = int.parse(players[1]);

  if (p1 == p2) {
    return 3;
  } else if (((p1 + 1) % 3) == p2) {
    return 6;
  } else {
    return 0;
  }
}

String convert(String players) {
  return players
      .replaceAll('A', '0')
      .replaceAll('B', '1')
      .replaceAll('C', '2')
      .replaceAll('X', '0')
      .replaceAll('Y', '1')
      .replaceAll('Z', '2');
}

int scoring(Map<String, int> rounds) {
  return rounds.entries
      .map((MapEntry<String, int> rnd) => roundResult(rnd.key) * rnd.value)
      .toList(growable: false)
      .reduce((int value, int element) => value + element);
}

int roundResult(String round) {
  int result = 0;
  final List<String> input = round.split(' ');
  switch (input[1]) {
    case 'X':
      result = 0 + shapeSelector(input);
      break;
    case 'Y':
      result = 4 + int.parse(convert(input[0]));
      break;
    case 'Z':
      result = 6 + shapeSelector(input);
      break;
  }
  return result;
}

int shapeSelector(List<String> round) {
  if (round[1] == 'X') {
    switch (round[0]) {
      case 'A':
        return 3;
      case 'B':
        return 1;
      case 'C':
        return 2;
    }
  } else if (round[1] == 'Z') {
    switch (round[0]) {
      case 'A':
        return 2;
      case 'B':
        return 3;
      case 'C':
        return 1;
    }
  }
  return 0;
}
