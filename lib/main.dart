import 'package:attendence_management_system/screens/AdminScreens/admin_screen.dart';
import 'package:attendence_management_system/screens/RegistrationLoginScreens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:attendence_management_system/services/auth_services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:attendence_management_system/screens/StudentScreens/homepage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: AuthService().firebaseAuth.authStateChanges(),
            builder: (context,AsyncSnapshot snapshot){
              if(snapshot.hasData && snapshot.data.uid =='sUszj5S7F6VMTPB068vqJVcOqDE2'){
               return AdminPanel();
              }else if(snapshot.hasData && snapshot.data.uid != 'sUszj5S7F6VMTPB068vqJVcOqDE2'){
                return HomePage(user: snapshot.data,);
              }
              return RegisterScreen();
            },
          )
      )
  );
}





