import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class HighScoresState extends StatefulWidget {
  @override
  _HighScoresStateState createState() => _HighScoresStateState();
}

List li;

class _HighScoresStateState extends State<HighScoresState> {
  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    li = prefs.getStringList("highscores");
    li.sort();
    li = List.from(li.reversed);
    setState(() {
      li = li;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Container getElement(int i) {
    print(li[i]);

    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        child:
            Text(li[i], style: GoogleFonts.fredokaOne(color: Colors.green, fontSize: 20)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.yellow[50],
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                child: Center(
                  child: Text("HIGH SCORES",style:GoogleFonts.permanentMarker(fontSize:30,color:Colors.black,fontWeight:FontWeight.bold))
                ),
              ),
              if (li != []) for (int i = 0; i < (li.length); i++) getElement(i)
            ],
          )),
    );
  }
}
