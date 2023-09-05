import 'package:attendence_management_system/screens/AdminScreens/editAttendence.dart';
import 'package:attendence_management_system/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:charts_flutter/flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Attendence{
  String time;
  String attendence;
  String id;
  Attendence({required this.time,required this.attendence,required this.id});
}


class AttendenceTable extends StatelessWidget {
  String regNo;
  AttendenceTable({required this.regNo});

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

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
            backgroundColor: Colors.white.withOpacity(0.8),
            appBar: AppBar(
              title: Text("Attendence List"),

            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Attendence').where('Student id',isEqualTo: regNo).orderBy('Date',descending: true).snapshots(),
                builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot){
                  if(snapshot.hasError){
                    return Text('Something Went wrong');
                  }

                  final List<Attendence> storedocs = [];
                  snapshot.data?.docs.map((DocumentSnapshot document){
                    Map<String, dynamic> attendence = document.data() as Map<String, dynamic>;

                    String date=attendence['Date'];
                    //DateTime date=DateTime.parse(date_);
                    //String time = date.toString();
                    String attend_ence = attendence['Attendence'];
                    String id = document.id;

                    storedocs.add(Attendence(time: date,attendence: attend_ence,id: id));
                  }).toList();

                  final List<String> presentList=[];
                  final List<String> leaveList = [];
                  final List<String> absentList = [];


                  for(int i=0; i<storedocs.length;i++){
                    if(storedocs[i].attendence == 'Present'){
                      String present = storedocs[i].attendence;
                      presentList.add(present);
                    }else if(storedocs[i].attendence == 'Leave'){
                      String leave = storedocs[i].attendence;
                      leaveList.add(leave);
                    }else if(storedocs[i].attendence == 'Absent'){
                      String absent=storedocs[i].attendence;
                      absentList.add(absent);
                    }

                  }

                  double attendencePercentage = (presentList.length + leaveList.length)*100/storedocs.length ;

                  String grade = '';
                  if(attendencePercentage >= 80){
                    grade = 'A';
                  }else if(attendencePercentage >= 60 && attendencePercentage < 80){
                    grade = 'B';
                  }else if(attendencePercentage >= 40 && attendencePercentage < 60){
                    grade = 'C';
                  }else if(attendencePercentage < 40){
                    grade = 'D';
                  }


                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      padding: EdgeInsets.all(10),
                        child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Container(
                                    child: Text("Total Number of Attendence: ${storedocs.length} ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text("Total Presents: ${presentList.length}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text("Total Leave: ${leaveList.length}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text("Total Absents: ${absentList.length}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text("Attendence %age: ${attendencePercentage}\nGrade: ${grade}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  )
                                ],
                              ),

                              SizedBox(height: 10,),

                              Divider(
                                color: Color(0xFF555FD2),
                                indent: 50,
                                endIndent: 50,
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Table(
                                      border: TableBorder.all(),
                                      columnWidths: const <int, TableColumnWidth>{
                                          0: FixedColumnWidth(50),
                                        //1: FixedColumnWidth(60),
                                        //
                                      },
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                            children: [
                                              TableCell(
                                                  child: Container(
                                                    color: Colors.teal,
                                                    child: Center(
                                                      child: Text('S No',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                              TableCell(
                                                  child: Container(
                                                    color: Colors.teal,
                                                    child: Center(
                                                      child: Text('Date',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                              TableCell(
                                                  child: Container(
                                                    color: Colors.teal,
                                                    child: Center(
                                                      child: Text('Attendence',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                              TableCell(
                                                  child: Container(
                                                    color: Colors.teal,
                                                    child: Center(
                                                      child: Text('Actions',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                            ]
                                        ),
                                        for(var i=0; i<storedocs.length;  i++) ...[
                                          TableRow(
                                              children: [
                                                TableCell(
                                                    child: Container(
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Text('${i+1}',style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,),
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                TableCell(
                                                    child: Container(
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Text('${storedocs[i].time}',style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,),
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                TableCell(
                                                    child: Container(
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Text(storedocs[i].attendence,style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,),
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                TableCell(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        IconButton(
                                                            onPressed: ()=>{
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context)=>EditAttendence(date: storedocs[i].time,attendenceValue: storedocs[i].attendence,regNo: regNo,docId: storedocs[i].id,)))
                                                            },
                                                            icon: Icon(
                                                              Icons.edit,
                                                              size: 20,
                                                              color: Colors.green,
                                                            )
                                                        ),
                                                        IconButton(
                                                            onPressed: ()async{
                                                              await showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context){
                                                                    return AlertDialog(
                                                                      title: Text("Please Confirm"),
                                                                      content: Text("Are you sure to delete Attendence"),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed: ()async{
                                                                              await FirestoreService().deleteAttendence(storedocs[i].id);
                                                                              Navigator.pop(context);

                                                                            },
                                                                            child: Text("Yes")),
                                                                        TextButton(
                                                                            onPressed: (){
                                                                              Navigator.pop(context);
                                                                            }, child: Text("No"))
                                                                      ],
                                                                    );
                                                                  });
                                                              },
                                                            icon: Icon(
                                                              Icons.delete_forever,
                                                              size: 20,
                                                              color: Colors.red,
                                                            )
                                                        ),
                                                      ],
                                                    )
                                                ),

                                              ]
                                          ),
                                        ]
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ]

                        )
                    ),
                  );


                }

            ),
          )]
    );
  }

}

