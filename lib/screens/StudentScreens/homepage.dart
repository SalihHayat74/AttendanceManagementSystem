import 'package:attendence_management_system/screens/StudentScreens/ViewStudentData.dart';
import 'package:attendence_management_system/screens/StudentScreens/addAttendence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:attendence_management_system/services/firestore_services.dart';
import 'package:intl/intl.dart';
import '../../services/auth_services.dart';
import '../AdminScreens/admin_screen.dart';


class Student{
  String name;
  String Class;
  String rollNo;
  Student(this.name,this.Class,this.rollNo);
}

class HomePage extends StatelessWidget {

  User user;
  HomePage({required this.user});




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Attendence Management'),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Students').where('id',isEqualTo:  user.uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text('Something Went wrong');
          }

          final List<Student> storedocs = [];
          snapshot.data?.docs.map((DocumentSnapshot document){
            Map<String, dynamic> student = document.data() as Map<String, dynamic>;

            String name=student['Name'];
            String Class = student['Class'];
            String rollNo = student['Roll No'];
            String email = student['Email'];
            String id = document.id;

            storedocs.add(Student(name, Class, rollNo));
          }).toList();
          int i=0;
          if(storedocs.length != 0){
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.center,

                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/profile.png"),
                      backgroundColor: Colors.blue,
                      radius: 50,
                    ),

                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(30),

                        alignment: Alignment.topCenter,
                        child: Text("Name: ${storedocs[i].name}\nClass: ${storedocs[i].Class}\nRoll No: ${storedocs[i].rollNo}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),

                        ),
                      ),
                    ],
                  ),

                  Divider(
                    color: Color(0xFF555FD2),
                    indent: 50,
                    endIndent: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: TextButton(
                              onPressed: ()  {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddAttendenceStudent(user: user,)));
                              },
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
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: TextButton(
                              onPressed: () async{
                                DateTime now = DateTime.now();
                                await FirestoreService().Notifications(user.uid, 'Request For Leave', now,storedocs[i].name,storedocs[i].Class,storedocs[i].rollNo);
                                showDialog(

                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                            content: Text("Leave Application sent Successfuly",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              ),
                                            ),
                                            title: Icon(
                                              Icons.more_time_rounded,
                                              color: Colors.yellow,
                                              size: 50,
                                            ),

                                          );

                                    }
                                );
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddInvestigation(regNo: regNo, weight: weight,)));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.more_time_rounded,
                                    size:100,
                                    color: Colors.yellow,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Mark Leave",
                                      style: TextStyle(color: Colors.black,),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StudentAttendenceTable(user: user,)));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.remove_red_eye_rounded,
                                    size:100,
                                    color: Colors.brown,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("View Records",
                                      style: TextStyle(color: Colors.black,),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: TextButton(
                              onPressed: () async {
                                AuthService().signout();

                              },
                              child: Column(
                                children: [
                                  Icon(Icons.logout_rounded,
                                    size:100,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Log Out",
                                      style: TextStyle(color: Colors.black,),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            );
          }
          return CircularProgressIndicator();


        }
      ),
    );
  }
}
