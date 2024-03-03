import 'package:flutter/material.dart';

class AlarmSettingData {
  TimeOfDay selectedTime;
  late String convertToStringSelectedTime =
      '${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'} ${selectedTime.hourOfPeriod.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
  Map<String, bool> weekdays;
  String selectedAlarmBell = '';
  String selectedAlarmRingAgain = '';
  String selectedAlarmOffMission = '';

  AlarmSettingData({
    required this.selectedTime,
    required this.weekdays,
    required this.selectedAlarmBell,
    required this.selectedAlarmRingAgain,
    required this.selectedAlarmOffMission
  });
}