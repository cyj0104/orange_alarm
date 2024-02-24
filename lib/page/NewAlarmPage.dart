import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewAlarmPage extends StatefulWidget {
  @override
  _NewAlarmPageState createState() => _NewAlarmPageState();
}

class _NewAlarmPageState extends State<NewAlarmPage> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  bool is24HourFormat = false;

  Future<void> checkSystemTimeFormat() async {
    is24HourFormat = await MethodChannel('flutter.platform').invokeMethod('SystemChrome.is24HourFormat');
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                _selectTime(context);
              },
              child: Text(
                '${_selectedTime.period == DayPeriod.am ? 'AM' : 'PM'} ${_selectedTime.hourOfPeriod.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}