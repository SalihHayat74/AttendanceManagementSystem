import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/auth_services.dart';

class StudentDetails extends StatelessWidget {

  final String ? id;
  final String ? name;
  final String ? class_no;
  final String rollNo;
  User user;


  StudentDetails({
    required this.id,
    required this.name,
    required this.class_no,
    required this.rollNo,
    required this.user,
  });





  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/student.gif'),
                    fit: BoxFit.cover
                )
            ),
          ),
          Scaffold(

              backgroundColor: Colors.white.withOpacity(0.9),
              appBar: AppBar(
                backgroundColor: Colors.blueAccent,
                title: Text("Student Details",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Students').where('id',isEqualTo: user.uid).snapshots(),
                  builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot){
                    if(snapshot.hasError){
                      return Text('Something Went wrong');
                    }
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }


                    final List storedocs = [];
                    snapshot.data!.docs.map((DocumentSnapshot document){
                      Map<String, dynamic> attendence = document.data() as Map<String, dynamic>;
                      storedocs.add(attendence);
                    }).toList();
                    return
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          //width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //             //     image: AssetImage("images/3.png"),
                            //             //     fit: BoxFit.cover,
                            //             //     opacity: 450
                            //             // )
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Container(
                                height: 150,
                                //width: 700,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("images/student.gif"),
                                        //image: AssetImage("images/dr_inj.gif"),

                                        //fit: BoxFit.fitWidth,
                                        opacity: 800
                                    )
                                ),
                              ),
                              SizedBox(height: 10,),

                              Divider(
                                color: Color(0xFF555FD2),
                                indent: 50,
                                endIndent: 50,
                              ),
                              Container(
                                width: 150,
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.8),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text("Student Details",
                                  style:TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ) ,),
                              ),
                              Container(
                                width: 350,
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.8),
                                    border: Border.all(
                                        color: Colors.deepPurple,
                                        width: 1,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          child: Text("Name : ${name}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Text("Class : ${class_no}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Text("Roll No:${rollNo}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        )
                                      ],

                                    ),
                                  ],
                                ),
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
                                          onPressed: () {
                                            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddInvestigation(regNo: regNo, weight: weight,)));
                                          },
                                          child: Column(
                                            children: [
                                              Icon(Icons.add_task_rounded,
                                                size:100,
                                                color: Colors.green,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Attendence List",
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
                                          onPressed: () {
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
                                            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddInvestigation(regNo: regNo, weight: weight,)));
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
                        ),
                      );
                  })
          )]);
  }
}
