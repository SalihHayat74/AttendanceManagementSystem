import 'package:attendence_management_system/screens/RegistrationLoginScreens/Login_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final db= FirebaseFirestore.instance;

  Future<void> createUser(String uid, String username,String class_no,String rollNo, String email ) async {
    //Creates the user doc named whatever the user uid is in te collection "users"
    //and adds the user data
    await db.collection("Students").doc(uid).set({
      'Name': username,
      'Class': class_no,
      'Roll No': rollNo,
      'Email': email,
      'id': uid,

    });
  }

  Future<void> createAdmin(String uid, String username, String email ) async {
    //Creates the user doc named whatever the user uid is in te collection "users"
    //and adds the user data
    await db.collection("Admin").doc(uid).set({
      'Name': username,
      'Email': email,
      'id': uid,

    });
  }

  Future<User?> registerUser(String username,String class_no,String rollNumber,String email, String password, BuildContext context) async {
    //Create the user with auth
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //Create the user in firestore with the user data
      createUser(result.user!.uid, username,class_no,rollNumber, email);
    } on FirebaseAuthException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()), backgroundColor: Colors.red,));
    } catch (e) {
      print(e);

    }
  }


  //Register User
  Future<User?> register(String email,String password, BuildContext context)async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()), backgroundColor: Colors.red,));
    } catch (e) {
      print(e);
    }
  }

  // Login User
  Future<User?> login(String email, String password, BuildContext context)async{
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()), backgroundColor: Colors.red,));
    } catch (e) {
      print(e);
    }

  }

  Future signout()async{
    await firebaseAuth.signOut();
    return LoginScreen();
  }



}
