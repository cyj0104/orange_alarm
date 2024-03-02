
class AlarmSettingData {
  late String selectedTime;
  late Map<String, bool> weekdays;
  late String? selectedAlarmBell;
  late String? selectedAlarmRingAgain;
  late String? selectedAlarmOffMission;

  AlarmSettingData({
    required this.selectedTime,
    required this.weekdays,
    required this.selectedAlarmBell,
    required this.selectedAlarmRingAgain,
    required this.selectedAlarmOffMission
  });
}