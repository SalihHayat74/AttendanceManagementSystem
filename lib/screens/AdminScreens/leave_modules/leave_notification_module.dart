import 'package:attendence_management_system/screens/AdminScreens/add_attendence.dart';
import 'package:attendence_management_system/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Notifications').snapshots(),
    builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something Went wrong');
      }
      if(snapshot.hasData){
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            final String ? name= data['Student Name'];
            final String ? class_no= data['Class'];
            final String ? rollNo= data['Roll No'];
            final String  Studentid = data['Student Id'];
            final Timestamp date = data['Date'];
            final String id = document.id;

            return Card(
                color: Colors.white.withOpacity(0.8),
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(

                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                  title: Text("Student Name:  ${name}     Roll No: ${rollNo}",style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),),
                  subtitle: Text("Class: ${class_no}",overflow: TextOverflow.ellipsis,maxLines: 2,),
                  onTap: ()async{
                    await FirestoreService().deleteNotification(id);
                    Navigator.of(context).push(MaterialPageRoute(builder:
                        (context)=>AddAttendence(studentId: Studentid,)));


                  },
                ));
          }).toList(),
        );
      }
      return Container(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("No notifications available"),

            ],
          ),
        ),
      );

        }
      )


    );
  }
}
