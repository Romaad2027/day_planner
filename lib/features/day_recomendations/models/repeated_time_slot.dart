class RepeatedTimeSlot {
  final String category;

  int count = 0;

  RepeatedTimeSlot(this.category);

  void increment() => count++;
}
