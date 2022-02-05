import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  late Game _game;
  static const buttonSize = 60.0;
  HomePage({Key? key}) : super(key: key) {
    _game = Game(maxRandom: 100);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _inputstate = '';
  String _message = '';

  void _showOkDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 90.0),
                    SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GUESS',
                            style:
                                TextStyle(fontSize: 36.0, color: Colors.black)),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_inputstate,
                    style: TextStyle(fontSize: 50.0, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_message,
                    style: TextStyle(fontSize: 20.0, color: Colors.black)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton(1),
                  buildButton(2),
                  buildButton(3),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton(4),
                  buildButton(5),
                  buildButton(6),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton(7),
                  buildButton(8),
                  buildButton(9),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton(-2),
                  buildButton(0),
                  buildButton(-1),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('GUESS',
                      style: TextStyle(fontSize: 15.0, color: Colors.black)),
                  onPressed: () {
                    var input = _inputstate;
                    var guess = int.tryParse(input);
                    if (guess == null) {
                      _showOkDialog(context, 'ERROR',
                          'กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น');
                      return;
                    }
                    var guessResult = widget._game.doGuess(guess);
                    if (guessResult > 0) {
                      _message = '$guess มากเกินไป';
                    } else if (guessResult < 0) {
                      _message = '$guess น้อยเกินไป';
                    } else {
                      _message =
                          '$guess ถูกต้อง คุณทายทั้งหมด ${widget._game.guessCount} ครั้ง';
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(int num) {
    Widget? child;
    if (num == -1) {
      child = Icon(Icons.backspace);
    } else if (num == -2) {
      child = Icon(Icons.delete);
    } else {
      child = Text('$num');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (num == -1) {
            print('Backspace');
            setState(() {
              var length = _inputstate.length;
              _inputstate = _inputstate.substring(0, length - 1);
              child = Icon(Icons.backspace);
            });
          } else if (num == -2) {
            print('Delete');
            setState(() {
              var length = _inputstate.length;
              _inputstate = _inputstate.substring(0, 0);
              child = Icon(Icons.delete);
            });
          } else {
            print('$num');
            setState(() {
              _inputstate = '$_inputstate$num';
            });
            child = Text('$num');
          }
        },
        borderRadius: BorderRadius.circular(HomePage.buttonSize / 2),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2.0),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          width: HomePage.buttonSize,
          height: HomePage.buttonSize,
          child: Container(child: child
          ),
        ),
      ),
    );
  }
}
