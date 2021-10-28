//import 'package:apupsp/splashscreen.dart';
import 'package:apupsp/home/dailyforecast/dailyforecast1.dart';
import 'package:apupsp/home/dailyforecast/dailyforecast2.dart';
import 'package:apupsp/home/dailyforecast/dailyforecast4.dart';
import 'package:apupsp/home/dailyforecast/dailyforecast5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../modelweather.dart';
import '../api.dart';

class DailyForecast3 extends StatefulWidget {
  //const DailyForecast({ Key? key }) : super(key: key);

  @override
  _DailyForecast3State createState() => _DailyForecast3State();
}

class _DailyForecast3State extends State<DailyForecast3> {
  late Future<Daily> futureDaily;

  @override
  void initState() {
    super.initState();
    futureDaily = fetchDaily();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ramalan 5 Hari",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Color(0xFFFAFAFA),
                    fontSize: 16,
                    fontWeight: FontWeight.w500))),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
          padding: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/backgroundhome1.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(left: 5, top: 20, right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFFAFAFA)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 5,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DailyForecast1()));
                                },
                                child: FutureBuilder<Daily>(
                                  future: futureDaily,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int date = snapshot.data!.date0;
                                      return Text(
                                        convertTimeStampToHumanDate(date),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color(0xFFFAFAFA),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                )))),
                    Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(left: 5, top: 20, right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFFAFAFA)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 5,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DailyForecast2()));
                                },
                                child: FutureBuilder<Daily>(
                                  future: futureDaily,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int date = snapshot.data!.date1;
                                      return Text(
                                        convertTimeStampToHumanDate(date),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color(0xFFFAFAFA),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                )))),
                    Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(left: 5, top: 20, right: 5),
                        decoration: BoxDecoration(
                          color: Color(0xFFFAFAFA),
                          border: Border.all(color: Color(0xFFFAFAFA)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 5,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Center(
                            child: TextButton(
                                onPressed: () {},
                                child: FutureBuilder<Daily>(
                                  future: futureDaily,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int date = snapshot.data!.date2;
                                      return Text(
                                        convertTimeStampToHumanDate(date),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color(0xFF07689F),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                )))),
                    Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(left: 5, top: 20, right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFFAFAFA)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 5,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DailyForecast4()));
                                },
                                child: FutureBuilder<Daily>(
                                  future: futureDaily,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int date = snapshot.data!.date3;
                                      return Text(
                                        convertTimeStampToHumanDate(date),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color(0xFFFAFAFA),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                )))),
                    Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(left: 5, top: 20, right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFFAFAFA)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 5,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DailyForecast5()));
                                },
                                child: FutureBuilder<Daily>(
                                  future: futureDaily,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int date = snapshot.data!.date4;
                                      return Text(
                                        convertTimeStampToHumanDate(date),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color(0xFFFAFAFA),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                )))),
                  ])),
              Container(
                height: 420,
                width: double.infinity,
                margin: EdgeInsets.only(left: 10, top: 20, right: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text("Pagi",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFF808080),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500))),
                                ),
                                Container(
                                    child: FutureBuilder<Daily>(
                                  future: futureDaily,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String mains =
                                          snapshot.data!.icon2.toString();
                                      return Image(
                                        image: AssetImage(
                                            'images/weather/$mains.png'),
                                        height: 80,
                                        width: 80,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FutureBuilder<Daily>(
                                    future: futureDaily,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.morn2
                                                  .round()
                                                  .toString() +
                                              ' °C',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Color(0xFF808080),
                                                  fontSize: 36,
                                                  fontWeight: FontWeight.w600)),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                Container(
                                  child: FutureBuilder<Daily>(
                                    future: futureDaily,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.description2
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Color(0xFF808080),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: 300,
                      height: 1,
                      color: Color(0xFF808080),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text("Siang",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFF808080),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500))),
                                ),
                                Container(
                                    child: FutureBuilder<Daily>(
                                  future: futureDaily,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String mains =
                                          snapshot.data!.icon2.toString();
                                      return Image(
                                        image: AssetImage(
                                            'images/weather/$mains.png'),
                                        height: 80,
                                        width: 80,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FutureBuilder<Daily>(
                                    future: futureDaily,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.day2
                                                  .round()
                                                  .toString() +
                                              ' °C',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Color(0xFF808080),
                                                  fontSize: 36,
                                                  fontWeight: FontWeight.w600)),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                Container(
                                  child: FutureBuilder<Daily>(
                                    future: futureDaily,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.description2
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Color(0xFF808080),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: 300,
                      height: 1,
                      color: Color(0xFF808080),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text("Malam",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFF808080),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500))),
                                ),
                                Container(
                                    child: FutureBuilder<Daily>(
                                  future: futureDaily,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String mains =
                                          snapshot.data!.icon2.toString();
                                      return Image(
                                        image: AssetImage(
                                            'images/weather/$mains.png'),
                                        height: 80,
                                        width: 80,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FutureBuilder<Daily>(
                                    future: futureDaily,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.eve2
                                                  .round()
                                                  .toString() +
                                              ' °C',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Color(0xFF808080),
                                                  fontSize: 36,
                                                  fontWeight: FontWeight.w600)),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                Container(
                                  child: FutureBuilder<Daily>(
                                    future: futureDaily,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.description2
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Color(0xFF808080),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

String convertTimeStampToHumanDate(int timeStamp) {
  var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  return DateFormat('dd/MM').format(dateToTimeStamp);
}
