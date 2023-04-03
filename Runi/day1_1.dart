import 'dart:io';

main() {
  List<String> listInput = File('day1_input.txt').readAsLinesSync();

  int weight = 0;
  List<int> maxWeight = [];
  for(final input in listInput){
    if (input.isEmpty) {
      maxWeight.add(weight);
      weight = 0;
    } else {
      weight += int.parse(input);
    }
  }
  maxWeight.sort((a, b) => -a.compareTo(b));
  int result = 0;
  for(var i = 0; i < 3; i++) {
    result += maxWeight[i];
  }
  print('$result');
}