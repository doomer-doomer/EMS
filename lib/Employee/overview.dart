import 'package:flutter/material.dart';

class UserOverview extends StatelessWidget {
  const UserOverview({super.key});

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
            'Overview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          Text(
            'Welcome to Overview',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
            CircleAvatar(
              child: Icon(Icons.person),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(00.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('12', style: TextStyle(fontSize: 24, color: Colors.white)),
                        Text('Total Leaves', style: TextStyle(color: Colors.white)),
                        
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
                        Text('24', style: TextStyle(fontSize: 24, color: Colors.white)),
                        Text('Total Present', style: TextStyle(color: Colors.white)),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Card(
              color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('04', style: TextStyle(fontSize: 24, color: Colors.white)),
                        Text('Total Absent', style: TextStyle(color: Colors.white)),
                        
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                
                SizedBox(height: 10),
                Text("Today's tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          
                          ListTile(
                            leading: Icon(Icons.work),
                            title: Text('Task $index', style: TextStyle( color: Colors.blueAccent)),
                            subtitle: Text('Description of Task $index'),
                            trailing: Icon(Icons.more_vert),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                               builder: (context) {
                                 return Container(
                                   height: 200,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.only(
                                       topLeft: Radius.circular(20),
                                       topRight: Radius.circular(20),
                                     ),
                                     color: Colors.white
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(15.0),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                       Text('Task $index', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                         Text('Description of Task $index', style: TextStyle(fontSize: 16)),
                                         Spacer(),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           children: [
                                             ElevatedButton(onPressed: () {}, child: Text('Start')),
                                             ElevatedButton(onPressed: () {}, child: Text('Pause')),
                                             ElevatedButton(onPressed: () {}, child: Text('Stop')),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 );
                                }
                               );
                               
                            },
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                )
          ],
        ),
      )
    );
  }
}