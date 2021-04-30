import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wordgame/Arrays/WordArrays.dart';
import 'package:wordgame/mainPages/loginPage.dart';
import 'dart:math';
import 'package:wordgame/sizes_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordgame/pages/colors.dart';

class Controller extends GetxController {
  Timer timerr;
  var score = 0.obs;

  increment() => score++;
  var time = 0.obs;
  var ranHead = 0.obs;

  RandomHead() {
    ranHead = Random().nextInt(4).obs;
    if (ranHead == 0) {
      ranHead = ran1;
    } else if (ranHead == 1) {
      ranHead = ran2;
    } else if (ranHead == 2) {
      ranHead = ran3;
    } else if (ranHead == 3) {
      ranHead = ran4;
    }
    print("head");
    print(ranHead);
    update();
  }

  var ran1 = 0.obs;
  var ran2 = 0.obs;
  var ran3 = 0.obs;
  var ran4 = 0.obs;

  randomOther() {
    ran1 = Random().nextInt(fakeTr.length).obs;
    ran2 = Random().nextInt(fakeTr.length).obs;
    ran3 = Random().nextInt(fakeTr.length).obs;
    ran4 = Random().nextInt(fakeTr.length).obs;
    if (ran2 == ran1 || ran1 == ran3 || ran1 == ran4) {
      while (ran2 == ran1 || ran1 == ran3 || ran1 == ran4) {
        ran1 = Random().nextInt(fakeTr.length).obs;
      }
    }
    if (ran2 == ran1 || ran2 == ran3 || ran2 == ran4) {
      while (ran2 == ran1 || ran2 == ran3 || ran2 == ran4) {
        ran2 = Random().nextInt(fakeTr.length).obs;
      }
    }
    if (ran3 == ran1 || ran3 == ran2 || ran3 == ran4) {
      while (ran3 == ran1 || ran3 == ran2 || ran3 == ran4) {
        ran3 = Random().nextInt(fakeTr.length).obs;
      }
    }
    if (ran4 == ran1 || ran4 == ran2 || ran3 == ran4) {
      while (ran4 == ran1 || ran4 == ran2 || ran3 == ran4) {
        ran4 = Random().nextInt(fakeTr.length).obs;
      }
    }
    print("sayılar");
    print(ran1);
    print(ran2);
    print(ran3);
    print(ran4);

    update();
  }

  var fakeTr = [].toList().obs;
  var fakeEn = [].toList().obs;
  var fakeImage = [].toList().obs;
  var backImage = [
    "assets/back/b1.jpg",
    "assets/back/b2.jpg",
    "assets/back/b3.jpg",
    "assets/back/b4.jpg",
    "assets/back/b5.jpg",
    "assets/back/b6.jpg"
  ].toList();

  fakeTranslate() {
    for (var i = 0; i < wordArrayTr.length; i++) {
      fakeTr.add(wordArrayTr[i]);
      fakeEn.add(wordArrayEng[i]);
      fakeImage.add(imageArray[i]);
    }
    update();
    print("image");
    print(fakeImage.length);
  }

