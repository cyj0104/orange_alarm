import 'dart:async';
import 'package:flutter/material.dart';
import 'SolveArithmeticMission.dart';


class TurnOffAlarmPage extends StatefulWidget {
  TurnOffAlarmPage({super.key});

  @override
  _TurnOffAlarmPageState createState() => _TurnOffAlarmPageState();
}

class _TurnOffAlarmPageState extends State<TurnOffAlarmPage> {
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

  List<String> changeAlarmOffMission = ['바코드 찍기', '수학 문제 풀기'];
  String? selectedChangeAlarmOffMission; // 알람 생성 및 알람 수정 시 선택한 알람 끄기 미션 정보를 넣어줘야 함.

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
                  style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_currentTime.hourOfPeriod.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 115, color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          Spacer(),

          /////// 알람 끄기 미션 바꾸기
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange.shade900,
                ),
                child: DropdownButton<String>(
                  padding: EdgeInsets.only(left: 20),
                  value: selectedChangeAlarmOffMission,
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.orange.shade900,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedChangeAlarmOffMission = newValue;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  underline: Container(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  items: changeAlarmOffMission.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                )
            ),
          ),


          ////// 알람 끄기 버튼
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom:20),
              child: ElevatedButton(
                onPressed: () {
                  // 조건에 따라서 미션 화면 이동하도록 구현
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SolveArithmeticMissionPage()),
                  );
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
          ),

        ],
      ),
    );
  }
}