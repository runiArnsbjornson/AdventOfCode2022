import 'dart:io';

main() {
  List<String> listInput = File('day1_input.txt').readAsLinesSync();

  int weight = 0;
  int elf = 0;
  var elfs = Map<int, int>();

  for (final input in listInput) {
    if (input.isEmpty) {
      elfs[elf] = weight;
      elf++;
      weight = 0;
    } else {
      weight += int.parse(input);
    }
  }

  List<int> bigThree = elfs.values.toList(growable: false)
    ..sort((a, b) => -a.compareTo(b));
  elfs.removeWhere((key, value) => value < bigThree[2]);
  introduceMe(elfs);
}

introduceMe(Map<int, int> elfs) {
  elfs.forEach((key, value) {
    print("Je suis l'elfe $key et j'ai $value calories");
  });
}
