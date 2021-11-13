import 'dart:ui';
import 'package:apupsp/home/home.dart';
import 'package:apupsp/inputdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:apupsp/dailyforecast.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:apupsp/inputdata.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var data = await FirebaseFirestore.instance.collection("users").get();
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        if (data.docs.length == 0) {
          return FormDataLahan();
        } else {
          return DashboardHome(
              nama: "izaz", luaslahan: "1000", jenislahan: "padi");
        }
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 91, top: 100, right: 91),
                  child: Image.asset("images/logo wheather 1.png",
                      width: 193, height: 239),
                ),
                Container(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                )),

                //),
                Container(
                  padding: EdgeInsets.only(top: 170),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('©Copyright',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color(0xFF07689F),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500))),
                      Text('Kelompok F2 - All Rights Reserved',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color(0xFF07689F),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500)))
                    ],
                  ),
                ),
              ]),
        ));
  }
}
