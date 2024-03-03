import "package:flutter/material.dart";

import "../data/AlarmSettingData.dart";
import "../page/ModifyAlarmPage.dart";

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
          color: Colors.blueGrey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.alarmSettingData.convertToStringSelectedTime}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
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