import 'dart:io';
import 'dart:math';

class Game {
  static int max = 100;
  static int input = max;
  int? _answer;
  int _count = 0;
  static var countList = <int>[];
  static var len = countList.length;

  Game({int? maxRandom}) {
    if(maxRandom == null){
      var r = Random();
      _answer = r.nextInt(max) + 1;
    }else{
      var r = Random();
      _answer = r.nextInt(maxRandom) + 1;
      input = maxRandom;
    }

  }

  void get getList{
    for (var i = 0; i < countList.length; i++) {
      print('🚀 Game #${i+1}: ${countList[i]} guesses');
    }
  }

  int get getcount{
    countList.add(_count);
    return _count;
  }

  int get maxRan{
    if(input == null){
      return max;
    }else{
      return input;
    }
  }

  int doGuess(int num) {
    _count += 1;
    if (num > _answer!) {
      return 1;
    } else if (num < _answer!) {
      return -1;
    } else {
      return 0;
    }
  }
}
