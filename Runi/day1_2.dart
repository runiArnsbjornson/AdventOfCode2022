import 'dart:io';

void main() {
  final List<String> listInput = File('./input/day1_input.txt').readAsLinesSync();

  int weight = 0;
  int elf = 0;
  final Map<int, int> elfs = <int, int>{};

  for (final String input in listInput) {
    if (input.isEmpty) {
      elfs[elf] = weight;
      elf++;
      weight = 0;
    } else {
      weight += int.parse(input);
    }
  }

  final List<int> bigThree = elfs.values.toList(growable: false)
    ..sort((int a,int  b) => -a.compareTo(b));
  elfs.removeWhere((int key, int value) => value < bigThree[2]);
  introduceMe(elfs);
}

void introduceMe(Map<int, int> elfs) {
  elfs.forEach((int key, int value) {
    print("Je suis l'elfe $key et j'ai $value calories");
  });
}
