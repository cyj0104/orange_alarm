import "package:flutter/material.dart";
import "package:orange_alarm/page/NewAlarmPage.dart";


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알람',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade900,
      ),
      body: const Center(
        child: Text('알람 목록'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewAlarmPage()),
          );
        },
        backgroundColor: Colors.orange.shade900,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
