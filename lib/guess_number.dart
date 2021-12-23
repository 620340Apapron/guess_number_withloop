// ignore_for_file: avoid_print

import 'dart:io';
import 'game.dart';

void main() {
  playgame();
  var play = false;
  do {
    stdout.write('Play again? (Y/N): ');
    var reply = stdin.readLineSync();

    if (reply == 'y' || reply == "Y") {
      playgame();
    } else if (reply == "n" || reply == "N") {
      play = true;
    } else {
      continue;
    }
  } while (!play);
}
