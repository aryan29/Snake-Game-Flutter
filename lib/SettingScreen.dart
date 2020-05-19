import 'package:animations/highscores.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_button/liquid_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './highscores.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './game.dart';
import './GameSettings.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/*
Auhtor Name - Aryan Khandelwal
College - BIT MESRA
Branch - IT
 */
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
                Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * .9,
                color: Colors.blue[900],
                child: FlatButton.icon(
                    textColor: Colors.white,
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool("sounds", !GameSettings.sounds);
                      setState(() {
                        GameSettings.sounds = !GameSettings.sounds;
                      });
                      if (GameSettings.sounds == true) {
                        assetsAudioPlayer.open(Audio("assets/2.mp3"));
                      }
                    },
                    icon: Icon(Icons.speaker_group),
                    label: GameSettings.sounds
                        ? Text("Sound On")
                        : Text("Sound Off")),
              ),
              Center(
                  child: Text("Controls",
                      style: GoogleFonts.abhayaLibre(
                          color: Colors.white, fontSize: 25))),
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
                              onPressed: () async {
                                if (GameSettings.sounds == true) {
                                  assetsAudioPlayer.open(Audio("assets/2.mp3"));
                                }
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setInt("controltype", 1);
                                GameSettings.controltype = 1;
                              },
                              icon: Icon(Icons.perm_device_information),
                              label: Text("Tap")),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .4,
                          color: Colors.blue[900],
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () async {
                                if (GameSettings.sounds == true) {
                                  assetsAudioPlayer.open(Audio("assets/2.mp3"));
                                }
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setInt("controltype", 2);
                                GameSettings.controltype = 2;
                              },
                              icon: Icon(Icons.touch_app),
                              label: Text("Touch")),
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
                              onPressed: () async {
                                if (GameSettings.sounds == true) {
                                  assetsAudioPlayer.open(Audio("assets/2.mp3"));
                                }
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setInt("controltype", 3);
                                GameSettings.controltype = 3;
                              },
                              icon: Icon(Icons.rotate_90_degrees_ccw),
                              label: Text("Rotate")),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .4,
                          color: Colors.blue[900],
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () async {
                                if (GameSettings.sounds == true) {
                                  assetsAudioPlayer.open(Audio("assets/2.mp3"));
                                }
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setInt("controltype", 4);
                                GameSettings.controltype = 4;
                              },
                              icon: Icon(Icons.speaker_group),
                              label: Text("Not Functional")),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                  child: Text("Color Picker",
                      style: GoogleFonts.abhayaLibre(
                          color: Colors.white, fontSize: 25))),
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
                          color: GameSettings.snakeColor,
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () async {
                                if (GameSettings.sounds == true) {
                                  assetsAudioPlayer.open(Audio("assets/2.mp3"));
                                }

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Pick Color of Snake"),
                                        content: SingleChildScrollView(
                                            child: ColorPicker(
                                                onColorChanged:
                                                    (Color c) async {
                                                  setState(() {
                                                    GameSettings.snakeColor = c;
                                                  });
                                                },
                                                pickerColor:
                                                    GameSettings.snakeColor,
                                                showLabel: true,
                                                pickerAreaHeightPercent: 0.8,


                                                )),
                                                    actions: <Widget>[
      FlatButton(
        child: const Text('Got it'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
                                      );
                                    });
                              },
                              icon: Icon(Icons.speaker_group),
                              label: Text("Snake Color")),
                        ),

                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .4,
                          color: GameSettings.bcolor,
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () async {
                                if (GameSettings.sounds == true) {
                                  assetsAudioPlayer.open(Audio("assets/2.mp3"));
                                }

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Pick Control Buttons Color"),
                                        content: SingleChildScrollView(
                                            child: ColorPicker(
                                                onColorChanged:
                                                    (Color c) async {
                                                  setState(() {
                                                    GameSettings.bcolor = c;
                                                  });
                                                },
                                                pickerColor:
                                                    GameSettings.snakeColor,
                                                showLabel: true,
                                                pickerAreaHeightPercent: 0.8,


                                                )),
                                                    actions: <Widget>[
      FlatButton(
        child: const Text('Got it'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
                                      );
                                    });
                              },
                              icon: Icon(Icons.speaker_group),
                              label: Text("Buttons Color")),
                        ),

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .4,
                          color: GameSettings.bgcolor,
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () async {
                                if (GameSettings.sounds == true) {
                                  assetsAudioPlayer.open(Audio("assets/2.mp3"));
                                }

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Pick Color of Background"),
                                        content: SingleChildScrollView(
                                            child: ColorPicker(
                                                onColorChanged:
                                                    (Color c) async {
                                                  setState(() {
                                                    GameSettings.bgcolor = c;
                                                  });
                                                },
                                                pickerColor:
                                                    GameSettings.snakeColor,
                                                showLabel: true,
                                                pickerAreaHeightPercent: 0.8,


                                                )),
                                                    actions: <Widget>[
      FlatButton(
        child: const Text('Got it'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
                                      );
                                    });
                              },
                              icon: Icon(Icons.speaker_group),
                              label: Text("Back Color")),
                        ),

                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .4,
                          color: Colors.blue[900],
                          child: FlatButton.icon(
                              textColor: Colors.white,
                              onPressed: () async {
                                if (GameSettings.sounds == true) {
                                  assetsAudioPlayer.open(Audio("assets/2.mp3"));
                                }

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Non Functional "),
                                        content: SingleChildScrollView(
                                            child: ColorPicker(
                                                onColorChanged:
                                                    (Color c) async {
                                                },
                                                pickerColor:
                                                    GameSettings.snakeColor,
                                                showLabel: true,
                                                pickerAreaHeightPercent: 0.8,


                                                )),
                                                    actions: <Widget>[
                                                      FlatButton(
                                           child: const Text('Got it'),
                                           onPressed: () {
                                          Navigator.of(context).pop();
                                            },
                                         ),
                                             ],
                                      );
                                    });
                              },
                              icon: Icon(Icons.speaker_group),
                              label: Text("Non Functional")),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
