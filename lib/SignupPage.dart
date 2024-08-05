
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_healthcare/LoginPage.dart';
import 'package:smart_healthcare/main.dart';

import 'package:shared_preferences/shared_preferences.dart';


class SignupPage extends StatefulWidget {  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  signUp(String email, String password, String name) async {
    if (email == "" || password == ""|| name==""){
      CustomAlertBox(context, "Enter Required Fields");
    }
    else{
      UserCredential? usercredential;
      int f=0;
      List<String> months=[];
      List<num> diab=[];
      List<num> heart=[];
      List<num> park=[];
      Map<String,num> hD={};
      Map<String,num> dD={};
      try{
        showDialog(context: context, builder: (context){
          return Center(child: CircularProgressIndicator(),);
        },
        );
        usercredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async{
          var pref=await SharedPreferences.getInstance();

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
            CollectionReference collRef=FirebaseFirestore.instance.collection('user');
            collRef.doc(email).set({
              'name':name,
              'email':email,
              'months':months,
              'diab':diab,
              'heart':heart,
              'park':park,
              'heartResult':hD,
              'diabetesResult':dD,
            },
              SetOptions(merge: true),
            );

            pref.setBool("login", true);
            return MyHomePage();
          },
          ),
                  (r){
                return false;
              }
          );
        });
      }
      on FirebaseAuthException catch(ex){
        f=1;
        return CustomAlertBox(context, ex.code.toString());
      }
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      //   return MyHomePage();
      // },
      // ),
      //         (r){
      //       return false;
      //     }
      // );
    }
  }
  static CustomAlertBox(BuildContext context, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text,style: TextStyle(color: Colors.red),),
      );
    });
  }
  var name=TextEditingController();
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
                      child: Text('Signup', style: TextStyle(fontFamily:'Stylish', fontSize: 50,color: Colors.white),),                        ),
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
                              controller: name,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Enter your name',
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'Enter your name',
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
                                prefixIcon: Icon(Icons.person, color: Colors.white,),
                              ),


                            ),
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
                              height: 20,
                            ),

                            TextField(
                              style: TextStyle(color: Colors.white),
                              obscureText: passwordvisibleconfirm,
                              controller: passwordconfirm,
                              decoration: InputDecoration(
                                  labelText: 'Confirm password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: 'Confirm password',
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
                                        passwordvisibleconfirm? Icons.visibility:Icons.visibility_off),
                                    onPressed: (){
                                      setState(() {
                                        passwordvisibleconfirm=!passwordvisibleconfirm;
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

                        onPressed: (){
                          if(password.text!=passwordconfirm.text){
                            CustomAlertBox(context, "Password didn't match");
                          }
                          else signUp(mailphone.text, password.text, name.text);

                        },
                        
                        child: Text('Signup',style: TextStyle(fontSize: 20),),
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
                        Text('Already have an account? ', style: TextStyle(fontSize:17, color: Colors.white),),
                        InkWell(
                          onTap: () async {
                            var pref=await SharedPreferences.getInstance();
                            pref.setBool("login", true);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            },
                            ),
                            );
                          },
                          child: Text('Login', style: TextStyle(fontSize:17, color: Colors.black, fontWeight:FontWeight.w700),),
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
  }


}
