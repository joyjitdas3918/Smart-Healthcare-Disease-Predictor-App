import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_overpass/flutter_overpass.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:smart_healthcare/DiseasePredictorPage.dart';
import 'package:smart_healthcare/LoginPage.dart';
import 'package:smart_healthcare/SettingsPage.dart';
import 'package:smart_healthcare/SlashPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_healthcare/SplashScreen.dart';
import 'dart:convert';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
class NearbyLabs extends StatefulWidget {  @override
  State<NearbyLabs> createState() => _NearbyLabsState();
}

class _NearbyLabsState extends State<NearbyLabs> {

  var name = 'User';
  final _platformversion=FlutterOverpass().getPlatformVersion();

  final flutterOverpass = FlutterOverpass();
  Position? userPosition;

  var long;
  var lat;



// // Fetch nearby nodes by coordinates and radius given.
//   final nearbyPlaces = await flutterOverpass.getNearbyNodes(
//   latitude: -122.3838801383972,
//   longitude: 37.79396544487583,
//   radius: 200,
//   );
//
// // Fetch data by executing Overpass QL.
  var add;
  static CustomAlertBox(BuildContext context, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text,style: TextStyle(color: Colors.red),),
      );
    });
  }

  var dist=TextEditingController();
  var names=[];
  var address=[];
  @override
  Widget build(BuildContext context) {
    var res;
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
          'Nearby Labs', style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Text(userPosition.toString()),
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
          Container(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                children: [
                  ElevatedButton(onPressed:() async {
                    int f=0;
                    String num=dist.text.toString();
                    double val=0;
                    try {
                      val = double.parse(num);
                    }on FormatException{
                      f=1;
                      CustomAlertBox(context, 'Invalid input');
                    }
                    if(f==0) {
                      add = await FlutterOverpass().rawOverpassQL(query:
                      '''
node(around:${val*1000},$lat,$long)[amenity=hospital];
out;

                    ''');
                      names.clear();
                      address.clear();
                      for (var element in add['elements']) {
                        if(element['tags']['name'] != null) {
                          names.add(element['tags']['name']);
                          if (element['tags']['addr:full'] != null)
                            address.add(element['tags']['addr:full']);
                          else
                            address.add(' ');
                        }
                        // print('Address: ${element['tags']['addr:full']}');
                        // print('---');
                      }
                      if(names.length==0){
                        names.add('No labs available in this distance');
                        address.add('Try increasing the distance');

                      }
                    }


                    setState(() {

                    });
                  }, child: Text('Apply filters')),
    SizedBox(
      height: 10,
    ),
    TextField(
    controller: dist,
    keyboardType: TextInputType.number,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
    labelText: 'Enter maximum distance (in km)',
    labelStyle: TextStyle(color: Colors.white),
    hintText: 'Enter maximum distance (in km)',
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
    prefixIcon: Icon(Icons.social_distance, color: Colors.white,),
    ),
    ),


    SizedBox(
      height: 30,
    ),
    Container(
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      width: double.infinity,
      child:
      ListView.builder(
      itemCount: (address.length/2).toInt(),
      itemBuilder: (BuildContext context, int index) {
      return ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2,color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      title: Text(names[index], style: TextStyle(color: Colors.white),),
      // You can add more content or customize the ListTile as needed
      subtitle: Text(address[index],style: TextStyle(color: Colors.grey),),

        // leading: Icon(Icons.account_circle),
      // onTap: () => _handleTap(index),
      );

      },
      ),
    ),
    ],
              ),
            ),
          ),

        ],
      ),

    );
  }
  Future<bool> isGpsPermissionGranted() async{
    return [
      LocationPermission.always,
      LocationPermission.whileInUse
      ].contains(await Geolocator.checkPermission(),);

  }
  void startStream() async{
    if(!await isGpsPermissionGranted()){
      await Geolocator.requestPermission();
    }
    if(await isGpsPermissionGranted()){
      Geolocator.getPositionStream().listen((position){
        setState(() {
          userPosition=position;
          //print(position);

          long=userPosition?.longitude.toString();
          lat=userPosition?.latitude.toString();
          //print(long);
          //print(lat);
        });
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startStream();
  }

}
