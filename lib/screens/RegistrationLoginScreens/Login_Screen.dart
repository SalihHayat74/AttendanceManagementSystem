import 'package:attendence_management_system/screens/AdminScreens/admin_screen.dart';
import 'package:attendence_management_system/screens/RegistrationLoginScreens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:attendence_management_system/screens/StudentScreens/homepage.dart';
import 'package:attendence_management_system/services/auth_services.dart';



class LoginScreen extends StatefulWidget{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  String dropdown_value = 'Choose Type';
  var items = ['Choose Type','Student','Admin'];
  String admin='sUszj5S7F6VMTPB068vqJVcOqDE2';


  @override
  Widget build(BuildContext context){


    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Padding(padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,

                child: Column(
                  children: [

                    DropdownButton(
                        value: dropdown_value,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),

                      items: items.map((String items){
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),

                      onChanged: (String? newValue) {
                        setState(() {
                          dropdown_value = newValue!;
                        });
                      },


                        )
    ],
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 25,),

              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 25,),

              loading? CircularProgressIndicator() : Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: ()async{
                    setState((){
                      loading = true;
                    });
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(),),);
                    if( emailController.text=="" || passwordController.text==""){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields are required"),backgroundColor: Colors.red,));
                    }else{
                      if(dropdown_value == "Choose Type"){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Choose Account Type"),backgroundColor: Colors.red,));
                      }else {
                        User? result = await AuthService().login(
                            emailController.text, passwordController.text,
                            context);
                        if (result != null && dropdown_value == 'Student' && result.uid =='sUszj5S7F6VMTPB068vqJVcOqDE2') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Does not exist for student type"),backgroundColor: Colors.red,));
                        }
                        else if (result != null && dropdown_value == 'Admin' && result.uid == 'sUszj5S7F6VMTPB068vqJVcOqDE2') {

                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AdminPanel()), (route) => false);
                        }else if(result != null && dropdown_value == 'Student'){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(user: result,)), (route) => false);
                        }
                      }
                        };

                    setState((){
                      loading = false;
                    });

                  },

                  child: Text("Submit",style: TextStyle(
                      fontSize: 25,fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              SizedBox(height: 10,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen(),),);
              }, child: Text("Not Registered? Register here"))
            ],
          ),
          ),
        ),
      ),
    );
  }
}