import 'dart:math';

int getRandomHexColor() {
  final random = Random();
  return 0xFF000000 + random.nextInt(0x00FFFFFF);
}
