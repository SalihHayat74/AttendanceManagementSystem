import 'package:attendence_management_system/screens/AdminScreens/add_attendence.dart';
import 'package:attendence_management_system/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class StudentAttendence{
  String time;
  StudentAttendence({required this.time});
}

class AddAttendenceStudent extends StatelessWidget {
  User user;
  AddAttendenceStudent({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Attendence"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Attendence').where('Student id',isEqualTo: user.uid).orderBy('Date',descending: true).snapshots(),
        builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot){
        if(snapshot.hasError){
        return Text('Something Went wrong');
        }

        final List storedocs = [];
        snapshot.data?.docs.map((DocumentSnapshot document){
          Map<String, dynamic> attendence = document.data() as Map<String, dynamic>;

          storedocs.add(attendence);

        }).toList();

        if(snapshot.hasData){

          return Container(
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: () async{
                    DateTime time = DateTime.now();
                    if(storedocs.length == 0){

                      await FirestoreService().addAttendence(user.uid,time,'Present');
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              content: Text("Attendence added Successfuly",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                              title: Icon(
                                Icons.add_task_rounded,
                                color: Colors.green,
                                size: 50,
                              ),

                            );

                          }
                      );
                    }

                    for(int i=0; i < storedocs.length; i++) {
                      int k = i + 1;
                      DateTime now= DateTime.now();
                      int newTime = int.parse(DateFormat('dd').format(now));
                      String time1 = storedocs[i]['Date'];
                      DateTime  time_ = DateTime.parse(time1);
                      int previousTime = int.parse(DateFormat('dd').format(time_));

                      if(i==0 && k==storedocs.length){
                        if(newTime == previousTime){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Already Attended for today",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                  ),
                                  title: Column(
                                    children: [
                                      Text("Warning",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),),
                                      Icon(
                                        Icons.warning_amber,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ],
                                  ),

                                );

                              }
                          );
                        }
                      }else if( i< storedocs.length && k==storedocs.length){

                        if(newTime == previousTime){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Already Attended for today",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                  ),
                                  title: Column(
                                    children: [
                                      Text("Warning"),
                                      Icon(
                                        Icons.warning_amber,
                                        color: Colors.red,
                                        size: 50,
                                      ),
                                    ],
                                  ),

                                );

                              }
                          );
                        }else if(newTime != previousTime){
                          await FirestoreService().addAttendence(user.uid,time,'Present');
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: Text("Attendence added Successfully",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                  ),
                                  title: Icon(
                                    Icons.add_task_rounded,
                                    color: Colors.green,
                                    size: 50,
                                  ),

                                );

                              }
                          );
                        }
                      }
                    }



                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddInvestigation(regNo: regNo, weight: weight,)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 1
                        )
                    ),
                    width: 110,
                    height: 150,
                    child: Column(
                      children: [
                        Icon(Icons.add_task_rounded,
                          size:100,
                          color: Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Mark Attendence",
                            style: TextStyle(color: Colors.black,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
              )
          );
        }
        return Center(
            child: CircularProgressIndicator()
        );
    }
  )
    );
}
}
