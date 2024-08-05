import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_healthcare/LoginPage.dart';
import 'package:smart_healthcare/PhoneVerificationPage.dart';
import 'package:smart_healthcare/SignupPage.dart';

class SlashPage extends StatefulWidget {  @override
  State<SlashPage> createState() => _SlashPageState();
}

class _SlashPageState extends State<SlashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              child: Text('Get started', style: TextStyle(fontFamily:'Stylish', fontSize: 50,color: Colors.white),),                        ),
                          ),
                          SizedBox(
                            height: 50,
                          ),

                          Center(
                            child: Container(
                              height: 300,
                              width: 300,
                              child: CircleAvatar(
                                radius: 150,
                                  backgroundImage: const AssetImage('assets/images/doctor-welcoming-with-namaste-hand-gesture-2656109-2215045.png'),
                                backgroundColor: Colors.black12,

                              ),

                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Container(
                              height: 50,
                              width: 200,
                              child: ElevatedButton(

                                onPressed: (){

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  },
                                  ),
                                  );
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
                            child: Container(
                              height: 50,
                              width: 200,

                              child: ElevatedButton(

                                onPressed: (){

                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return SignupPage();
                                  },
                                  ),
                                  );
                                },
                                child: Text('Signup',style: TextStyle(fontSize: 20)),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                ),

                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              height: 50,
                              width: 200,

                              // child: Center(
                              //   child: InkWell(
                              //
                              //     onTap: (){
                              //
                              //       Navigator.push(context, MaterialPageRoute(builder: (context) {
                              //         return PhoneVerificationPage();
                              //       },
                              //       ),
                              //       );
                              //     },
                              //     child: Text('Continue with Phone Number',style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.w800)),),
                              // )


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
