import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems/Provider/UserData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminEmployees extends StatefulWidget {
  const AdminEmployees({super.key});

  @override
  State<AdminEmployees> createState() => _AdminEmployeesState();
}

class _AdminEmployeesState extends State<AdminEmployees> {
  bool admin = false;
  final _addEmployeeFormKey = GlobalKey<FormBuilderState>();
    final _editEmployeeFormKey = GlobalKey<FormBuilderState>();
        final _searchEmployeeFormKey = GlobalKey<FormBuilderState>();
String searchValue='';


  
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    UserData model = context.watch<UserData>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Text('employees', style: TextStyle(color: Colors.redAccent)),
            Spacer(),
            IconButton(onPressed: (){
              showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Employee',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                      FormBuilder(
                        key: _addEmployeeFormKey,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'name',
                              decoration:
                                  const InputDecoration(labelText: 'Name'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            FormBuilderTextField(
                              name: 'id',
                              decoration:
                                  const InputDecoration(labelText: 'ID'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            FormBuilderTextField(
                              name: 'phone',
                              decoration:
                                  const InputDecoration(labelText: 'Phone'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async{
                                if (_addEmployeeFormKey.currentState!
                                    .saveAndValidate()) {
                                      EasyLoading.show(status: 'loading...');
                                  final data =
                                      _addEmployeeFormKey.currentState!.value;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .add({
                                    'name': data['name'],
                                    'id': data['id'],
                                    'phone': data['phone'],
                                    'isAdmin': false,
                                  });
                                  Navigator.pop(context);
                                  
                                  EasyLoading.dismiss();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                              ),
                              child: Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
            }, icon: Icon(Icons.add, color: Colors.redAccent,size: 28,))
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: FormBuilder(
            key: _searchEmployeeFormKey,
            child: FormBuilderTextField(
              name: 'Search',
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) async {
                setState(() {
                  searchValue=value.toString();
                });
              },
            ),

          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').where('isAdmin',isEqualTo: false).snapshots(), 
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text('No employees found'),
                );
              }

              var data = snapshot.data!.docs;
             
              var filteredData = data.where((doc) {
                var name = (doc.data() as Map<String, dynamic>)['name'];
                return name.toString().toLowerCase().startsWith(searchValue.toLowerCase());
              }).toList();
            return Expanded(
          child: (snapshot.connectionState == ConnectionState.waiting) 
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ),
                )
              : ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    var doc = filteredData[index];
                    var data = doc.data() as Map<String, dynamic>;
                  
                      return Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          ListTile(
                            title: Text(data['name']),
                            subtitle: Text(data['id']),
                            trailing: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context, 
                                  isScrollControlled: true,
                                  builder:(context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      height: MediaQuery.of(context).size.height * 0.8,
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Edit Employee Details',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent),
                                            ),
                                            FormBuilder(
                                              key: _editEmployeeFormKey,
                                              child: Column(
                                                children: [
                                                  FormBuilderTextField(
                                                    name: 'id',
                                                    initialValue: data['id'],
                                                    enabled: false,
                                                    decoration:
                                                        const InputDecoration(labelText: 'ID'),
                                                    validator: FormBuilderValidators.compose([
                                                      FormBuilderValidators.required(),
                                                    ]),
                                                  ),
                                                  FormBuilderTextField(
                                                    name: 'name',
                                                    initialValue: data['name'],
                                                    decoration:
                                                        const InputDecoration(labelText: 'Name'),
                                                    validator: FormBuilderValidators.compose([
                                                      FormBuilderValidators.required(),
                                                    ]),
                                                  ),
                                                  
                                                  FormBuilderTextField(
                                                    name: 'phone',
                                                    initialValue: data['phone'],
                                                    decoration:
                                                        const InputDecoration(labelText: 'Phone'),
                                                    validator: FormBuilderValidators.compose([
                                                      FormBuilderValidators.required(),
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () async{
                                                      if (_editEmployeeFormKey.currentState!
                                                          .saveAndValidate()) {
                                                      EasyLoading.show(status: 'loading...');
                                                      await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: data['id']).get().then((value) {
                                                        value.docs.forEach((element) async {
                                                          await FirebaseFirestore.instance.collection('users').doc(element.id).update({
                                                            'name': _editEmployeeFormKey.currentState!.value['name'],
                                                            'phone': _editEmployeeFormKey.currentState!.value['phone'],
                                                          });
                                                        });
                                                      });
                                                      Navigator.pop(context);
                                                     
                                                     
                                                      EasyLoading.dismiss();
                                                          }
                                                    },
                                                    
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.redAccent,
                                                    ),
                                                    child: Text(
                                                      'Edit',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },);
                              },
                              child: Icon(Icons.more_vert, color: Colors.redAccent,)),
                            leading: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(Icons.person, color: Colors.white,)),
                            onTap: () {
                              showModalBottomSheet(
                              context: context, 
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.9,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Employee Details',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent),
                                        ),
                                        SizedBox(height: 10),
                                        Text('Name: ${data['name']}'),
                                        SizedBox(height: 10),
                                        Text('ID: ${data['id']}'),
                                        SizedBox(height: 10),
                                        Text('Phone: ${data['phone']}'),
                                        SizedBox(height: 10),
                                        Text('isAdmin: ${data['isAdmin']}'),
                                        Spacer(),
                                        
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async{
                                                  EasyLoading.show(status: 'loading...');
                                                  await FirebaseFirestore.instance.collection('users').doc(
                                                      doc.id
                                                  ).delete();
                                                  Navigator.pop(context);
                                                  
                                                  
                                                  EasyLoading.dismiss();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.redAccent,
                                                ),
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                    
                    
                  }),
        );
          }),

        
      ]),
     
    );
  }
}
