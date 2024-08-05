import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:smart_healthcare/DiseasePredictorPage.dart';
import 'package:smart_healthcare/LoginPage.dart';
import 'package:smart_healthcare/NearbyLabs.dart';
import 'package:smart_healthcare/SettingsPage.dart';
import 'package:smart_healthcare/SlashPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_healthcare/SplashScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiseasePredictorPage extends StatefulWidget {  @override
  State<DiseasePredictorPage> createState() => _DiseasePredictorPageState();
}

class _DiseasePredictorPageState extends State<DiseasePredictorPage> {
  String dropdownvalue='None';

  var items = [
    'None',
    'Diabetes',
    'Heart Disease',
  ];
  var itemsgender = [
    '',
    'Male',
    'Female',
  ];
  var itemsfamily = [
    '',
    'Yes',
    'No',
  ];

  String gender='';
  var height=TextEditingController();
  var age=TextEditingController();
  var weight=TextEditingController();
  var preg=TextEditingController();
  var plasma=TextEditingController();
  var dia=TextEditingController();
  var serum=TextEditingController();
  var heartrate=TextEditingController();

  String family='';
  var familynum=TextEditingController();
  String diabet='';
  var itemsdiabet = [
    '',
    'Yes',
    'No',
  ];
  var cig=TextEditingController();
String pressure='';
  var itemspressure = [
    '',
    'Yes',
    'No',
  ];
String stroke='';
  var itemsstroke = [
    '',
    'Yes',
    'No',
  ];
String hyper='';
  var itemshyper = [
    '',
    'Yes',
    'No',
  ];
  String diabhad='';
  var itemsdiabhad = [
    '',
    'Yes',
    'No',
    'I don\'t know',
  ];
  var chol=TextEditingController();
  var sys=TextEditingController();
  var glucose=TextEditingController();
String hearthad='';
var relations=[
  '',
  'Parent',
  'Full Sibling',
  'Half Sibling',
  'Grandparent',
  'Aunt',
  'Uncle',
  'Half Aunt',
  'Half Uncle',
  'First Cousin',

];
  var itemshearthad = [
    '',
    'Yes',
    'No',
    'I don\'t know',
  ];
  List <String> dpfa=[];
  List <String> dpfb=[];
  List <TextEditingController> dpfc=[];
  final formkey=GlobalKey<FormState>();


