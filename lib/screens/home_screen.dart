import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'first_game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var player = new AudioCache();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/logo.jpeg", height: 50, width: 50,),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FirstGame()));
                      },
                          child: Image.asset("assets/images/power_button.jpg", height: 100, width: 100,)),
                    ],
                  )),

              //SizedBox(height: 10,),
              Expanded(
                flex: 1,
                child: Text("هيا لنلعب ونتعلَّم البرمجة", style: TextStyle(

                  fontSize: 18,
                  color: Colors.black,
                ),),
              )
            ],
          )
      ),
    );
  }
}
