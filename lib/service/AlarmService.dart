import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import '../data/AlarmSettingData.dart';

class AlarmService {
  AlarmSettingData alarmSettingData;
  final Function(bool hasMission, bool hasRepeat) onAlarmRing;

  Timer _timerForPeriodicCheck = Timer(Duration.zero, () {});
  Timer _timerForAlarmAgain = Timer(Duration.zero, () {});

  late int _intervalAgain;
  late int _countAgain;

  final AudioPlayer _player = AudioPlayer();

  AlarmService({
    required this.alarmSettingData,
    required this.onAlarmRing,
  }) {
    _initAlarmRingAgain();
  }

  void _initAlarmRingAgain() {
    if (alarmSettingData.selectedAlarmRingAgain != '사용 안 함') {
      final parts = alarmSettingData.selectedAlarmRingAgain.split(',');
      _intervalAgain = int.parse(parts[0].replaceAll(RegExp(r'[^\d]'), ''));
      _countAgain = int.parse(parts[1].replaceAll(RegExp(r'[^\d]'), ''));
    } else {
      _intervalAgain = 0;
      _countAgain = 1;
    }
  }

  void start() {
    _triggerAlarm();
  }

  void stop() {
    _timerForPeriodicCheck.cancel();
    _timerForAlarmAgain.cancel();
  }

  void dispose() {
    stop();
    _player.dispose();
  }

  // 알람 수정 후 타이머 재시작
  void updateAlarmData(AlarmSettingData data) {
    alarmSettingData = data;
    _initAlarmRingAgain();
    stop();
    start();
  }

  // 알람 비활성화 상태에서 데이터만 업데이트
  void updateData(AlarmSettingData data) {
    alarmSettingData = data;
    _initAlarmRingAgain();
  }

  void stopAlarmSound() {
    if (alarmSettingData.selectedAlarmBell == '알람음1' ||
        alarmSettingData.selectedAlarmBell == '알람음2') {
      _player.stop();
    }
  }

  void stopTimerForAlarmAgain() {
    _timerForAlarmAgain.cancel();
  }

  void _triggerAlarm() {
    _checkAlarmDateSetting();
    _timerForPeriodicCheck = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkAlarmDateSetting();
    });
  }

  void _ringAlarm() {
    _countAgain--;
    _playAlarmSound();

    final bool hasMission = alarmSettingData.selectedAlarmOffMission == '바코드 찍기' ||
        alarmSettingData.selectedAlarmOffMission == '수학 문제 풀기';
    final bool hasRepeat = _countAgain > 0;

    onAlarmRing(hasMission, hasRepeat);

    if (!hasRepeat) {
      _triggerAlarm();
      if (alarmSettingData.selectedAlarmRingAgain != '사용 안 함') {
        _timerForAlarmAgain.cancel();
      }
    }
  }

  void _checkAlarmDateSetting() {
    const weekdayMap = {
      DateTime.monday: '월',
      DateTime.tuesday: '화',
      DateTime.wednesday: '수',
      DateTime.thursday: '목',
      DateTime.friday: '금',
      DateTime.saturday: '토',
      DateTime.sunday: '일',
    };
    final now = DateTime.now();
    final today = weekdayMap[now.weekday]!;

    final bool checkWeekday = alarmSettingData.weekdays[today] == true;
    final bool checkHour = now.hour == alarmSettingData.selectedTime.hour;
    final bool checkMinute = now.minute == alarmSettingData.selectedTime.minute;
    final bool noRepeatDay = !alarmSettingData.weekdays.values.contains(true);

    if ((checkWeekday || noRepeatDay) && checkHour && checkMinute) {
      _timerForPeriodicCheck.cancel();
      _ringAlarm();

      if (alarmSettingData.selectedAlarmRingAgain != '사용 안 함') {
        _timerForAlarmAgain = Timer.periodic(Duration(minutes: _intervalAgain), (timer) {
          _ringAlarm();
        });
      }

      if (noRepeatDay && _countAgain == 0) {
        stop();
      }
    }
  }

  void _playAlarmSound() {
    _player.setReleaseMode(ReleaseMode.loop);
    if (alarmSettingData.selectedAlarmBell == '알람음1') {
      _player.play(AssetSource('alarm_sound_1.mp3'));
    } else if (alarmSettingData.selectedAlarmBell == '알람음2') {
      _player.play(AssetSource('alarm_sound_2.mp3'));
    }
  }
}
