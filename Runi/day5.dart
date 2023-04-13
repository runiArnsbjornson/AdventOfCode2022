import 'dart:io';

class Stack {
  Stack({required String cratesInput}) {
    crates = cratesInput.split('');
  }

  List<String> crates = <String>[];

  void addCrate(String crate) {
    crates.add(crate);
  }

  void addAll(String crates) {
    crates.split('').forEach(addCrate);
  }

  String removeCrate(int qty) {
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < qty; i++) {
      buffer.write(crates.last);
      crates.removeLast();
    }
    return buffer.toString();
  }
}

class Process {
  Process({required String processInput}) {
    process = (processInput.split(' '))
        .where((String element) => element.contains(RegExp(r'\d+')))
        .toList();
  }

  List<String> process = <String>[];
}

void main() {
  final List<String> listInput =
      File('./input/day5_input.txt').readAsLinesSync();

  final List<String> stackInput =
      listInput.takeWhile((String str) => str.isNotEmpty).toList();
  listInput.removeRange(0, stackInput.length + 1);

  final String resultPart1 =
      executeProcess(parseStacks(stackInput), parseProcess(listInput));
  print("the last crates of each stack form the 'word': $resultPart1");
}

List<Stack> parseStacks(List<String> stackInput) {
  final int nbStacks = int.parse(stackInput.last.split(' ').last);
  final List<Stack> allStacks =
      List<Stack>.generate(nbStacks, (int index) => Stack(cratesInput: ''));

  for (final String input in (stackInput..removeLast()).reversed) {
    for (int i = 0; i < (input.length + 1) / 4; i++) {
      final int index = i * 4 + 1;
      if (input[index] != ' ') {
        allStacks[i].addCrate(input[index]);
      }
    }
  }
  return allStacks;
}

List<Process> parseProcess(List<String> processInput) {
  final List<Process> processes = <Process>[];
  for (final String input in processInput) {
    processes.add(Process(processInput: input));
  }
  return processes;
}

String executeProcess(List<Stack> stacks, List<Process> processes) {
  for (final Process p in processes) {
    final int qty = int.parse(p.process[0]);
    final int source = int.parse(p.process[1]) - 1;
    final int dest = int.parse(p.process[2]) - 1;
    stacks[dest].addAll(stacks[source].removeCrate(qty));
  }
  final StringBuffer result = StringBuffer();
  for (final Stack s in stacks) {
    result.write(s.crates.last);
  }
  return result.toString();
}
