import 'dart:math';

class FisherYates {
  static void shuffleList<T>(List<T> items) {
    final random = Random();
    for (int i = items.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      T temp = items[i];
      items[i] = items[j];
      items[j] = temp;
    }
  }
}
