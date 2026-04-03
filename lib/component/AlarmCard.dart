import "package:flutter/material.dart";

import "../data/AlarmSettingData.dart";
import "../page/ModifyAlarmPage.dart";
import "../page/SnoozeAndTurnOffAlarmPage.dart";
import "../page/SnoozeAndTurnOffAlarmPageWithoutMission.dart";
import "../page/TurnOffAlarmPage.dart";
import "../page/TurnOffAlarmPageWithoutMission.dart";
import "../service/AlarmService.dart";

class AlarmCard extends StatefulWidget {
  final Function() onRemove;
  final AlarmSettingData alarmSettingData;

  AlarmCard({
    super.key,
    required this.onRemove,
    required this.alarmSettingData,
  });

  @override
  AlarmCardState createState() => AlarmCardState();
}

class AlarmCardState extends State<AlarmCard> {
  bool switchButton = true;
  late AlarmSettingData _alarmSettingData;
  late AlarmService _alarmService;

  @override
  void initState() {
    super.initState();
    _alarmSettingData = widget.alarmSettingData;
    _alarmService = AlarmService(
      alarmSettingData: _alarmSettingData,
      onAlarmRing: _navigateToAlarmPage,
    );
    _alarmService.start();
  }

  void _navigateToAlarmPage(bool hasMission, bool hasRepeat) {
    if (hasMission && hasRepeat) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SnoozeAndTurnOffAlarmPage(
          alarmOffMission: _alarmService.alarmSettingData.selectedAlarmOffMission,
          stopAlarmSound: _alarmService.stopAlarmSound,
          stopTimerForAlarmAgain: _alarmService.stopTimerForAlarmAgain,
        )),
      );
    } else if (hasMission && !hasRepeat) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TurnOffAlarmPage(
          alarmOffMission: _alarmService.alarmSettingData.selectedAlarmOffMission,
          stopAlarmSound: _alarmService.stopAlarmSound,
        )),
      );
    } else if (!hasMission && hasRepeat) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SnoozeAndTurnOffAlarmPageWithoutMission(
          stopAlarmSound: _alarmService.stopAlarmSound,
          stopTimerForAlarmAgain: _alarmService.stopTimerForAlarmAgain,
        )),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TurnOffAlarmPageWithoutMission(
          stopAlarmSound: _alarmService.stopAlarmSound,
        )),
      );
    }
  }

  void _modifiedAlarmData(AlarmSettingData alarmSettingData) {
    setState(() {
      _alarmSettingData = alarmSettingData;
      if (switchButton) {
        _alarmService.updateAlarmData(alarmSettingData);
      } else {
        _alarmService.updateData(alarmSettingData);
      }
    });
  }

  String chosenWeekdays(Map<String, bool> weekdays) {
    if (weekdays.values.contains(true)) {
      return weekdays.keys.where((key) => weekdays[key] == true).join(', ');
    } else {
      return '반복 없음';
    }
  }

  @override
  void dispose() {
    _alarmService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ModifyAlarmPage(
            alarmSettingData: _alarmSettingData,
            modifiedAlarmData: _modifiedAlarmData,
          )),
        );
      },
      child: Container(
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
                    child: Text(
                      _alarmSettingData.convertToStringSelectedTime,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(chosenWeekdays(_alarmSettingData.weekdays), style: const TextStyle(fontSize: 15)),
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
                      if (switchButton) {
                        _alarmService.start();
                      } else {
                        _alarmService.stop();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onRemove,
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
