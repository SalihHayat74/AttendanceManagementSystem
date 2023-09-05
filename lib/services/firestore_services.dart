
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class FirestoreService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future addAttendence(String studentId,DateTime time,String ? attendenceValue)async {
    try {
       CollectionReference users = firestore.collection('Attendence');
      String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(time);
      // await firestore.collection('patient').add({
      await users.add({
        'Student id' : studentId,
        'Date': formattedTime,
        'Attendence': attendenceValue,
      });
    }catch(e){
    }

  }

  Future deleteAttendence(String docId)async{
    try{
      await firestore.collection('Attendence').doc(docId).delete();
    }catch(e){
      print(e);
    }
  }

  Future updateAttendence(String docId,String attendenceValue)async{
    try{
      await firestore.collection('Attendence').doc(docId).update({

        'Attendence': attendenceValue,
      });
    }catch(e){

    }
  }

  Future Notifications(String studentId, String leaveRequest,DateTime time,String name,String Class, String rollNo)async{
    try{
      CollectionReference notification = firestore.collection('Notifications');
      await notification.add({
        'Student Id': studentId,
        'Student Name': name,
        'Class': Class,
        'Roll No':rollNo,
        'Leave Request':leaveRequest,
        'Date': time,

      });
    }catch(e){

    }
  }

  Future deleteNotification(String docId)async{
    try{
      await firestore.collection('Notifications').doc(docId).delete();
    }catch(e){
      print(e);
    }
  }

}
