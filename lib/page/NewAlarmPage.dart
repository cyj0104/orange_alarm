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
      // builder: (BuildContext context, Widget? child) {
      //   return Theme(
      //     data: ThemeData.light().copyWith(
      //       primaryColor: Colors.orange, // 주황색으로 설정
      //       hintColor: Colors.orange, // 주황색으로 설정
      //       colorScheme: ColorScheme.light(primary: Colors.orange), // 주황색으로 설정
      //       buttonTheme: ButtonThemeData(
      //         textTheme: ButtonTextTheme.primary, // 버튼 텍스트 색상을 기본 텍스트 색상으로 설정
      //       ),
      //     ),
      //     child: child!,
      //   );
      // },
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
      backgroundColor: Colors.grey.shade800,
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
          ///////////// 시간 선택
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                _selectTime(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}  ',
                    style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      '${_selectedTime.hourOfPeriod.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 115, color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              )
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
                  onTap: () { toggleSelection(index); },
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          weekdays[index],
                          style: TextStyle(
                            fontSize: 40, color: isSelected[index] ? Colors.orange.shade900 : Colors.white,
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