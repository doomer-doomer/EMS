import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class UserAttendance extends StatefulWidget {
  const UserAttendance({super.key});

  @override
  State<UserAttendance> createState() => _UserAttendanceState();
}

class _UserAttendanceState extends State<UserAttendance> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attendance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(
                  'Check your activities here!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            CircleAvatar(
              child: Icon(Icons.person),
            )
          ],
        )
      ),
      body: Column(
        children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay:_focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    
                    leading: Icon(Icons.calendar_today),
                    title: Text('Attendance $index', style: TextStyle( color: Colors.blueAccent)),
                    subtitle: Text('${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().day + index}/${DateTime.now().month}/${DateTime.now().year - index}'),
                    trailing: Column(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        Text('Present', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                  Divider()
                ],
              );
            },
          ),
        )
      ],)
    );
  }
}