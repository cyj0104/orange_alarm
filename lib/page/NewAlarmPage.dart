import 'package:flutter/material.dart';

class NewAlarmPage extends StatefulWidget {
  @override
  _NewAlarmPageState createState() => _NewAlarmPageState();
}

class _NewAlarmPageState extends State<NewAlarmPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 알람',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade900,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text('Add Alarm Form'),
      ),
    );
  }
}