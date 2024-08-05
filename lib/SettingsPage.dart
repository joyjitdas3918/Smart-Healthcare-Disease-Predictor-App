import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:smart_healthcare/DiseasePredictorPage.dart';
import 'package:smart_healthcare/LoginPage.dart';
import 'package:smart_healthcare/NearbyLabs.dart';
import 'package:smart_healthcare/SlashPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_healthcare/SplashScreen.dart';
class SettingsPage extends StatefulWidget {  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var name=TextEditingController();
  var mailphone=TextEditingController();
  var password=TextEditingController();
  var newpassword=TextEditingController();
  var newpasswordconfirm=TextEditingController();
  var res='';
  bool passwordvisible=true;
  bool newpasswordvisible=true;
  bool passwordvisibleconfirm=true;

  resetPassword(String mail, String pass, String newpass, String newpassconf) async {
    if (mail == "" || pass == "" || newpass == "" || newpassconf == "") {
      CustomAlertBox(context, 'Enter required fields');
    }
    else if(newpass!=newpassconf){
      CustomAlertBox(context, 'New password didn\'t match');
    }
    else{
      final user = await FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: mail, password: pass);

      user!.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newpass).then((_) {
          CustommAlertBox(context, 'Password updated succesfully');
          setState(() {
            name.clear();
            password.clear();
            mailphone.clear();
            newpassword.clear();
            newpasswordconfirm.clear();

          });
        }).catchError((error) {
          CustomAlertBox(context, 'Weak Password');
        });
      }).catchError((err) {
        CustomAlertBox(context, 'Incorrect credential entered');
      });
    }
  }
  updateName(String mail, String pass, String nam) async {
    if (mail == "" || pass == "" || nam == "") {
      CustomAlertBox(context, 'Enter required fields');
    }
    else {

      final user = await FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: mail, password: pass);

      user!.reauthenticateWithCredential(cred).then((value) async {
        int f = 0;
        try {
          var pref = await SharedPreferences.getInstance();


          CollectionReference collRef = FirebaseFirestore.instance.collection(
              'user');
          collRef.doc(mail).set({
            'name': nam,
            'email': mail,
          },
            SetOptions(merge: true),
          );
          CustommAlertBox(context, 'Name updated successfully');
          setState(() {
            name.clear();
            password.clear();
            mailphone.clear();
            newpassword.clear();
            newpasswordconfirm.clear();

          });
        }

        on FirebaseAuthException catch (ex) {
          f = 1;
          return CustomAlertBox(context, ex.code.toString());
        }
      }).catchError((err) {
        CustomAlertBox(context, 'Incorrect credential entered');
      });
      //Navigator.of(context).pop();
    }
  }

  static CustommAlertBox(BuildContext context, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text,style: TextStyle(color: Colors.green),),
      );
    });
  }
  static CustomAlertBox(BuildContext context, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text,style: TextStyle(color: Colors.red),),
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Colors.pink,
            width: 4,
          ),

        ),
        elevation: 4,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showModalBottomSheet(context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        Container(
                          height: 90,
                          width: double.infinity,

                          child: InkWell(

                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return DiseasePredictorPage();
                              },
                              ),
                              );

                            },
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('  🤔 Disease Predictor',
                                  style: TextStyle(fontSize: 27,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),)),

                          ),
                        ),
                        Container(
                          height: 90,
                          width: double.infinity,

                          child: InkWell(

                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return NearbyLabs();
                              },
                              ),
                              );

                            },
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('  📍 Nearby Labs', style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),)),

                          ),
                        ),
                        Container(
                          height: 90,
                          width: double.infinity,

                          child: InkWell(

                            onTap: () async {
                              var pref = await SharedPreferences.getInstance();
                              pref.setBool("login", false);
                              try {
                                await FirebaseAuth.instance.signOut();
                                var pref=await SharedPreferences.getInstance();

                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                      return SlashPage();
                                    },
                                    ),
                                        (r) {
                                      return false;
                                    }
                                );
                              }
                              on FirebaseAuthException catch (ex) {
                                return CustomAlertBox(context, ex.code.toString());
                              }

                            },
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      '   ', style: TextStyle(fontSize: 27),),
                                    Icon(Icons.logout,
                                        size: 27,
                                        color: Colors.red
                                    ),


                                    Text(' Logout', style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red),),
                                  ],
                                )),

                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            , icon: Icon(
            Icons.list,
            color: Colors.white,

            size: 45,
          ),
          ),
        ],
        title: Text(
          'Settings', style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Colors.black,
      ),
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

                  Container(
                    child: Center(
                      child: Container(
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

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
                                  labelText: 'Enter current password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: 'Enter current password',
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

                            Divider(
                              color: Colors.pink,
                            ),
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
                              style: TextStyle(color: Colors.white),
                              obscureText: newpasswordvisible,
                              controller: newpassword,
                              decoration: InputDecoration(
                                  labelText: 'Enter new password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: 'Enter new password',
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
                                        newpasswordvisible? Icons.visibility:Icons.visibility_off),
                                    onPressed: (){
                                      setState(() {
                                        newpasswordvisible=!newpasswordvisible;
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
                              controller: newpasswordconfirm,
                              decoration: InputDecoration(
                                  labelText: 'Confirm new password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: 'Confirm new password',
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
                      height: 60,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ElevatedButton(

                              onPressed: (){

                                updateName(mailphone.text,password.text,name.text);

                              },

                              child: Text('Update\nname',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                              ),

                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(

                              onPressed: (){

                                resetPassword(mailphone.text,password.text,newpassword.text,newpasswordconfirm.text);

                                },

                              child: Text('Reset\nPassword',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),


                ],

              ),
            ),
          ),
        )

    );
  }


}