  selectControl(int num, BuildContext context) {
    if (ranHead == num) {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: displayHeight(context) * 0.4,
              child: AlertDialog(
                backgroundColor: Colors.green,
                title: Icon(Icons.check_circle_sharp,
                    color: Colors.white, size: 75),
                content: Container(
                    height: displayHeight(context) * 0.07,
                    child: Center(
                        child: Text(
                      "Congratulations!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 35),
                    ))),
                actions: [
                  IconButton(
                    icon: Icon(Icons.home_filled, color: Colors.white),
                    iconSize: 50,
                    onPressed: () {
                      //  saveHighScore(score);
                      //  scoreSave(0);
                      //  _saveHighScore(score.toInt());
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => loginPage_Body(),
                        ),
                        (route) => false,
                      );

                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right_alt_outlined,
                        color: Colors.white),
                    iconSize: 50,
                    onPressed: () {
                      timerr.cancel();
                      var t = 12 - time.toInt();
                      time += t;
                      score += 10;
                      print("girdi");
                      deleteItem();
                      randomOther();
                      RandomHead();

                      _saveScore();

                      _getScore();


                      //      Allbody(context,Get.put(Controller()));
                      // saveHighScore(score);
                      //scoreSave(0);
                      Navigator.pop(context);
                      time_func();
                    },
                  ),
                ],
              ),
            );
          });
    } else {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: displayHeight(context) * 0.4,
              child: AlertDialog(
                backgroundColor: Colors.red,
                title: Icon(Icons.cancel, color: Colors.white, size: 75),
                content: Container(
                    height: displayHeight(context) * 0.07,
                    child: Center(
                        child: Text(
                      "Unfortunately",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 35),
                    ))),
                actions: [
                  IconButton(
                    icon: Icon(Icons.home_filled, color: Colors.white),
                    iconSize: 50,
                    onPressed: () {
                      _resetScore();
                      // time += 12;
                      // time_func();
                      timerr.cancel();
                      time -=time.toInt();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => loginPage_Body(),
                        ),
                        (route) => false,
                      );
                      //  Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
    }
  }

  deleteItem() {
    fakeImage.removeAt(ranHead.toInt());
    fakeEn.removeAt(ranHead.toInt());
    fakeTr.removeAt(ranHead.toInt());
    print("fake");
    print(fakeTr.length);
    update();
  }

  Future _saveScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("score", score.toInt());
  }

  Future _getScore() async {
    var tempScore;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tempScore = prefs.getInt("score");
    score = tempScore;
  }

  Future _resetScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("score", 0);
  }

  // Future _saveHighScore(int nowScore) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (nowScore > score.toInt()) {
  //     await prefs.setInt("highScore", score.toInt());
  //     print("high1");print(score);
  //   }
  // }

  time_func() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      time--;
      timerr = timer;
      if (time == 0) {
        timer.cancel();
        Get.defaultDialog(
            title: " ",
            titleStyle: TextStyle(color: Colors.red),
            middleText: "Time's Up!!",
            middleTextStyle: TextStyle(color: Colors.red, fontSize: 25),
            barrierDismissible: false,
            actions: [
              IconButton(
                icon: Icon(Icons.home_filled, color: Colors.red),
                iconSize: 50,
                onPressed: () {
                  //  _saveHighScore(score.toInt());
                  time -=time.toInt();
                  time+=12;

                  _resetScore();
                  //Get.toNamed("/");
                  Get.offAll(loginPage_Body());
                  // Get.back();
                },
              ),
            ]);
      }
    });
  }

  void onInit() {
    time += 12;
    _resetScore();
    randomColors();
    fakeTranslate();
    randomOther();
    RandomHead();
    time_func();
    super.onInit();
  }
}

class maingamePage extends StatelessWidget {
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.only(top: 0),
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(c.backImage[Random().nextInt(6)]),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25)
            ),
            child: IconButton(
                onPressed: () {
                  c.timerr.cancel();
                  c.time -= c.time.toInt();
                  c.time +=12;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => loginPage_Body(),
                    ),
                        (route) => false,
                  );
                } ,
                icon: Icon(
                  Icons.home_filled,
                  size: 50,
                  color:Colors.white
                )),
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                    width: displayWidth(context) * 0.3,
                    height: displayHeight(context) * 0.05,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: container5,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Obx(() => Text(
                            "TIME: ${c.time}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          )),
                    )),
                Container(
                  width: displayWidth(context) * 0.3,
                  height: displayHeight(context) * 0.05,
                  decoration: BoxDecoration(
                    color: container6,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Obx(() => Text(
                          "SCORE: ${c.score}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: displayWidth(context) * 0.6,
            height: displayHeight(context) * 0.08,
            color: container7,
            margin: EdgeInsets.only(top: 25),
            child: Center(
                child: Obx(() => Text(
                      "${c.fakeEn[c.ranHead.toInt()]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ))),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.only(top: 60, left: 10, right: 10),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: [
                GestureDetector(
                  onTap: () {
                    c.selectControl(c.ran1.toInt(), context);
                  },
                  child: Container(
                    color: container1,
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Obx(
                          () => Image.asset(
                            '${c.fakeImage[c.ran1.toInt()]}',
                            height: 100,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Obx(() => Text(
                              "${c.fakeTr[c.ran1.toInt()]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            )),
                      ),
                    ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.selectControl(c.ran2.toInt(), context);
                  },
                  child: Container(
                    color: container2,
                    child: Column(children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Obx(
                            () => Image.asset(
                              '${c.fakeImage[c.ran2.toInt()]}',
                              height: 100,
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Obx(
                            () => Text(
                              "${c.fakeTr[c.ran2.toInt()]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          )),
                    ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.selectControl(c.ran3.toInt(), context);
                  },
                  child: Container(
                    color: container3,
                    child: Column(children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Obx(
                            () => Image.asset(
                              '${c.fakeImage[c.ran3.toInt()]}',
                              height: 100,
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Obx(
                            () => Text(
                              "${c.fakeTr[c.ran3.toInt()]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          )),
                    ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.selectControl(c.ran4.toInt(), context);
                  },
                  child: Container(
                    color: container4,
                    child: Column(children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Obx(
                            () => Image.asset(
                              '${c.fakeImage[c.ran4.toInt()]}',
                              height: 100,
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Obx(
                            () => Text(
                              "${c.fakeTr[c.ran4.toInt()]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          )),
                    ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    )));
  }
}
