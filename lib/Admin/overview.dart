import 'package:flutter/material.dart';

class AdminOverview extends StatelessWidget {
  const AdminOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('overview', style: TextStyle(color: Colors.redAccent)),
            CircleAvatar(
              child: Icon(Icons.person),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             
              Card(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Total Absent', style: TextStyle(color: Colors.white)),
                      Text('00', style: TextStyle(fontSize: 24, color: Colors.white)),
                     
                    ],
                  ),
                ),
              ),
               Card(
                color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Total Present', style: TextStyle(color: Colors.white)),
                      Text('12', style: TextStyle(fontSize: 24, color: Colors.white)),
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
         
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                        color: Colors.blueAccent,
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Employees', style: TextStyle(fontSize: 16,color: Colors.white)),
                                                              Text('12', style: TextStyle(fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15
                ),
                child: Text("Today's attendance", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Divider(),

              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text('Employee ${index}', style: TextStyle(color: Colors.blueAccent)),
                          subtitle: Text('${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().day + index}/${DateTime.now().month}/${DateTime.now().year - index}'),
                          trailing: Column(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              Text('Present', style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              )
        ],
      ),
    );
  }
}