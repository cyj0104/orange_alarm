import 'dart:async';
import 'package:flutter/material.dart';
import 'package:orange_alarm/page/BarcodeScanMission.dart';
import 'SolveArithmeticMission.dart';


class SnoozeAndTurnOffAlarmPageWithoutMission extends StatefulWidget {
  final Function() stopAlarmSound;
  final Function() stopTimerForAlarmAgain;

  SnoozeAndTurnOffAlarmPageWithoutMission({
    required this.stopAlarmSound,
    required this.stopTimerForAlarmAgain,
  });

  @override
  _SnoozeAndTurnOffAlarmPageWithoutMissionState createState() => _SnoozeAndTurnOffAlarmPageWithoutMissionState();
}

class _SnoozeAndTurnOffAlarmPageWithoutMissionState extends State<SnoozeAndTurnOffAlarmPageWithoutMission> {
  late TimeOfDay _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = TimeOfDay.now();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1),(Timer timer) {
        TimeOfDay newTime = TimeOfDay.now();
        if (_currentTime.hour != newTime.hour || _currentTime.minute != newTime.minute) {
          setState(() {
            _currentTime = newTime;
          });
        }
      }
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.blueGrey.shade800,
      body: Column(
        children: [
          ////////// 현재 시간 표시
          Padding(
            padding: EdgeInsets.only(top:70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_currentTime.period == DayPeriod.am ? 'AM' : 'PM'}  ',
                  style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_currentTime.hourOfPeriod.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 95, color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          Spacer(),

          ////// 알람 미루기, 알람 끄기 버튼
          Container(
              padding: EdgeInsets.only(bottom:40),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left:10, right: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              widget.stopAlarmSound();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor : Colors.orange.shade900,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                minimumSize: Size(double.infinity, 50)
                            ),
                            child: Text('알람 미루기', style: TextStyle(fontSize: 20, color: Colors.white)),
                          ),
                        )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              widget.stopAlarmSound();
                              widget.stopTimerForAlarmAgain();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor : Colors.orange.shade900,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                minimumSize: Size(double.infinity, 50)
                            ),
                            child: Text('알람 끄기', style: TextStyle(fontSize: 20, color: Colors.white)),
                          ),
                        )
                    )
                  ]
              )
          ),

        ],
      ),
    );
  }
}