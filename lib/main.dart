
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
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

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyBC2MKvsHAMV8q7o9F6yWnWF2-sfTpeG8o", appId: "1:30346209467:android:5e5965e5bb3f57c996619e", messagingSenderId: "30346209467", projectId: "diagnoscope-29e97")
    );
    runApp(const MyApp());
  }


class Probability{
  final String x;
  final num y;
  Probability({required this.x, required this.y});
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        primarySwatch: Colors.pink,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.grey.shade900),
      // textTheme:
      //   const TextTheme(displayLarge: TextStyle(color: Colors.white),
      //     displayMedium: TextStyle(color: Colors.white),
      //     displaySmall: TextStyle(color: Colors.white),
      //   ),
      ),

      // home:Geo(),
      home: SplashScreen(),
      // home: LoginPage(),
      // home: const MyHomePage(),
    );
  }

}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {


  String dropdownvalue='None';
  var user= FirebaseAuth.instance.currentUser;
  var name="user";
  bool diabetes=false;
  bool heart=false;
  bool parkinsons=false;
  var diabcol=Colors.transparent;
  var heartcol=Colors.transparent;
  var parkcol=Colors.transparent;
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
    });
  }



  void AlertBox(BuildContext context, String text){
    showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(text,style: TextStyle(color: Colors.red),),
      ));
  }

  static CustomAlertBox(BuildContext context, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text,style: TextStyle(color: Colors.red),),
      );
    });
  }
  // var months;
  // var diab;
  // var heartD;
  // var park;
  // List <Probability> blank=[];
  // List<Probability> D=[];
  // List<Probability> H=[];
  // List<Probability> P=[];

  // int size1=[20,22,20,20,20,20]as int;
  // int size2=[20,19,20,20,20,20]as int;
  // int size3=[20,19,20,20,20,20]as int;
  var col1=[Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey];
  var col2=[Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey];
  var col3=[Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey];
  var mon=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',];
  List<int> add=[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0];

  var month=[];


  @override
  Widget build(BuildContext context) {


    DateTime now =new DateTime.now();

    int curronth=DateTime.now().month;
    int currYear=DateTime.now().year;


    int flag=0;
    Map<String,int> details={'Jan\'23':1};
    month.clear();
    for(int i=curronth+6;i<=curronth+11;i++){
      month.add(mon[i]+'\''+(currYear+add[i]).toString().substring(2));
    }
    if(user!=null) {

      FirebaseFirestore.instance.collection('user').doc(user!.email)
          .get()
          .then((DocumentSnapshot doc) {
        Map<String, dynamic> map = doc.data()! as Map<String, dynamic>;
        name = map['name'];
        // months=map['months'];
        // diab=map['diab'];
        // heartD=map['heart'];
        // park=map['park'];
        var mapping=map['diabResult'];
        if(dropdownvalue=='Diabetes'){

          for(int i=0;i<6;i++){
            if(mapping.containsKey(month[i])){
              int resultdiab=mapping[month[i]];
              if(resultdiab==0) col3[i]=(Colors.green);
              if(resultdiab==1) col1[i]=(Colors.red);
              if(resultdiab==2) col2[i]=(Colors.yellow);
              //print(col1[i]);

            }
            else{
              col3[i]=(Colors.grey);
              col1[i]=(Colors.grey);
              col2[i]=(Colors.grey);
            }
          }
        }
        else if(dropdownvalue=='Heart Disease'){
          var mapping=map['heartResult'];

            for(int i=0;i<6;i++){
              if(mapping.containsKey(month[i])){
                int resultdiab=mapping[month[i]];
                if(resultdiab==0) col3[i]=(Colors.green);
                if(resultdiab==1) col1[i]=(Colors.red);
                if(resultdiab==2) col2[i]=(Colors.yellow);
                //print(col1[i]);

              }
              else{
                col3[i]=(Colors.grey);
                col1[i]=(Colors.grey);
                col2[i]=(Colors.grey);
              }
            }
        }
        else{
          for(int i=0;i<6;i++){
              col3[i]=(Colors.grey);
              col1[i]=(Colors.grey);
              col2[i]=(Colors.grey);
          }
        }
        setState(() {
          // D=[];
          // H=[];
          // P=[];
          // blank=[];
        });
      });
      name+=" ";
      name=name.substring(0,name.indexOf(' '));
      if(name.length>10) name=name.substring(0,9)+"...";
    }
    var items = [
      'None',
      'Diabetes',
      'Heart Disease',
    ];
    // for(int i=0;i<months.length;i++){
    //   blank.add(Probability(x: months[i], y: 1));
    // }
    // for(int i=0;i<diab.length;i++){
    //   if(diab[i]!=-1) D.add(Probability(x: months[i], y:diab[i]));
    // }
    // for(int i=0;i<heartD.length;i++){
    //   if(heartD[i]!=-1) H.add(Probability(x: months[i], y:heartD[i]));
    // }
    // for(int i=0;i<park.length;i++){
    //   if(park[i]!=-1) P.add(Probability(x: months[i], y:park[i]));
    // }

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
                    height: 390,
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
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
          'Dashboard', style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Colors.black,
      ),
  //     body: Stack(
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 begin: FractionalOffset.topCenter,
  //                 end: FractionalOffset.bottomCenter,
  //                 colors:
  //                 [
  //                   Colors.black,
  //                   Colors.pink,
  //                 ],
  //               )
  //           ),
  //         ),
  //         Container(
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 11.0, left: 11.0, right: 11.0),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     CircleAvatar(
  //                       radius: 30,
  //                       child: Text('${name[0]}', style: TextStyle(fontSize: 30),),
  //                       //backgroundImage: AssetImage('assets/images/channels4_profile.jpg'),
  //                       backgroundColor: Colors.pink,
  //                     ),
  //                     SizedBox(
  //                       width: 20,
  //                     ),
  //                     Container(
  //                         child: Text('Hi ${name}!👋', style: const TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 30,
  //                             fontWeight: FontWeight.w500,
  //                             fontFamily: 'Stylish'),)),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   child: Column(
  //
  //                     children: [
  //                       SizedBox(
  //                         height: 21,
  //                       ),
  //                       Row(
  //                     children:[
  //                       Text('Diabetes: ',style: TextStyle(color: Colors.white,fontSize: 21),),
  //
  //                       InkWell(
  //                         onTap: (){
  //                           if(diabetes==false){
  //                             diabetes=true;
  //                             diabcol=Colors.green;
  //                           }
  //                           else{
  //                             diabetes=false;
  //                             diabcol=Colors.transparent;
  //                           }
  //                           setState(() {
  //
  //                           });
  //                         },
  //                         child: Container(
  //                           height: 21,
  //                           width: 21,
  //
  //                           decoration: BoxDecoration(border: Border.all(color: Colors.white),
  //                             color: diabcol,
  //                           ),
  //                         ),
  //                       )
  //
  //                       ]
  //                       ),
  //                       Row(
  //                         children: [
  //                           Text('Heart Disease: ',style: TextStyle(color: Colors.white,fontSize: 21),),
  //                           InkWell(
  //                             onTap: (){
  //                               if(heart==false){
  //                                 heart=true;
  //                                 heartcol=Colors.red;
  //                               }
  //                               else{
  //                                 heart=false;
  //                                 heartcol=Colors.transparent;
  //                               }
  //                               setState(() {
  //
  //                               });
  //                             },
  //                             child: Container(
  //                               height: 21,
  //                               width: 21,
  //
  //                               decoration: BoxDecoration(border: Border.all(color: Colors.white),
  //                                 color: heartcol,
  //                               ),
  //                             ),
  //                           )
  //                       ]
  //                       ),
  //                       Row(
  //                         children:[
  //                       Text('Parkinson\'s Disease: ',style: TextStyle(color: Colors.white,fontSize: 21),),
  //                           InkWell(
  //                             onTap: (){
  //                               if(parkinsons==false){
  //                                 parkinsons=true;
  //                                 parkcol=Colors.blue;
  //                               }
  //                               else{
  //                                 parkinsons=false;
  //                                 parkcol=Colors.transparent;
  //                               }
  //                               setState(() {
  //
  //                               });
  //                             },
  //                             child: Container(
  //                               height: 21,
  //                               width: 21,
  //
  //                               decoration: BoxDecoration(border: Border.all(color: Colors.white),
  //                                 color: parkcol,
  //                               ),
  //                             ),
  //                           )
  //
  //                           ]
  //                       ),
  //                       SizedBox(
  //                         height: 15,
  //                       )
  //
  //                     ],
  //
  //                   ),
  //
  //                 ),
  //                 Expanded(
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         border: Border.all(color: Colors.black),
  //                         boxShadow: [
  //                           BoxShadow(blurRadius:12.0,spreadRadius: 3.0)
  //                           ],
  //                       ),
  //                       child: SfCartesianChart(
  //                         zoomPanBehavior: ZoomPanBehavior(
  //                           enableDoubleTapZooming: true,
  //                           enablePanning: true,
  //                           enablePinching: true,
  //                           enableSelectionZooming: true,
  //                           enableMouseWheelZooming: true,
  //                         ),
  //                         primaryXAxis: CategoryAxis(
  //                             // labelStyle: TextStyle(
  //                             //   color: Colors.white,
  //                             // ),
  //                           // visibleMinimum: 1,
  //                         ),
  //
  //                           // Chart title
  //                           title: ChartTitle(text: 'Disease Prediction Analysis'),
  //                           // Enable legend
  //                           //legend: Legend(isVisible: true),
  //                           // Enable tooltip
  //                           tooltipBehavior: TooltipBehavior(enable: true),
  //
  //                         series: <LineSeries<Probability, String>>[
  //                           LineSeries<Probability, String>(
  //                               dataSource: blank,
  //                               xValueMapper: (Probability sales, _) => sales.x,
  //                               yValueMapper: (Probability sales, _) => sales.y,
  //                               //Enable data label
  //                               color: Colors.transparent,
  //
  //                               dataLabelSettings: DataLabelSettings(isVisible: false)
  //                           ),
  //                           LineSeries<Probability, String>(
  //                               dataSource: D,
  //                               xValueMapper: (Probability sales, _) => sales.x,
  //                               yValueMapper: (Probability sales, _) => sales.y,
  //                               //Enable data label
  //                               color: diabcol,
  //
  //                               dataLabelSettings: DataLabelSettings(isVisible: false)
  //                           ),
  //                           LineSeries<Probability, String>(
  //                               dataSource: H,
  //                               xValueMapper: (Probability sales, _) => sales.x,
  //                               yValueMapper: (Probability sales, _) => sales.y,
  //                               // Enable data label
  //                               color: heartcol,
  //
  //                               dataLabelSettings: DataLabelSettings(isVisible: false)
  //                           ),
  //                           LineSeries<Probability, String>(
  //                               dataSource: P,
  //                               xValueMapper: (Probability sales, _) => sales.x,
  //                               yValueMapper: (Probability sales, _) => sales.y,
  //                               // Enable data label
  //                               color:parkcol,
  //
  //                               dataLabelSettings: DataLabelSettings(isVisible: false)
  //                           )
  //                         ],
  //
  //
  //
  //
  //                   ),
  //                     )
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //       ],
  //     ),
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
                    ),
                ),
              ),

                      Builder(
                        builder: (context) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 11.0, left: 11.0, right: 11.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        child: Text('${name[0]}', style: TextStyle(fontSize: 30),),
                                        //backgroundImage: AssetImage('assets/images/channels4_profile.jpg'),
                                        backgroundColor: Colors.pink,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                          child: Text('Hi ${name}!👋', style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Stylish'),)),
                                    ],
                                  ),
    ],
          ),
    ),
    );
                        }
                      ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text('Select Disease',style: TextStyle(fontSize: 23,color: Colors.white),),
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
                    Text('Last 6 Months : ',
    style: const TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    fontFamily: 'Stylish'),),


                    SizedBox(height: 5,),

                    Container(
                      height:250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:[
                              Text('YES',style: TextStyle(color: Colors.white),),
                                Text('MAYBE',style: TextStyle(color: Colors.white),),
                                Text('NO',style: TextStyle(color: Colors.white),)
                      ]
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),

                          for(int i=0;i<6;i++)
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 5,
        ),
        Text(' '),
        Container(
        height: 140,
        width: 50,
        color: Colors.black,
        child: Column(
        children: [
        SizedBox(
        height: 5,
        ),

        CircleAvatar(
        backgroundColor:col1[i],
        radius:20,
        ),
        SizedBox(
        height: 5,
        ),

        CircleAvatar(
        radius: 20,
        backgroundColor:col2[i],
        ),
        SizedBox(
        height: 5,
        ),

        CircleAvatar(
        radius: 20,
        backgroundColor:col3[i],
        ),
        ],
        ),

        ),
        SizedBox(
          height: 5,
        ),
        Text(month[i],style: TextStyle(color: Colors.white),),
      ],
    ),


              ],
              ),
                    ),
              Text(
              'Disease Predictor Graph', style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Stylish'),),

                  ],
                ),
              ),


            ],
          ),
    );
  }

}