import 'package:flutter/material.dart';
import '../data/AlarmSettingData.dart';

class ModifyAlarmPage extends StatefulWidget {
  final AlarmSettingData alarmSettingData;
  final Function(AlarmSettingData) modifiedAlarmData;

  ModifyAlarmPage({
    required this.alarmSettingData,
    required this.modifiedAlarmData,
  });

  @override
  _ModifyAlarmPageState createState() => _ModifyAlarmPageState();
}


class _ModifyAlarmPageState extends State<ModifyAlarmPage> {
  late TimeOfDay _selectedTime = widget.alarmSettingData.selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  late Map<String, bool> weekdays = widget.alarmSettingData.weekdays;

  List<String> alarmBell = ['무음', '알람음1', '알람음2'];
  late String selectedAlarmBell = widget.alarmSettingData.selectedAlarmBell;

  List<String> alarmRingAgain = ['사용 안 함', '5분, 3회', '5분, 5회', '10분, 2회', '10분, 3회'];
  late String selectedAlarmRingAgain = widget.alarmSettingData.selectedAlarmRingAgain;

  List<String> alarmOffMission = ['사용 안 함', '바코드 찍기', '수학 문제 풀기'];
  late String selectedAlarmOffMission = widget.alarmSettingData.selectedAlarmOffMission;



  AlarmSettingData _alarmSettingData () {
    return AlarmSettingData(
      selectedTime: _selectedTime,
      weekdays: weekdays,
      selectedAlarmBell: selectedAlarmBell,
      selectedAlarmRingAgain: selectedAlarmRingAgain,
      selectedAlarmOffMission: selectedAlarmOffMission
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      appBar: AppBar(
        title: Text('알람 수정',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade900,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///////////// 시간 선택
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
            alignment: Alignment.center,
            child: GestureDetector(
                onTap: () {
                  _selectTime(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_selectedTime.period == DayPeriod.am ? 'AM' : 'PM'} ',
                      style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_selectedTime.hourOfPeriod.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 100, color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                )
            ),
          ),


          ///////////// 요일 선택
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: weekdays.keys.map((String key) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      weekdays[key] = !weekdays[key]!;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Text(
                      key,
                      style: TextStyle(
                        fontSize: 40.0,
                        color: weekdays[key]! ? Colors.orange.shade900 : Colors.white,
                      ),
                    ),
                  ),
                );
              }
              ).toList(),
            ),
          ),


          ///////////// 알람음 선택
          Container(
            padding: EdgeInsets.only(left:20, top:50, right:20, bottom:0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "알림음",style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.shade900,
                      ),
                      width: 200,
                      child: DropdownButton<String>(
                        padding: EdgeInsets.only(left: 15),
                        value: selectedAlarmBell,
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.orange.shade900,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAlarmBell = newValue!;
                          });
                        },
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        underline: Container(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        items: alarmBell.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                      )
                  ),
                ]
            ),
          ),

          ///////////// 다시 울림
          Container(
            padding: EdgeInsets.only(left:20, top:30, right:20, bottom:0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "다시 울림",style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.shade900,
                      ),
                      width: 200,
                      child: DropdownButton<String>(
                        padding: EdgeInsets.only(left: 15),
                        value: selectedAlarmRingAgain,
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.orange.shade900,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAlarmRingAgain = newValue!;
                          });
                        },
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        underline: Container(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        items: alarmRingAgain.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                      )
                  ),
                ]
            ),
          ),


          ///////////// 알람 끄기 미션
          Container(
            padding: EdgeInsets.only(left:20, top:30, right:20, bottom:0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "알람 끄기 미션",style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.shade900,
                      ),
                      width: 200,
                      child: DropdownButton<String>(
                        padding: EdgeInsets.only(left: 15),
                        value: selectedAlarmOffMission,
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.orange.shade900,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAlarmOffMission = newValue!;
                          });
                        },
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        underline: Container(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        items: alarmOffMission.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                      )
                  ),
                ]
            ),
          ),

          Spacer(),

          ///////////// 취소, 저장 버튼
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
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor : Colors.orange.shade900,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            child: Text('취소', style: TextStyle(fontSize: 20, color: Colors.white)),
                          ),
                        )
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              widget.modifiedAlarmData(_alarmSettingData());
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor : Colors.orange.shade900,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            child: Text('저장', style: TextStyle(fontSize: 20, color: Colors.white)),
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