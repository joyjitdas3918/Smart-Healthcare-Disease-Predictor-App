import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_healthcare/SignupPage.dart';

import 'main.dart';

class PhoneVerificationPage extends StatefulWidget {  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  logIn(String email, String password) async {
    if (email == "" || password == "") {
      CustomAlertBox(context, "Enter Required Fields");
    }
    else {
      UserCredential? usercredential;
      try {
        usercredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password).then((value) async {
          var pref=await SharedPreferences.getInstance();
          pref.setBool("login", true);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) {
            return MyHomePage();
          },
          ),
                  (r) {
                return false;
              }
          );
        });
      }
      on FirebaseAuthException catch (ex) {
        return CustomAlertBox(context, ex.code.toString());
      }
    }
  }
  static CustomAlertBox(BuildContext context, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text,style: TextStyle(color: Colors.red),),
      );
    });
  }


  var mailphone=TextEditingController();
  var password=TextEditingController();
  var passwordconfirm=TextEditingController();
  var res='';
  bool passwordvisible=true;
  bool passwordvisibleconfirm=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                [

                  Colors.black,
                  Colors.pink,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      child: Center(child: Text('Phone\nVerification', style: TextStyle(fontFamily:'Stylish', fontSize: 50,color: Colors.white),)),                        ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Center(
                      child: Container(
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: mailphone,

                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Enter phone number',
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'Enter phone number',
                                hintStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 4,
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    )
                                ),
                                prefixIcon: Icon(Icons.phone, color: Colors.white,),
                              ),


                            ),


                            SizedBox(
                              height: 40,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(

                        onPressed: () async {

                          logIn(mailphone.text, password.text);

                        },
                        child: Text('Get OTP',style: TextStyle(fontSize: 20),),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),


                      ),

                    ),
                  ),


                ],

              ),
            ),
          ),
        )
    );

  }
}
