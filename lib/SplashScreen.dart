import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_healthcare/LoginPage.dart';
import 'package:smart_healthcare/SlashPage.dart';
import 'package:smart_healthcare/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool login=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
    Timer(const Duration(seconds:2), () {
      if(login==false) {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) {
          return SlashPage();
        },
        ),

        );
      }
      else{
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) {

          return const MyHomePage();
        },
        ),

        );
      }
    },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(

                color: Colors.black,
                ),
                child: Center(
                  child: Text(
        'DiagnoScope',
      style: TextStyle(
        fontSize: 50,
        color: Colors.pink,
        fontFamily: 'Stylish',
      ),
    ),
                ),
            ),
        ],
      ),

    );
  }

  Future<void> getValue() async {
    var pref=await SharedPreferences.getInstance();
    login=pref.getBool("login")??false;
  }
}