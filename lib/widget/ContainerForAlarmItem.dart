import "dart:async";
import "dart:io";

import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";

import "../data/AlarmSettingData.dart";
import "../page/ModifyAlarmPage.dart";
import "../page/SnoozeAndTurnOffAlarmPage.dart";
import "../page/SnoozeAndTurnOffAlarmPageWithoutMission.dart";
import "../page/TurnOffAlarmPage.dart";
import "../page/TurnOffAlarmPageWithoutMission.dart";

class ContainerForAlarmItem extends StatefulWidget {
  @override
  final Key key;
  final Function(Key) onRemove;

  AlarmSettingData alarmSettingData;

  ContainerForAlarmItem({
    required this.key,
    required this.onRemove,
    required this.alarmSettingData,
  }): super(key: key);

  @override
  _ContainerForAlarmItemState createState() =>  _ContainerForAlarmItemState();
}

class _ContainerForAlarmItemState extends State<ContainerForAlarmItem> {
  bool switchButton = true;

  String chosenWeekdays(Map<String, bool> weekdays) {
    if(weekdays.values.contains(true)) {
      return weekdays.keys.where((key) => weekdays[key] == true).join(', ');
    }
    else {
      return '반복 없음';
    }
  }

  void _modifiedAlarmData(AlarmSettingData alarmSettingData) {
    setState(() {
      widget.alarmSettingData = alarmSettingData;
    });
  }



  Timer _timerForPeriodicCheck = Timer(Duration.zero, () { });
  Timer _timerForAlarmAgain = Timer(Duration.zero, () { });
  Timer _timerForCheckCurrentTime = Timer(Duration.zero, () { });
  DateTime now = DateTime.now();

  late TimeOfDay _selectedTime = widget.alarmSettingData.selectedTime;   // 설정한 시간

  late Map<String, bool> _selectedWeekdays = widget.alarmSettingData.weekdays;  // 반복 요일

  late String _selectedAlarmBell = widget.alarmSettingData.selectedAlarmBell;  // 알림음

  late String _selectedAlarmRingAgain = widget.alarmSettingData.selectedAlarmRingAgain;   // 반복 간격, 횟수
  late List<String> _parts;
  late int _intervalAgain;
  late int _countAgain;

  late String _selectedAlarmOffMission = widget.alarmSettingData.selectedAlarmOffMission;  // 알람 끄기 미션

  @override
  void initState() {
    super.initState();

    if(_selectedAlarmRingAgain != '사용 안 함') {
      _parts = _selectedAlarmRingAgain.split(',');
      _intervalAgain = int.parse(_parts[0].replaceAll(RegExp(r'[^\d]'), ''));  // 반복 간격
      _countAgain = int.parse(_parts[1].replaceAll(RegExp(r'[^\d]'), ''));  // 반복 횟수
    }
    else {
      _intervalAgain = 0;
      _countAgain = 1;
    }

    _checkNowTime();
    _triggerAlarm ();
  }

  // 1초 간격으로 현재 시간을 now에 저장
  void _checkNowTime() {
    _timerForCheckCurrentTime = Timer.periodic(Duration(seconds: 1),(Timer timer) {
      now = DateTime.now();
    });
  }

