import "package:flutter/material.dart";

class ContainerForAlarmItem extends StatefulWidget {
  @override
  final Key key;
  final Function(Key) onRemove;

  final String selectedTime;
  final Map<String, bool> weekdays;
  final String? selectedAlarmBell;
  final String? selectedAlarmRingAgain;
  final String? selectedAlarmOffMission;

  ContainerForAlarmItem({
    required this.key,
    required this.onRemove,

    required this.selectedTime,
    required this.weekdays,
    required this.selectedAlarmBell,
    required this.selectedAlarmRingAgain,
    required this.selectedAlarmOffMission,
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Text(widget.selectedTime, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                    Text(chosenWeekdays(widget.weekdays), style: TextStyle(fontSize: 15)),
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
        );
  }
}