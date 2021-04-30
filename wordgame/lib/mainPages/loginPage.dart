import 'dart:io';
import "dart:async";
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:wordgame/sizes_helpers.dart';
import 'MainGamePage.dart';
// class Controller extends GetxController {
//  // final file = File('assets/musics/loginmusic.mp3');
//
//
//
//   void onInit(){
//     //initPlayer();
//   }
//
// }

class loginPage_Body extends StatelessWidget {


  @override

  Widget build(BuildContext context) {
  // _getScore();
    return Scaffold(
      body: SafeArea(
          child: Container(

            height: displayHeight(context),
            width: displayWidth(context),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/login.jpg",),
                  fit:BoxFit.cover,
                )
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top:50 ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom:90),
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color:Colors.amber.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Text(
                        "WORD GAME",
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom:50),
                      width: displayWidth(context)*0.3,
                      height: displayHeight(context)*0.2,
                      decoration: BoxDecoration(
                          color:Colors.green.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: IconButton(
                        icon: Icon(Icons.play_circle_outline,color:Colors.white,size: 90,),
                        onPressed: (){
                          Get.toNamed("/mainPage");

                        },
                      ),
                    ),
                    // Container(
                    //     padding: EdgeInsets.all(25),
                    //     decoration: BoxDecoration(
                    //         color:Colors.deepPurple.withOpacity(0.7),
                    //         borderRadius: BorderRadius.circular(25)
                    //     ),
                    //     child: Text("High Score: ${score}",style: TextStyle(fontSize: 40,color:Colors.white),)
                    // ),

                    Container(
                        margin: EdgeInsets.only(top:125),
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color:Colors.redAccent.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Text("BY ARDA AKŞİT",style: TextStyle(fontSize: 15,color:Colors.white),)
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  // Future _getScore() async {
  //   var tempScore;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tempScore = prefs.getInt("highScore");
  //   score = tempScore;
  //   print("high");
  //   print(prefs.getInt("highScore"));
  // }
}