  static CustommmAlertBox(BuildContext context,Color col, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: col,
        title: Text(text,style: TextStyle(color: Colors.black),),
      );
    });
  }

  static CustomAlertBox(BuildContext context, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.white,
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
                                return SettingsPage();
                              },
                              ),
                              );

                            },
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('   ⚙️ Settings', style: TextStyle(
                                    fontSize: 27,
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
          'Disease Predictor', style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors:
                  [
                    Colors.black,
                    Colors.pink,
                  ],
                )
            ),
          ),

          Align(
              alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(

              children:[Text('Select Disease',style: TextStyle(fontSize: 23,color: Colors.white),),
              Container(
                color: Colors.white,
                height: 30,
                child: DropdownButton(

                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items,style: TextStyle(color: Colors.black),),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
                if(dropdownvalue=='None') Center(child: Text('Please select a disease',style: TextStyle(color: Colors.white,fontSize: 20),)),
                if(dropdownvalue!='None') Text('Enter the fields',style: TextStyle(color: Colors.white,fontSize: 20),),

    ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 121.0),
            child: Container(

              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(left: 11.0, right: 11.0, bottom: 11.0,top: 11.0),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                            if(dropdownvalue=='Diabetes') Column(
                              children: [
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: age,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Enter age',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Enter age',
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
                                    // prefixIcon: Icon(Icons, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: height,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Enter height (in cm)',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Enter height(in cm)',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: weight,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Enter weight (in kg)',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Enter weight (in kg)',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: preg,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'How many times were you pregnant?',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'How many times were you pregnant?',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: plasma,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: '2-hour plasma glucose level',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: '2-hour plasma glucose level',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: dia,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Diastolic blood pressure (in mm Hg)',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Diastolic blood pressure (in mm Hg)',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Column(
                                  children:[Text('Add diabetic history: ',style: TextStyle(fontSize: 21
                                      ,color: Colors.white),),
                                    SizedBox(
                                      height:10,
                                    ),

                                    InkWell(
                                      onTap: (){

                                        addfield();
                                      },
                                      child: const Icon(Icons.add_circle,color: Colors.white,),
                                    ),

                ],
              ),
                Form(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      itemCount: dpfa.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    removefield(index);
                                    print(dpfb);
                                  },
                                  child: const Icon(Icons.remove_circle, color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: DropdownButtonFormField(
                                    value: dpfa[index],
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    dropdownColor: Colors.black54,
                                    items: itemsfamily.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dpfa[index] = newValue!;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Diabetic?',
                                      labelStyle: TextStyle(color: Colors.white),
                                      hintText: 'Diabetic?',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 4,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormField(
                                    value: dpfb[index],
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    dropdownColor: Colors.black54,
                                    items: relations.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dpfb[index] = newValue!;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Relation',
                                      labelStyle: TextStyle(color: Colors.white),
                                      hintText: 'Relation',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 4,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: dpfc[index],
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Age',
                                      labelStyle: TextStyle(color: Colors.white),
                                      hintText: 'Age',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 4,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(22),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),


                // DropdownButtonFormField(
                                //
                                //   // Initial Value
                                //   value: family,
                                //
                                //   // Down Arrow Icon
                                //   icon: const Icon(
                                //       Icons.keyboard_arrow_down,
                                //     color: Colors.white,
                                //   ),
                                //
                                //   // Array list of items
                                //   dropdownColor: Colors.black54,
                                //   items: itemsfamily.map((String items) {
                                //     return DropdownMenuItem(
                                //       value: items,
                                //       child: Text(items,style: TextStyle(color: Colors.white),),
                                //     );
                                //   }).toList(),
                                //   // After selecting the desired option,it will
                                //   // change button value to selected value
                                //   onChanged: (String? newValue) {
                                //     setState(() {
                                //       family = newValue!;
                                //     });
                                //   },
                                //   decoration: InputDecoration(
                                //     labelText: 'Do you have any diabetic family history?',
                                //     labelStyle: TextStyle(color: Colors.white),
                                //     hintText: 'Do you have any diabetic family history?',
                                //     hintStyle: TextStyle(color: Colors.white),
                                //     focusedBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(22),
                                //         borderSide: BorderSide(
                                //           color: Colors.white,
                                //           width: 4,
                                //         )
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(22),
                                //         borderSide: BorderSide(
                                //           color: Colors.grey,
                                //           width: 2,
                                //         )
                                //     ),
                                //     // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                //
                                // TextField(
                                //   keyboardType: TextInputType.number,
                                //   controller: familynum,
                                //   style: TextStyle(color: Colors.white),
                                //   decoration: InputDecoration(
                                //     labelText: 'Number of genetically related people with diabetic history',
                                //     labelStyle: TextStyle(color: Colors.white),
                                //     hintText: 'Number of genetically related people with diabetic history',
                                //     hintStyle: TextStyle(color: Colors.white),
                                //     focusedBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(22),
                                //         borderSide: BorderSide(
                                //           color: Colors.white,
                                //           width: 4,
                                //         )
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(22),
                                //         borderSide: BorderSide(
                                //           color: Colors.grey,
                                //           width: 2,
                                //         )
                                //     ),
                                //     // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                //   ),
                                //
                                //
                                // ),

                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(onPressed:(){
                                  if(age.text=='' && height.text==''&& weight.text==''&& preg.text=='' && plasma.text==''&&dia.text==''&& serum.text==''&&family==''&& familynum.text=='') CustomAlertBox(context, 'You have not entered a single field!');
                                  else Submit();
                                  }, child: Text('Submit')),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            if(dropdownvalue=='Heart Disease') Column(
                              children: [
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: age,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Enter age',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Enter age',
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
                                    // prefixIcon: Icon(Icons, color: Colors.white,),
                                  ),



                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField(

                                  // Initial Value
                                  value: gender,

                                  // Down Arrow Icon
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),

                                  // Array list of items
                                  dropdownColor: Colors.black54,
                                  items: itemsgender.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,style: TextStyle(color: Colors.white),),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      gender = newValue!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Enter your gender',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Enter your gender',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: height,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Enter height (in cm)',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Enter height(in cm)',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: weight,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Enter weight (in kg)',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Enter weight (in kg)',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: cig,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'How many times do you smoke in a day?',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'How many times do you smoke in a day?',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField(

                                  // Initial Value
                                  value: pressure,

                                  // Down Arrow Icon
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),

                                  // Array list of items
                                  dropdownColor: Colors.black54,
                                  items: itemspressure.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,style: TextStyle(color: Colors.white),),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      pressure = newValue!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Were you on blood pressure medication?',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Were you on blood pressure medication?',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField(

                                  // Initial Value
                                  value: stroke,

                                  // Down Arrow Icon
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),

                                  // Array list of items
                                  dropdownColor: Colors.black54,
                                  items: itemsstroke.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,style: TextStyle(color: Colors.white),),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      stroke = newValue!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Did you previously had a stroke?',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Did you previously had a stroke?',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField(

                                  // Initial Value
                                  value: hyper,

                                  // Down Arrow Icon
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),

                                  // Array list of items
                                  dropdownColor: Colors.black54,
                                  items: itemshyper.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,style: TextStyle(color: Colors.white),),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      hyper = newValue!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Are/Were you hypertensive?',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Are/Were you hypertensive?',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField(

                                  // Initial Value
                                  value: diabhad,

                                  // Down Arrow Icon
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),

                                  // Array list of items
                                  dropdownColor: Colors.black54,
                                  items: itemsdiabhad.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,style: TextStyle(color: Colors.white),),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      diabhad = newValue!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Do you have/had diabetes?',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Do you have/had diabetes?',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: chol,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Total cholesterol level',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Total cholesterol level',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: sys,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Systolic blood pressure (in mm Hg)',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Systolic blood pressure (in mm Hg)',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: dia,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Diastolic blood pressure',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Diastolic blood pressure',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: glucose,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Glucose level',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Glucose level',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: heartrate,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Heart Rate (in bpm)',
                                    labelStyle: TextStyle(color: Colors.white),
                                    hintText: 'Heart Rate (in bpm)',
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
                                    // prefixIcon: Icon(Icons.mail, color: Colors.white,),
                                  ),


                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(onPressed:(){
                                  if(age.text=='' && gender=='' && height.text==''&& weight.text==''&& cig.text=='' && pressure==''&& stroke==''&& hyper==''&&diabhad==''&& chol.text=='' && sys.text=='' && dia.text=='' && glucose.text=='') CustomAlertBox(context, 'You have not entered a single field!');
                                  else Submit();
                                  }, child: Text('Submit')),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  Future<void> makePredictionRequestdiab() async {
    String url = 'https://389e-35-196-247-33.ngrok-free.app/diabetes_prediction';
    // Data for the prediction
    var mon=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',];
    List<int> add=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0];
    int curronth=DateTime.now().month;
    int currYear=DateTime.now().year;
    var currm=mon[curronth-1]+'\''+(currYear).toString().substring(2);
    // var mail;

    var mail= FirebaseAuth.instance.currentUser!.email;

    double numerator=20.000;
    double denominator=50.000;
    for(int i=0;i<dpfa.length;i++){
      var k=0.000;
      if(dpfb[i]=='Parent' || dpfb[i]=='Full Sibling') k=0.500;
      else if(dpfb[i]=='Half Sibling' || dpfb[i]=='Grandparent' || dpfb[i]=='Aunt' || dpfb[i]=='Uncle') k=0.250;
      else if(dpfb[i]=='Half Aunt' || dpfb[i]=='Half Uncle' || dpfb[i]=='First Cousin') k=0.125;
      if(dpfa[i]=='Yes'){
        numerator+=k*(88.000-double.parse(dpfc[i].text));
      }
      else if(dpfa[i]=='No'){

        denominator+=k*(double.parse(dpfc[i].text)-14.000);
      }
    }
    //print(numerator/denominator);
    Map<String, dynamic> inputDataForModel = {
      'Pregnancies': int.parse(preg.text),
      'Glucose': int.parse(plasma.text),
      'BloodPressure': int.parse(dia.text),
      'BMI' : (10000.0*double.parse(weight.text))/((double.parse(height.text)*double.parse(height.text))),
      'DiabetesPedigreeFunction': numerator/denominator,
      'Age': int.parse(age.text)
      //'Pregnancies' : 9,
      //'Glucose' : 89,
      // 'BloodPressure' : 62,
      // 'BMI' : 0,
      // 'DiabetesPedigreeFunction' : 0.142,
      // 'Age' : 33
    };

    try{
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(inputDataForModel),
      );
      if (response.statusCode == 200) {
        // Check if the response is JSON
        if (response.headers['content-type']!.contains('application/json')) {
          int responseData= json.decode(response.body);
          // Process responseData as needed

          if(responseData==0) CustommmAlertBox(context,Colors.green,'You don\'t have diabetes');
          if(responseData==1) CustommmAlertBox(context,Colors.red,'You have diabetes');
          if(responseData==2) CustommmAlertBox(context,Colors.yellow,'You may have diabetes');
          CollectionReference collRef = FirebaseFirestore.instance.collection(
              'user');
          collRef.doc(mail).update({
            'diabResult.$currm':responseData,
          },
          );
          print('Response is $responseData');
          //CustomAlertBox(context, responseData);
        } else {
          // Handle unexpected HTML response
          print('Unexpected HTML response: ${response.body}');
        }
      } else {
        // Handle errors
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception occured: $e');
    }
  }
  Future<void> makePredictionRequestheart() async {
    var mon=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',];
    List<int> add=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0];
    int curronth=DateTime.now().month;
    int currYear=DateTime.now().year;
    var currm=mon[curronth-1]+'\''+(currYear).toString().substring(2);
    // var mail;

    var mail= FirebaseAuth.instance.currentUser!.email;

      //SetOptions(merge: true),



    String url = 'https://49a1-34-67-120-143.ngrok-free.app/heartDiseases';
    // Data for the prediction
    Map<String, dynamic> inputDataForModel = {
      'Sex': gender.toString(),
      'Age' : double.parse(age.text),
      'BP_med': pressure.toString(),
      'Prev_stroke': stroke.toString(),
      'Pre_Hyp': hyper.toString(),
      'diabetes': diabhad.toString(),
      'Total_cholesterol': int.parse(chol.text),
      'SysBP': int.parse(sys.text),
      'DiaBP': int.parse(dia.text),
      'BMI' : (10000.0*double.parse(weight.text))/((double.parse(height.text)*double.parse(height.text))),
      'HeartRate': int.parse(heartrate.text),
      'Glucose': int.parse(glucose.text),
      'Cigrate_per_day': double.parse(cig.text)
    // 'Age' : 100,
    // 'Total_cholesterol': 500,
    // 'SysBP': 500,
    // 'DiaBP': 230,
    // 'BMI': 20,
    // 'HeartRate': 34,
    // 'Glucose': 210,
    // 'Cigrate_per_day': 12,
    };


    try{
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(inputDataForModel),
      );

      if (response.statusCode == 200) {
        // Check if the response is JSON
        if (response.headers['content-type']!.contains('application/json')) {
          String responseData= json.decode(response.body);
          // Process responseData as needed
          if(responseData==0) CustommmAlertBox(context,Colors.green,'You don\'t have heart disease');
          if(responseData==1) CustommmAlertBox(context,Colors.red,'You have heart disease');
          if(responseData==2) CustommmAlertBox(context,Colors.yellow,'You may have heart disease');
    CollectionReference collRef = FirebaseFirestore.instance.collection(
    'user');
    collRef.doc(mail).update({
    'heartResult.$currm':responseData,
    },
    );
          print('Response is $responseData');
          //CustomAlertBox(context, responseData);
        } else {
          // Handle unexpected HTML response
          print('Unexpected HTML response: ${response.body}');
        }
      } else {
        // Handle errors
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception occured: $e');
    }
  }
  void Submit() {

    if(dropdownvalue=='Diabetes')makePredictionRequestdiab();
    if(dropdownvalue=='Heart Disease')makePredictionRequestheart();

    dpfa=[];
    dpfb=[];
    dpfc=[];
    setState(() {
      gender='';
      height=TextEditingController();
      age=TextEditingController();
      weight=TextEditingController();
      preg=TextEditingController();
      plasma=TextEditingController();
      dia=TextEditingController();
      serum=TextEditingController();
      family='';
      familynum=TextEditingController();
      diabet='';
      cig=TextEditingController();
      pressure='';
      stroke='';
      hyper='';
      diabhad='';
      chol=TextEditingController();
      sys=TextEditingController();
      glucose=TextEditingController();
      hearthad='';
      heartrate=TextEditingController();



    });
  }
  addfield(){
      dpfa.add('');
      dpfb.add('');
      dpfc.add(TextEditingController());

      setState(() {

      });
  }
  Future<void> removefield(int index) async {
    // Simulating an asynchronous operation with a delay
    await Future.delayed(Duration(seconds: 1));

    // Modify the list inside setState
    setState(() {
      dpfa.removeAt(index);
      dpfb.removeAt(index);
      dpfc.removeAt(index);
    });
  }

  
}
