import "package:flutter/material.dart";
import "package:orange_alarm/page/NewAlarmPage.dart";
import "../widget/ContainerForAlarmItem.dart";



class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> alarmList = [];


  void addAlarm() {
    int dateTime = DateTime.now().millisecondsSinceEpoch;
    late Key key = ValueKey(dateTime);

    setState(() {
      alarmList.add(
        ContainerForAlarmItem(
          key: key,
          onRemove: removeAlarm,
        ),
      );
    });
  }

  void removeAlarm(Key key) {
    setState(() {
      alarmList.removeWhere((container) => (container.key) == key);
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
        //mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              addAlarm();
            },
            child: Text('Add Container'),
          ),
          ...alarmList,
          /////////////// 삭제할 코드 시작
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => SnoozeAndTurnOffAlarmPage()),
          //     );
          //   },
          // )
          Padding(
              padding: EdgeInsets.only(bottom: 90)
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewAlarmPage()),
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


