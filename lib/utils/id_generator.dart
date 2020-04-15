import 'dart:math';

String generateId([int length = 8]) {
  var random = Random();
  var charCodes = List.generate(length, (_) {
    return random.nextInt(33) + 89;
  });
  return String.fromCharCodes(charCodes);
}
