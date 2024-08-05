import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_healthcare/SignupPage.dart';
import 'package:smart_healthcare/main.dart';

import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  Future logIn(String email, String password) async {
    if (email == "" || password == "") {
      CustomAlertBox(context, "Enter Required Fields");
    }
    else {

      UserCredential? usercredential;
      try {
        showDialog(context: context, builder: (context){
          return Center(child: CircularProgressIndicator(),);
        },
        );
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password).then((value) async {
          var pref=await SharedPreferences.getInstance();

          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) {
            pref.setBool("login", true);
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
                      child: Text('Login', style: TextStyle(fontFamily:'Stylish', fontSize: 50,color: Colors.white),),                        ),
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
                                labelText: 'Enter email',
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'Enter email',
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
                                prefixIcon: Icon(Icons.mail, color: Colors.white,),
                              ),


                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              style: TextStyle(color: Colors.white),
                              obscureText: passwordvisible,
                              controller: password,
                              decoration: InputDecoration(
                                  labelText: 'Enter password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: 'Enter password',
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
                                  prefixIcon: Icon(Icons.lock, color: Colors.white,),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        color:Colors.white,
                                        passwordvisible? Icons.visibility:Icons.visibility_off),
                                    onPressed: (){
                                      setState(() {
                                        passwordvisible=!passwordvisible;
                                      });
                                    },
                                  )

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
                        child: Text('Login',style: TextStyle(fontSize: 20),),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),


                      ),

                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account? ', style: TextStyle(fontSize:17, color: Colors.white),),
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return SignupPage();
    },
    ),
    );
                          },
                          child: Text('Signup', style: TextStyle(fontSize:17, color: Colors.black, fontWeight:FontWeight.w700),),
                        )
                      ],
                    ),
                  )


                ],

              ),
            ),
          ),
        )
    );

  }}
