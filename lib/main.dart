import 'package:animations/highscores.dart';
import 'package:flutter/material.dart';
import 'package:liquid_button/liquid_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './highscores.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar:AppBar(),
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/1.png"),
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.dstATop))),
            child: Container(
              margin: EdgeInsets.only(top: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp2()));
                      },
                      child: LiquidButton(
                        backgroundColor: Colors.yellow,
                        expandFactor: 5,
                        retainGradient: true,
                        gradientColor: Colors.green,
                        child: Text("Start Game",
                            style: TextStyle(color: Colors.white)),
                        width: 200,
                        height: 60,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HighScoresState()));
                      },
                      child: LiquidButton(
                        backgroundColor: Colors.yellow,
                        expandFactor: 5,
                        retainGradient: true,
                        gradientColor: Colors.green,
                        child: Text("Your High Scores",
                            style: TextStyle(color: Colors.white)),
                        width: 200,
                        height: 60,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        //Game Settings
                      },
                      child: LiquidButton(
                        backgroundColor: Colors.yellow,
                        expandFactor: 5,
                        retainGradient: true,
                        gradientColor: Colors.green,
                        child: Text("Game Settings",
                            style: TextStyle(color: Colors.white)),
                        width: 200,
                        height: 60,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
