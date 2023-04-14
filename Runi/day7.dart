import 'dart:io';

class Tree extends Dir {
  Tree({required super.name}) {
    currentDir = this;
  }

  late Dir currentDir;

  void moveIn(String name) {
    currentDir = currentDir.child.firstWhere((Dir d) => d.name == name);
  }

  void moveOut() {
    currentDir = currentDir.parent ?? this;
  }

  void root() {
    currentDir = this;
  }
}

class Dir {
  Dir({required this.name, this.parent});

  final String name;
  final Dir? parent;
  final List<int> ls = <int>[];
  final List<Dir> child = <Dir>[];

  void populate(List<String> ls) {
    for (int i = 1; i < ls.length; i += 2) {
      if (ls[i] == 'dir') {
        final String name = ls[i + 1];
        child.add(Dir(name: name, parent: this));
      } else if (ls[i].isNotEmpty) {
        this.ls.add(int.parse(ls[i]));
      }
    }
  }

  int totalSize() {
    int size = ls.isNotEmpty ? ls.reduce((int val, int el) => val + el) : 0;
    for (final Dir d in child) {
      size += d.totalSize();
    }
    return size;
  }
}

void main() {
  final String rawInput = File('./input/day7_input.txt').readAsStringSync();

  final Tree root = Tree(name: 'root');
  parseInput(rawInput, root);

  final int solutionPart1 = resolvePart1(root);
  print('solution to Part1 is $solutionPart1');

  final List<Dir> directories = <Dir>[];
  final int remainingSpace = 70000000 - root.totalSize();
  const int requiredSpace = 30000000;
  final int spaceToClean = requiredSpace - remainingSpace;
  findSolution2(root, directories, spaceToClean);
  directories.sort((a, b) => a.totalSize().compareTo(b.totalSize()));
  print('Solution to part 2 is ${directories.first.totalSize()}');
}

void parseInput(String rawInput, Tree tree) {
  final List<String> listInput = rawInput.split(r'$ ');

  for (final String line in listInput) {
    if (line.startsWith('ls')) {
      tree.currentDir.populate(line.split(RegExp(r'[\n ]')));
    }
    if (line.startsWith('cd')) {
      final String dest = line.split(RegExp(r'[\n ]'))[1];
      switch (dest) {
        case '/':
          tree.root();
          break;
        case '..':
          tree.moveOut();
          break;
        default:
          tree.moveIn(dest);
          break;
      }
    }
  }
}

int resolvePart1(Dir d) {
  int sum = 0;
  for (final Dir child in d.child) {
    sum += resolvePart1(child);
  }
  if (d.totalSize() < 100000) {
    sum += d.totalSize();
  }
  return sum;
}

void findSolution2(Dir d, List<Dir> directories, int spaceToClean) {
  for (final Dir child in d.child) {
    findSolution2(child, directories, spaceToClean);
  }
  if (d.totalSize() >= spaceToClean) {
    directories.add(d);
  }
}
