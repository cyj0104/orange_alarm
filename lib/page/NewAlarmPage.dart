import 'package:flutter/material.dart';

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

  List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];
  List<bool> isSelected = [false, false, false, false, false, false, false];

  void toggleSelection(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        title: const Text('새 알람',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade800,
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
          ///////////// 시간 선택
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                _selectTime(context);
              },
              child: Text(
                '${_selectedTime.period == DayPeriod.am ? 'AM' : 'PM'} ${_selectedTime.hourOfPeriod.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 80, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          ///////////// 요일 선택
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                weekdays.length,
                (index) => InkWell(
                  onTap: () {
                    toggleSelection(index);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          weekdays[index],
                          style: TextStyle(
                            fontSize: 30, color: isSelected[index] ? Colors.orange.shade800 : Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          ///////////// 알람음 선택
          ///////////// 다시 울림
          ///////////// 알람 끄기 미션
          ///////////// 취소, 저장 버튼
        ],
      ),
    );
  }
}