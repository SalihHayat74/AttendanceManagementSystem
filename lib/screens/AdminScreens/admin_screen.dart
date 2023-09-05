import 'package:attendence_management_system/screens/AdminScreens/attendenceList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
import 'leave_modules/leave_notification_module.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        actions: [
          TextButton.icon(onPressed: () async {
            //AuthService().signout();
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Notifications()));

          },

            icon: Icon(Icons.notifications_on_outlined),
            label: Text(""),
            style: TextButton.styleFrom(
                primary: Colors.yellow
            ),),
          TextButton.icon(onPressed: () async {
            AuthService().signout();
            //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Notifications()));

          },

            icon: Icon(Icons.logout_rounded),
            label: Text("Log Out"),
            style: TextButton.styleFrom(
                primary: Colors.white
            ),),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Students').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Text("OOOOoooops!! Something went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                final String ? name= data['Name'];
                final String ? class_no= data['Class'];
                final String rollNo= data['Roll No'];
                final String id = data['id'];

                return Card(
                    color: Colors.white.withOpacity(0.8),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: ListTile(

                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                      title: Text("Student Name:  ${name}     Roll No: ${rollNo}",style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),),
                      subtitle: Text("Class: ${class_no}",overflow: TextOverflow.ellipsis,maxLines: 2,),
                      onTap: (){
                         Navigator.of(context).push(MaterialPageRoute(builder:
                             (context)=>AttendenceTable(regNo: id,)));
                      },
                    ));
              }).toList(),
            );
          }

      ),

    );
  }
}
