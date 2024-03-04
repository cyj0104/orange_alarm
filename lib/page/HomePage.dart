import "package:flutter/material.dart";
import "package:orange_alarm/data/AlarmSettingData.dart";
import "package:orange_alarm/page/ModifyAlarmPage.dart";
import "package:orange_alarm/page/NewAlarmPage.dart";
import "../widget/ContainerForAlarmItem.dart";
import "SnoozeAndTurnOffAlarmPage.dart";

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> alarmList = [];

  void _addAlarm(AlarmSettingData alarmSettingData) {
    int dateTime = DateTime.now().millisecondsSinceEpoch;
    late Key key = ValueKey(dateTime);

    setState(() {
      alarmList.add(
        ContainerForAlarmItem(
          key: key,
          onRemove: _removeAlarm,
          alarmSettingData: alarmSettingData,
        ),
      );
    });
  }

  void _removeAlarm(Key key) {
    setState(() {
      alarmList.removeWhere((containerForAlarmItem) => (containerForAlarmItem.key) == key);
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
        children: [
          ...alarmList,
          // /////////// 삭제할 코드
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SnoozeAndTurnOffAlarmPage()),
              );
            },
          )
          // ///////////
        ]
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


