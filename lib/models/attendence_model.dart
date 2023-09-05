


import 'package:attendence_management_system/screens/AdminScreens/attendenceList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendenceModel{

  String docId;
  String attendence;
  String date;
  String studentId;

  AttendenceModel({required this.docId, required this.attendence, required  this.date, required this.studentId});

  factory AttendenceModel.fromJson(DocumentSnapshot snapshot){
    return AttendenceModel(
        docId: snapshot.id,
        attendence: snapshot['Attendence'],
        date: snapshot['Date'],
        studentId: snapshot['Student Id']);
  }
}