  void _triggerAlarm () {
    _timerForPeriodicCheck = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      _checkAlarmDateSetting();
    });
  }

  Future<void> _ringAlarm() async {
    // _intervalAgain마다 띄울 때마다 --
    _countAgain--;

    // 알람 끄기 미션 선택했다면,
    if(_selectedAlarmOffMission == '바코드 찍기' || _selectedAlarmOffMission == '수학 문제 풀기') {

      // 반복 횟수가 남았다면,
      if(_countAgain > 0) {
        // 알람음 재생
        _playAlarmSound();

        // 화면 띄우기
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SnoozeAndTurnOffAlarmPage(
            // 타이머 해제할 수 있도록, 타이머 객체 전달
            alarmOffMission: _selectedAlarmOffMission,
          )),
        );

        // 알람음 중지
        _stopAlarmSound();
      }

      // 반복 횟수가 남지 않았다면,
      else if(_countAgain == 0) {
        // 알람음 재생
        _playAlarmSound();

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              TurnOffAlarmPage(
                alarmOffMission: _selectedAlarmOffMission,
              )),
        );

        // 알람음 중지
        _stopAlarmSound();

        // 현재 시간이 맞는지 다시 체크 시작
        sleep(Duration(seconds: 35));
        _triggerAlarm ();
        if(_selectedAlarmRingAgain != '사용 안 함') {
          _timerForAlarmAgain.cancel();
        }
      }

    }

    // 알람 끄기 미션 선택 안했다면,
    else {

      // 반복 횟수가 남았다면,
      if(_countAgain > 0) {
        // 알람음 재생
        _playAlarmSound();

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SnoozeAndTurnOffAlarmPageWithoutMission()),
        );

        // 알람음 중지
        _stopAlarmSound();
      }

      // 반복 횟수가 남지 않았다면,
      else if(_countAgain == 0) {
        // 알람음 재생
        _playAlarmSound();

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TurnOffAlarmPageWithoutMission()),
        );

        // 알람음 중지
        _stopAlarmSound();

        // 현재 시간이 맞는지 다시 체크 시작
        sleep(Duration(seconds: 35));
        _triggerAlarm ();
        _timerForAlarmAgain.cancel();
      }

    }
  }

  void _checkAlarmDateSetting() {
    late String today;

    switch (now.weekday) {
      case DateTime.monday:
        today = '월';
        break;
      case DateTime.tuesday:
        today = '화';
        break;
      case DateTime.wednesday:
        today = '수';
        break;
      case DateTime.thursday:
        today = '목';
        break;
      case DateTime.friday:
        today = '금';
        break;
      case DateTime.saturday:
        today = '토';
        break;
      case DateTime.sunday:
        today = '일';
        break;
    }

    bool checkSelectedWeekdaysResult = (_selectedWeekdays[today] == true);
    bool checkSelectedTimeHourResult = (now.hour == _selectedTime.hour) ;
    bool checkSelectedTimeMinuteResult = (now.minute == _selectedTime.minute);

    if (checkSelectedWeekdaysResult && checkSelectedTimeHourResult && checkSelectedTimeMinuteResult) {
      // _intervalAgain분 간격으로 스누즈 또는 알람 끄기 화면 띄우기
      _timerForPeriodicCheck.cancel();
      _ringAlarm();

      if (_selectedAlarmRingAgain != '사용 안 함') {
        _timerForAlarmAgain = Timer.periodic(Duration(minutes: _intervalAgain), (Timer timer) {
          _ringAlarm();
        });
      }
    }
  }


  AudioPlayer player = AudioPlayer();

  void _playAlarmSound() async {
    if (_selectedAlarmBell == '알람음1') {
      await player.setAsset('assets/alarm_sound_1.mp3');

      player.load();
      for (int i = 0; i < 30; i++) {
        player.play();
      }
    }
    else if(_selectedAlarmBell == '알람음2') {
      await player.setAsset('assets/alarm_sound_2.mp3');

      player.load();
      for (int i = 0; i < 30; i++) {
        player.play();
      }
    }
    else {
      // '무음'이라면, 진동
    }
  }

  void _stopAlarmSound() {
    player.stop();
  }



  @override
  void dispose() {
    super.dispose();
    _timerForCheckCurrentTime.cancel();
    _timerForPeriodicCheck.cancel();
    _timerForAlarmAgain.cancel();
  }







  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ModifyAlarmPage(
              alarmSettingData: widget.alarmSettingData,
              modifiedAlarmData: _modifiedAlarmData
            )
          ),
        );
      },
      child : Container(
        key: widget.key,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: switchButton ? Colors.blueGrey.shade200 : Colors.blueGrey.shade600,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('${widget.alarmSettingData.convertToStringSelectedTime}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                  ),
                  Text(chosenWeekdays(widget.alarmSettingData.weekdays), style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, top: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    value: switchButton,
                    activeColor: Colors.orange.shade900,
                    onChanged: (value) {
                      setState(() {
                        switchButton = value;
                      });
                      // 알람 활성화
                      if(switchButton == true) {
                        _checkNowTime();
                        _triggerAlarm();
                      }
                      // 알람 비활성화
                      else {
                        _timerForCheckCurrentTime.cancel();
                        _timerForPeriodicCheck.cancel();
                        _timerForAlarmAgain.cancel();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget.onRemove(widget.key);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}