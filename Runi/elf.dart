class Elf {
  Elf({required this.calories, this.name}) : id = count {
    _totalCalories += calories;
    count++;
  }

  final int id;
  final String? name;
  final int calories;
  static int _totalCalories = 0;
  static int count = 0;

  static int get totalCalories => _totalCalories;

  void introduceMe() {
    print('I am elf $id, I carry $calories calories out of $_totalCalories');
  }
}
