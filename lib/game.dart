import 'dart:io';
import 'dart:math';

class Game {
  static const maxRandoom = 100;
  int? _answer;
  var count = 0;

  Game() {
    var r = Random();
    _answer = r.nextInt(maxRandoom) + 1;
  }

  int doGuess(int num) {
    if (num > _answer!) {
      return 1;
    } else if (num < _answer!) {
      return -1;
    } else {
      return 0;
    }
  }

  void guessCount() {
    count++;
  }

  int getCount() {
    return count;
  }
}

class playgame {
  static const maxRandom = 100;
  var isCorrect = false;

  playgame() {
    var game = Game();
    var count = game.getCount();

    print('╔════════════════════════════════════════');
    print('║            GUESS THE NUMBER            ');
    print('╟────────────────────────────────────────');

    do {
      stdout.write('║ Guess the number between 1 and $maxRandom: ');
      var input = stdin.readLineSync();
      var guess = int.tryParse(input!);
      if (guess == null) {
        continue;
      }

      var result = game.doGuess(guess);
      game.guessCount();

      if (result == 1) {
        print('║ ➜ $guess is TOO HIGH! ▲');
        print('╟────────────────────────────────────────');
      } else if (result == -1) {
        print('║ ➜ $guess is TOO LOW! ▼');
        print('╟────────────────────────────────────────');
      } else {
        print('║ ➜ $guess is CORRECT ❤, total guesses: $count');
        print('╟────────────────────────────────────────');
        isCorrect = true;
      }
    } while (!isCorrect);

    print('║                 THE END                ');
    print('╚════════════════════════════════════════');
  }
}
