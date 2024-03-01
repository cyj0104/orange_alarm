import 'dart:math';
import 'package:flutter/material.dart';

class SolveArithmeticMissionPage extends StatefulWidget {
  @override
  _SolveArithmeticMissionPageState createState() => _SolveArithmeticMissionPageState();
}

class _SolveArithmeticMissionPageState extends State<SolveArithmeticMissionPage>{
  int randomNumber1 = Random().nextInt(101);
  int randomNumber2 = Random().nextInt(101);
  late int correctAnswer = randomNumber1 - randomNumber2;
  String userAnswer = '';


  void attachNumber(String number) {
    if (number == '0' && userAnswer == '') {
      return;
    }
    if (userAnswer.length < 3 ) {
      setState(() {
        userAnswer += number;
      });
    }
  }

  void toggleSign() {
    if (!userAnswer.contains('-')) {
      setState(() {
        userAnswer = '-' + userAnswer;
      });
    }
    else {
      setState(() {
        userAnswer = userAnswer.replaceFirst('-', '');
      });
    }
  }

  void checkAnswer() {
    setState(() {
      if (correctAnswer.toString() == userAnswer) {
        userAnswer = 'Correct!!';   // 알람 끄기 요청해야함
      }
      else {
        userAnswer = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      body: Column(
        children: [

          Container(
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Text(
                '${randomNumber1} - ${randomNumber2} ',
                style: TextStyle(fontSize: 70, color: Colors.white),
              ),
          ),


          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              '=  ${userAnswer}',
              style: TextStyle(fontSize: 70, color: Colors.white),
            ),
          ),

          /////////// 7 , 8, 9 버튼
           Container(
             padding: EdgeInsets.only(top: 20, left: 20, right: 20),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Expanded(
                  child:Container(
                    padding: EdgeInsets.only(right: 5),
                    child: ElevatedButton(
                      onPressed: () => attachNumber('7'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('7', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                 ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child:ElevatedButton(
                      onPressed: () => attachNumber('8'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('8', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  child:ElevatedButton(
                      onPressed: () => attachNumber('9'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('9', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                ),
               ],
             ),
           ),


          /////////// 4, 5, 6 버튼
          Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child:Container(
                    padding: EdgeInsets.only(right: 5),
                    child: ElevatedButton(
                      onPressed: () => attachNumber('4'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('4', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child:ElevatedButton(
                      onPressed: () => attachNumber('5'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('5', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 5),
                    child:ElevatedButton(
                      onPressed: () => attachNumber('6'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('6', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),



          /////////// 1, 2, 3 버튼
          Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child:Container(
                    padding: EdgeInsets.only(right: 5),
                    child: ElevatedButton(
                      onPressed: () => attachNumber('1'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('1', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child:ElevatedButton(
                      onPressed: () => attachNumber('2'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('2', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 5),
                    child:ElevatedButton(
                      onPressed: () => attachNumber('3'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('3', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),


          /////////// +/-, 0, ↵ 버튼
          Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 5),
                    child: ElevatedButton(
                      onPressed: () => toggleSign(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('+/-', style: TextStyle(fontSize: 35, color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child:ElevatedButton(
                      onPressed: () => attachNumber('0'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('0', style: TextStyle(fontSize: 70, color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 5),
                    child:ElevatedButton(
                      onPressed: () => checkAnswer(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor : Colors.orange.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          minimumSize: Size(100, 100)
                      ),
                      child: Text('⏎', style: TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

}