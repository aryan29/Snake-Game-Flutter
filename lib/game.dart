import 'dart:math';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './GameSettings.dart';
import 'dart:core';

/*
Auhtor Name - Aryan Khandelwal
College - BIT MESRA
Branch - IT
 */
final double BOARD_HEIGHT = 400;
final double BOARD_WIDTH = 360;
final double BLOCK_SIZE = 20;
final double INIT_HEIGHT = 60;
final double INIT_WIDTH = 40;
final assetsAudioPlayer = AssetsAudioPlayer();

final TIMEOUT = 500;
int score = 0;
Timer timer;
bool isStarted = false;
bool isRunning = false;

class boundary {
  static double left = INIT_WIDTH,
      right = INIT_WIDTH + BOARD_WIDTH,
      up = INIT_HEIGHT,
      down = INIT_HEIGHT + BOARD_HEIGHT;
}

class head {
  static double x, y;
}

class CakePos {
  static double posx, posy;
  static int type;
  static List scores = [1000, 50, 150];
}

Direction direction;
enum Direction { UP, DOWN, LEFT, RIGHT }
GlobalKey key = GlobalKey();
List<Positioned> snake = List();

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Container SnakePiece() {
  return Container(
    width: BLOCK_SIZE,
    height: BLOCK_SIZE,
    decoration: BoxDecoration(
        color: GameSettings.snakeColor,
        borderRadius: BorderRadius.circular(10)),
  );
}

BoxDecoration getCakeDecoration(int type) {
  if (type == 1) {
    return BoxDecoration(
        color: Colors.brown, borderRadius: BorderRadius.circular(25));
  } else if (type == 2) {
    return BoxDecoration(
        color: Colors.pink, borderRadius: BorderRadius.circular(1));
  } else if (type == 0) {
    return BoxDecoration(
        color: Colors.purple, borderRadius: BorderRadius.circular(5));
  }
}

Container Cake(int type) {
  return Container(
      width: BLOCK_SIZE,
      height: BLOCK_SIZE,
      decoration: getCakeDecoration(type));
}

class _MyHomePageState extends State<MyHomePage> {
  void letsmove() {
    if (isRunning && isStarted) {
      if (direction == Direction.RIGHT)
        moveright();
      else if (direction == Direction.LEFT)
        moveleft();
      else if (direction == Direction.DOWN)
        movedown();
      else if (direction == Direction.UP) moveup();
    }
  }

