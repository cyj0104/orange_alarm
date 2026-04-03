import "package:flutter/material.dart";
import "package:orange_alarm/data/AlarmSettingData.dart";
import "package:orange_alarm/page/NewAlarmPage.dart";
import "../widget/AlarmCard.dart";

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<AlarmSettingData> alarmList = [];

  void _addAlarm(AlarmSettingData alarmSettingData) {
    setState(() {
      alarmList.add(alarmSettingData);
    });
  }

  void _removeAlarm(int index) {
    setState(() {
      alarmList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      appBar: AppBar(
        title: Text('알람', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade900,
      ),
      body: ListView(
        padding: EdgeInsets.only(top:10, bottom: 150),
        children: alarmList.asMap().entries.map((entry) =>
          AlarmCard(
            key: ValueKey(entry.key),
            onRemove: () => _removeAlarm(entry.key),
            alarmSettingData: entry.value,
          )
        ).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewAlarmPage(addAlarm: _addAlarm)),
          );
        },
        backgroundColor: Colors.orange.shade900,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}


