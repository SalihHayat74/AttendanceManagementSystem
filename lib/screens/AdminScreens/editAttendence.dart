import 'package:attendence_management_system/screens/AdminScreens/add_attendence.dart';
import 'package:attendence_management_system/screens/AdminScreens/admin_screen.dart';
import 'package:attendence_management_system/services/auth_services.dart';
import 'package:attendence_management_system/services/firestore_services.dart';
import 'package:flutter/material.dart';

class EditAttendence extends StatefulWidget {

  String date;
  String attendenceValue;
  String docId;
  String regNo;
  EditAttendence({required this.date,required this.attendenceValue,required this.regNo,required this.docId});

  @override
  State<EditAttendence> createState() => _EditAttendenceState();
}

class _EditAttendenceState extends State<EditAttendence> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Attendence"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              width: 250,
              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid
                ),
              ),
              child: Column(
                children: [
                  Container(
                    child: Text("Date: ${widget.date}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),),
                  ),
                  Container(
                    child: Text("Attendence: ${widget.attendenceValue}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                  ),
                ],
              ),

            ),
            Divider(
              color: Color(0xFF555FD2),
              indent: 50,
              endIndent: 50,
            ),
            SizedBox(height: 20,),
            Container(
              child: Column(
                children: [
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
                              onPressed: () async{
                                await FirestoreService().updateAttendence(widget.docId, "Present");
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Edit Response"),
                                        content: Text("Attendence updated successfully"),
                                      );
                                    });
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminPanel()));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.add_task_rounded,
                                    size:100,
                                    color: Colors.green,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Mark as Present",
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
                                await FirestoreService().updateAttendence(widget.docId, "Leave");
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Edit Response"),
                                        content: Text("Attendence updated successfully"),
                                      );
                                    });
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminPanel()));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.more_time_rounded,
                                    size:100,
                                    color: Colors.yellow,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Mark as Leave",
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
                              onPressed: () async{
                                await FirestoreService().updateAttendence(widget.docId, "Absent");
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Edit Response"),
                                        content: Text("Attendence updated successfully"),
                                      );
                                    });
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminPanel()));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.unpublished_outlined,
                                    size:100,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Mark as Absent",
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
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Please Confirm"),
                                        content: Text("Are you sure to delete Attendence"),
                                        actions: [
                                          TextButton(
                                              onPressed: ()async{
                                                await FirestoreService().deleteAttendence(widget.docId);
                                                Navigator.pop(context);
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
                              child: Column(
                                children: [
                                  Icon(Icons.delete_forever,
                                    size:100,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Delete Attendence",
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
                            width: 80,
                            decoration: BoxDecoration(
                              color:Colors.white.withOpacity(.8),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddAttendence(studentId: widget.regNo,)));
                              },
                              child: Column(

                                children: [
                                  Icon(Icons.add_circle_outline,
                                    size:100,
                                    color: Colors.green,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Add Attendence",
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

          ],
        ),
      ),
    );
  }
}
