import 'package:attendence_management_system/services/firestore_services.dart';
import 'package:flutter/material.dart';

class AddAttendence extends StatefulWidget {
  String  studentId;

  AddAttendence({required this.studentId});


  @override
  State<AddAttendence> createState() => _AddAttendenceState();
  
}
enum AttendenceValue<String> { Present, Leave, Absent }

class _AddAttendenceState extends State<AddAttendence> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String ? attendence = 'Present';

@override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Add Attendence"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 150,
                child: Image(
                  image: AssetImage("images/stud1.png"),
                ),
              ),
              SizedBox(height: 10,),

              Divider(
                color: Color(0xFF555FD2),
                indent: 50,
                endIndent: 50,
              ),
              Container(
                child:Text("${selectedDate.toLocal()}".split(' ')[0]),
              ),
              Container(
                child:ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select date'),
                ),
              ),
              SizedBox(height: 25,),
              Column(
                children: [
                  ListTile(
                    title: const Text('Present'),
                    leading: Radio<String>(
                      value: 'Present',
                      groupValue: attendence,
                      onChanged: (String? value) {
                        setState(() {
                          attendence = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Leave'),
                    leading: Radio<String>(
                      value: 'Leave',
                      groupValue: attendence,
                      onChanged: (String ? value) {
                        setState(() {
                          attendence = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Absent'),
                    leading: Radio<String>(
                      value: 'Absent',
                      groupValue: attendence,
                      onChanged: (String? value) {
                        setState(() {
                          attendence = value;
                        });
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: ()async{

                        await FirestoreService().addAttendence(widget.studentId, selectedDate,attendence);
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text(""),
                                content: Text("Attendence Added successfully"),
                              );
                            });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100,
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1,
                            style: BorderStyle.solid
                          )
                        ),
                        child: Text("Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),)),
                      )

                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}