  Future<dynamic> openDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 230,
            child: SimpleDialog(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: (score > 1000)
                          ? NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTOMXAN0eSVZI3oQiYigeCcY0N2nOnbhrWqevC_EI5eN2ECWXKH&usqp=CAU")
                          : NetworkImage(
                              "https://hotemoji.com/images/dl/x/sad-emoji-by-google.png"),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    height: 80,
                    padding: EdgeInsets.only(top: 20),
                    color: (score > 1000) ? Colors.green : Colors.red,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text("Your Score $score",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                        ),
                        (score > 1000)
                            ? Center(
                                child: Text(
                                    "Hey Congo Share it with your friends"))
                            : Center(
                                child: Text("You should try again I think")),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                            height: 50,
                            width: 100,
                            child: (FlatButton(
                              color: Colors.yellow,
                              onPressed: () {
                                Share.share(
                                    "Hello Can you beat my High Score $score click https://aryan.ninja",
                                    subject: "Can you beat my score");
                              },
                              child: Text("Share"),
                            ))),
                        Container(
                          height: 50,
                          width: 100,
                          child: FlatButton(
                              color: Colors.yellow,
                              onPressed: () {},
                              child: Text("Retry")),
                        ),
                      ],
                    ))
              ],
            ),
          );
        });
  }

  dynamic update_leaderboard() async {
    // print("Here at Uploading Leaderboard");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> li = prefs.getStringList("highscores");
    // print(li);
    if (li == null)
      li = [score.toString()];
    else if (li.length < 5)
      li.add(score.toString());
    else {
      li.sort((a, b) {
        return int.parse(a).compareTo(int.parse(b));
      });
      if (score > int.parse(li[0])) li[0] = score.toString();
    }

    prefs.setStringList("highscores", li);
  }

  dynamic print_leaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> li = prefs.getStringList("highscores");
    // print(li);
  }

  void gameover() async {
    isStarted = false;
    isRunning = false;
    snake.clear();
    timer?.cancel();
    //Update the leaderboard
    print("Game Over");
    await update_leaderboard();
    // await print_leaderboard();
    await openDialog();
    score = 0;
  }

  void dosomething() async {
    if (GameSettings.sounds == true) {
      assetsAudioPlayer.open(Audio("assets/1.mp3"));
    }
    int type = CakePos.type;
    score += CakePos.scores[type];
    produce_cake();
    snake.add(Positioned(left: head.x, top: head.y, child: SnakePiece()));
  }

  bool containss(Positioned element) {
    for (Positioned e in snake) {
      if (e.left==element.left && e.top==element.top) return true;
    }
    return false;
  }

  void moveright() {
    // print("Moving Right");
    setState(() {
      head.x = head.x + BLOCK_SIZE;
      if (containss(Positioned(child: SnakePiece(), top: head.y, left: head.x)))
        gameover();
      if (head.x == CakePos.posx && head.y == CakePos.posy)
        dosomething();
      else {
        snake.removeAt(0);
        snake.add(Positioned(
          child: SnakePiece(),
          top: head.y,
          left: head.x,
        ));
      }
      if (head.x >= boundary.right) gameover();
      direction = Direction.RIGHT;
    });
  }

  void moveleft() {
    // print("Moving Left");
    setState(() {
      head.x = head.x - BLOCK_SIZE;
      if (containss(Positioned(child: SnakePiece(), top: head.y, left: head.x)))
        gameover();
      if (head.x == CakePos.posx && head.y == CakePos.posy)
        dosomething();
      else {
        snake.removeAt(0);
        snake.add(Positioned(child: SnakePiece(), top: head.y, left: head.x));
      }
      if (head.x < boundary.left) gameover();
      direction = Direction.LEFT;
    });
  }

  void moveup() {
    // print("Moving  Up");
    setState(() {
      head.y = head.y - BLOCK_SIZE;
      if (containss(Positioned(child: SnakePiece(), top: head.y, left: head.x)))
        gameover();
      if (head.x == CakePos.posx && head.y == CakePos.posy)
        dosomething();
      else {
        snake.removeAt(0);
        snake.add(Positioned(child: SnakePiece(), top: head.y, left: head.x));
      }
      if (head.y < boundary.up) gameover();
      direction = Direction.UP;
    });
  }

  void movedown() {
    setState(() {
      head.y = head.y + BLOCK_SIZE;
      if (containss(Positioned(child: SnakePiece(), top: head.y, left: head.x)))
        gameover();

      if (head.x == CakePos.posx && head.y == CakePos.posy)
        dosomething();
      else {
        snake.removeAt(0);
        snake.add(Positioned(child: SnakePiece(), top: head.y, left: head.x));
      }
      if (head.y >= boundary.down) gameover();
      direction = Direction.DOWN;
      // print("Direction Changed");
      // print(direction);
    });
  }

  void produce_cake() {
    //Sel a random pos bw
    //width 20 to 380
    //height 40 to 440
    int w = Random().nextInt(BOARD_WIDTH ~/ BLOCK_SIZE) * BLOCK_SIZE.toInt() +
        INIT_WIDTH.toInt();
    int ht = Random().nextInt(BOARD_HEIGHT ~/ BLOCK_SIZE) * BLOCK_SIZE.toInt() +
        INIT_HEIGHT.toInt();
    CakePos.posx = w.toDouble();
    CakePos.posy = ht.toDouble();
    List li = [1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 0];
    CakePos.type = li[Random().nextInt(li.length)];
  }

  Widget controls() {
    if (GameSettings.controltype == 1) {
      // print("Position for controlType 1");
      return Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
                height: 100,
                width: 100,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: GameSettings.bcolor,
                    heroTag: null,
                    child: Icon(Icons.keyboard_arrow_left),
                    onPressed: () {
                      if (direction != Direction.RIGHT &&
                          direction != Direction.LEFT &&
                          isRunning &&
                          isStarted) moveleft();
                    },
                  ),
                )),
            Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 100,
                    width: 100,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: GameSettings.bcolor,
                        heroTag: null,
                        child: Icon(Icons.keyboard_arrow_up),
                        onPressed: () {
                          if (direction != Direction.DOWN &&
                              direction != Direction.UP &&
                              isRunning &&
                              isStarted) moveup();
                        },
                      ),
                    )),
                Container(
                    height: 100,
                    width: 100,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: null,
                        backgroundColor: GameSettings.bcolor,
                        child: Icon(Icons.keyboard_arrow_down),
                        onPressed: () {
                          if (direction != Direction.UP &&
                              direction != Direction.DOWN &&
                              isRunning &&
                              isStarted) movedown();
                        },
                      ),
                    )),
              ],
            ),
            Container(
                height: 100,
                width: 100,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: GameSettings.bcolor,
                    heroTag: null,
                    child: Icon(Icons.keyboard_arrow_right),
                    onPressed: () {
                      if (direction != Direction.LEFT &&
                          direction != Direction.RIGHT &&
                          isRunning &&
                          isStarted) moveright();
                    },
                  ),
                )),
          ]));
    } else if (GameSettings.controltype == 2) {
      return Container(color: Colors.grey);
    } else if (GameSettings.controltype == 3) {
      // print("here");
      return Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              height: 200,
              width: 100,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: GameSettings.bcolor,
                  heroTag: null,
                  child: Icon(Icons.rotate_left),
                  onPressed: () {
                    if (direction == Direction.RIGHT && isRunning && isStarted)
                      moveup();
                    else if (direction == Direction.DOWN &&
                        isRunning &&
                        isStarted)
                      moveright();
                    else if (direction == Direction.LEFT &&
                        isRunning &&
                        isStarted)
                      movedown();
                    else if (direction == Direction.UP &&
                        isRunning &&
                        isStarted) moveleft();
                  },
                ),
              )),
          Container(
              height: 200,
              width: 100,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: GameSettings.bcolor,
                  heroTag: null,
                  child: Icon(Icons.rotate_right),
                  onPressed: () {
                    // print(direction);
                    if (direction == Direction.RIGHT &&
                        isRunning &&
                        isStarted) {
                      movedown();
                    } else if (direction == Direction.DOWN &&
                        isRunning &&
                        isStarted)
                      moveleft();
                    else if (direction == Direction.LEFT &&
                        isRunning &&
                        isStarted)
                      moveup();
                    else if (direction == Direction.UP &&
                        isRunning &&
                        isStarted) moveright();
                  },
                ),
              )),
        ],
      ));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onPanUpdate: (drag) {
        if (GameSettings.controltype == 2 && isRunning && isStarted) {
          print("Position for controlType 2");
          if (drag.delta.dx > 13 &&
              direction != Direction.LEFT &&
              direction != Direction.RIGHT) {
            // print("Moving Right\n");
            moveright();
          } else if (drag.delta.dx < -13 &&
              direction != Direction.RIGHT &&
              direction != Direction.LEFT) {
            // print("Moving Left\n");
            moveleft();
          } else if (drag.delta.dy > 13 &&
              direction != Direction.UP &&
              direction != Direction.DOWN) {
            // print("Moving Down\n");
            movedown();
          } else if (drag.delta.dy < -13 &&
              direction != Direction.DOWN &&
              direction != Direction.UP) {
            // print("Moving Up\n");
            moveup();
          }
        }
      },
      child: Container(
        color: GameSettings.bgcolor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Stack(children: [
              Container(
                  alignment: Alignment(0, -0.88),
                  color: GameSettings.bgcolor,
                  height: BOARD_HEIGHT + INIT_HEIGHT + 20,
                  width: BOARD_WIDTH + INIT_WIDTH + 20,
                  child: Text(
                    "Score $score",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 17),
                  )),
              Positioned(
                left: INIT_WIDTH,
                top: INIT_HEIGHT,
                height: BOARD_HEIGHT,
                width: BOARD_WIDTH,
                child: Container(
                  key: key,
                  height: BOARD_HEIGHT,
                  width: BOARD_WIDTH,
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              for (var i in snake) i,
              Container(
                child: isStarted
                    ? Positioned(
                        left: CakePos.posx,
                        top: CakePos.posy,
                        child: Cake(CakePos.type))
                    : null,
              )
            ]),
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 50,
                    child: FlatButton.icon(
                      textColor: Colors.white,
                      color: GameSettings.bcolor,
                      onPressed: () {
                        if (!isStarted) {
                          isStarted = true;
                          isRunning = true;
                          snake.clear();
                          snake.add(Positioned(
                              left: INIT_WIDTH,
                              top: INIT_HEIGHT,
                              child: SnakePiece()));
                          snake.add(Positioned(
                              left: INIT_WIDTH + 20,
                              top: INIT_HEIGHT,
                              child: SnakePiece()));
                          produce_cake();
                          head.x = INIT_WIDTH + 20;
                          head.y = INIT_HEIGHT;
                          direction = Direction.RIGHT;
                          timer = new Timer.periodic(
                              new Duration(milliseconds: TIMEOUT),
                              (Timer t) => letsmove());
                        }
                      },
                      icon: Icon(
                        Icons.star,
                        size: 30,
                      ),
                      label: Text("Start"),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: FlatButton.icon(
                      textColor: Colors.white,
                      color: GameSettings.bcolor,
                      onPressed: () {
                        setState(() {
                          isRunning = !isRunning;
                        });
                      },
                      icon: isRunning
                          ? Icon(Icons.pause, size: 30)
                          : Icon(Icons.play_arrow, size: 30),
                      label: isRunning ? Text("Pause") : Text("Resume"),
                    ),
                  ),
                ],
              ),
            ),
            controls()
          ],
        ),
      ),
    ));
  }
}
