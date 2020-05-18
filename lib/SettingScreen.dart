import 'package:animations/highscores.dart';
import 'package:flutter/material.dart';
import 'package:liquid_button/liquid_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './highscores.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './game.dart';
import './GameSettings.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
            color: Colors.black,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * .9,
                color: Colors.blue[900],
                child: FlatButton.icon(
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                         GameSettings.sounds = !GameSettings.sounds;
                      });

                    },
                    icon: Icon(Icons.speaker_group),
                    label: GameSettings.sounds
                        ? Text("Sound On")
                        : Text("Sound Off")),
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .4,
                          color: Colors.blue[900],
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () {
                                GameSettings.controltype = 1;
                              },
                              icon: Icon(Icons.speaker_group),
                              label: GameSettings.sounds
                                  ? Text("Sound On")
                                  : Text("Sound Off")),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .4,
                          color: Colors.blue[900],
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () {
                                GameSettings.controltype = 2;
                              },
                              icon: Icon(Icons.speaker_group),
                              label: GameSettings.sounds
                                  ? Text("Sound On")
                                  : Text("Sound Off")),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .4,
                          color: Colors.blue[900],
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () {
                                GameSettings.controltype = 3;
                              },
                              icon: Icon(Icons.speaker_group),
                              label: GameSettings.sounds
                                  ? Text("Sound On")
                                  : Text("Sound Off")),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .4,
                          color: Colors.blue[900],
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () {
                                GameSettings.controltype = 4;
                              },
                              icon: Icon(Icons.speaker_group),
                              label: GameSettings.sounds
                                  ? Text("Sound On")
                                  : Text("Sound Off")),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
