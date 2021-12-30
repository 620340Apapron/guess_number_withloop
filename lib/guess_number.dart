// ignore_for_file: avoid_print

import 'dart:io';
import 'game.dart';

void main() {
  var play = true;
  var game = Game();
  playgame();
  do {
    stdout.write('Play again? (Y/N): ');
    var reply = stdin.readLineSync();

    if (reply == 'y' || reply == 'Y') {
      playgame();
    } else if (reply == 'n' || reply == 'N') {
      play = false;
    } else {
      continue;
    }
  } while (play);
  print('You have played ${Game.len} games');
  game.getList;

}

class playgame {
  var isCorrect = false;
  int? numRandom;

  playgame() {
    stdout.write('Enter a maximum number to random : ');
    var numInput = stdin.readLineSync();
    if(numInput != null){
      numRandom = int.tryParse(numInput);
    }
    var game = Game(maxRandom: numRandom);

    print('╔════════════════════════════════════════');
    print('║            GUESS THE NUMBER            ');
    print('╟────────────────────────────────────────');

    do {

      stdout.write('║ Guess the number between 1 and ${game.maxRan}: ');
      var input = stdin.readLineSync();
      var guess = int.tryParse(input!);
      if (guess == null) {
        continue;
      }

      var result = game.doGuess(guess);
      if (result == 1) {
        print('║ ➜ $guess is TOO HIGH! ▲');
        print('╟────────────────────────────────────────');
      } else if (result == -1) {
        print('║ ➜ $guess is TOO LOW! ▼');
        print('╟────────────────────────────────────────');
      } else {
        print('║ ➜ $guess is CORRECT ❤, total guesses: ${game.getcount}');
        print('╟────────────────────────────────────────');
        isCorrect = true;

      }
    } while (!isCorrect);

    print('║                 THE END                ');
    print('╚════════════════════════════════════════');
  }
}