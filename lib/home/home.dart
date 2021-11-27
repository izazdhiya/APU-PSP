import 'package:apupsp/home/dailyforecast/dailyforecast1.dart';
import 'package:apupsp/home/informasi.dart';
import 'package:apupsp/neraca/neraca.dart';
import 'package:apupsp/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'modelweather.dart';
import 'api.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  List list = [];

  static var today = new DateTime.now();

  var formatedTanggal = new DateFormat.yMMMd().format(today);

  late Future<Weather> futureWeather;
  late Future<Daily> futureDaily;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
    futureDaily = fetchDaily();
  }

  Future<bool> getBool(datalahan) async {
    var jenisLahan = datalahan;
    var weather = await futureWeather;
    if (jenisLahan == "padi") {
      if (weather.main.toString() == "Thunderstorm" ||
          weather.main.toString() == "Clear" ||
          weather.main.toString() == "Cloud" ||
          weather.main.toString() == "Drizzle") {
        return true;
      } else {
        return false;
      }
    } else {
      if (weather.main.toString() == "Rain" ||
          weather.main.toString() == "Thunderstorm") {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/backgroundhome1.png"),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: users.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                list.add(snapshot.data!.docs
                                    .map((e) => [
                                          e['nama'],
                                          e['luaslahan'],
                                          e['jenislahan']
                                        ])
                                    .toList());
                                return Text(
                                  'Halo ' + list[0][0][0] + '!',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFFFAFAFA),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                );
                              } else {
                                return Text('User',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFFFAFAFA),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)));
                              }
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: users.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List myDocCount = snapshot.data!.docs
                                    .map((e) => [
                                          e['nama'],
                                          e['luaslahan'],
                                          e['jenislahan']
                                        ])
                                    .toList();
                                var datalahan = [];
                                for (var i in myDocCount) {
                                  datalahan.add(i);
                                }
                                return FutureBuilder<bool?>(
                                    future: getBool(datalahan[0][2]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container();
                                      }
                                      return Visibility(
                                          visible: snapshot.data!,
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      "images/info.png"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    InfoSaran(
                                                                      luaslahan:
                                                                          list[0][0]
                                                                              [
                                                                              1],
                                                                      jenislahan:
                                                                          list[0][0]
                                                                              [
                                                                              2],
                                                                    )));
                                                  },
                                                  child: Text("Peringatan",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFFF6E120),
                                                              fontSize: 14,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))),
                                                )
                                              ],
                                            ),
                                          ));
                                    });
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage("images/avatar.png"),
                      radius: 30,
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 30, right: 20),
                padding: EdgeInsets.all(10),
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: FutureBuilder<Weather>(
                        future: futureWeather,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String mains = snapshot.data!.icon.toString();
                            return Image(
                              image: AssetImage('images/weather/$mains.png'),
                              height: 130,
                              width: 130,
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        Center(
                          child: FutureBuilder<Weather>(
                            future: futureWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int suhu = snapshot.data!.temp.round();
                                //cuaca.add(suhu);
                                return Text(
                                  suhu.toString() + ' °C',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600)),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                        Center(
                          child: FutureBuilder<Weather>(
                            future: futureWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!.description.toString(),
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                        Text(formatedTanggal.toString(),
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))),
                        Text("Tegal",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))),
                      ],
                    ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 30, right: 20),
                padding: EdgeInsets.only(left: 5, top: 10, right: 5),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 50,
                                      child: Center(
                                        child: Text("Hari ini",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w300,
                                            ))),
                                      ),
                                    ),
                                    Container(
                                        height: 30,
                                        width: 50,
                                        child: Center(
                                            child: FutureBuilder<Daily>(
                                          future: futureDaily,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!.tempmax0
                                                        .round()
                                                        .toString() +
                                                    '/' +
                                                    snapshot.data!.tempmin0
                                                        .round()
                                                        .toString() +
                                                    ' °C',
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text('${snapshot.error}');
                                            }
                                            return const CircularProgressIndicator();
                                          },
                                        )))
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 80,
                                        child: Center(
                                            child: FutureBuilder<Daily>(
                                          future: futureDaily,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!.description0
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF000000),
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.w300)),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text('${snapshot.error}');
                                            }
                                            return const CircularProgressIndicator();
                                          },
                                        ))),
                                    Container(
                                        height: 30,
                                        width: 80,
                                        child: Center(
                                            child: FutureBuilder<Daily>(
                                          future: futureDaily,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              String mains = snapshot
                                                  .data!.icon0
                                                  .toString();
                                              return Image(
                                                image: AssetImage(
                                                    'images/weather/$mains.png'),
                                                height: 40,
                                                width: 40,
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text('${snapshot.error}');
                                            }
                                            return const CircularProgressIndicator();
                                          },
                                        )))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Transform.rotate(
                          angle: 1.57,
                          child: Container(
                            color: Colors.black,
                            width: 40.84,
                            height: 1,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 50,
                                      child: Center(
                                        child: Text("Besok",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w300,
                                            ))),
                                      ),
                                    ),
                                    Container(
                                        height: 30,
                                        width: 50,
                                        child: Center(
                                          child: FutureBuilder<Daily>(
                                            future: futureDaily,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data!.tempmax1
                                                          .round()
                                                          .toString() +
                                                      '/' +
                                                      snapshot.data!.tempmin1
                                                          .round()
                                                          .toString() +
                                                      ' °C',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    '${snapshot.error}');
                                              }
                                              return const CircularProgressIndicator();
                                            },
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 80,
                                      child: Center(
                                          child: FutureBuilder<Daily>(
                                        future: futureDaily,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data!.description1
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text('${snapshot.error}');
                                          }
                                          return const CircularProgressIndicator();
                                        },
                                      )),
                                    ),
                                    Container(
                                        height: 30,
                                        width: 80,
                                        child: Center(
                                            child: FutureBuilder<Daily>(
                                          future: futureDaily,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              String mains = snapshot
                                                  .data!.icon1
                                                  .toString();
                                              return Image(
                                                image: AssetImage(
                                                    'images/weather/$mains.png'),
                                                height: 40,
                                                width: 40,
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text('${snapshot.error}');
                                            }
                                            return const CircularProgressIndicator();
                                          },
                                        ))),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      width: 300,
                      height: 1,
                      color: Colors.black,
                    ),
                    Container(
                      height: 30,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ramalan Harian",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DailyForecast1()));
                              },
                              child: Text("5 hari >",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400)))),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 50,
                            child: Center(
                              child: Text("Hari ini",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500))),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 50,
                            child: Center(
                                child: FutureBuilder<Daily>(
                              future: futureDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  int date = snapshot.data!.date0;
                                  return Text(
                                    convertTimeStampToHumanDate(date),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            )),
                          ),
                          Container(
                              height: 20,
                              width: 50,
                              child: Center(
                                  child: FutureBuilder<Daily>(
                                future: futureDaily,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String mains =
                                        snapshot.data!.icon0.toString();
                                    return Image(
                                      image: AssetImage(
                                          'images/weather/$mains.png'),
                                      height: 30,
                                      width: 30,
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ))),
                          Container(
                            height: 20,
                            width: 100,
                            child: Center(
                                child: FutureBuilder<Daily>(
                              future: futureDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!.description0.toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            )),
                          ),
                          Container(
                            height: 20,
                            width: 60,
                            child: Center(
                              child: FutureBuilder<Daily>(
                                future: futureDaily,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.tempmax0
                                              .round()
                                              .toString() +
                                          '/' +
                                          snapshot.data!.tempmin0
                                              .round()
                                              .toString() +
                                          ' °C',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      )),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 50,
                            child: Center(
                              child: Text("Besok",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500))),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 50,
                            child: Center(
                                child: FutureBuilder<Daily>(
                              future: futureDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  int date = snapshot.data!.date1;
                                  return Text(
                                    convertTimeStampToHumanDate(date),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            )),
                          ),
                          Container(
                              height: 20,
                              width: 50,
                              child: Center(
                                  child: FutureBuilder<Daily>(
                                future: futureDaily,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String mains =
                                        snapshot.data!.icon1.toString();
                                    return Image(
                                      image: AssetImage(
                                          'images/weather/$mains.png'),
                                      height: 30,
                                      width: 30,
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ))),
                          Container(
                            height: 20,
                            width: 100,
                            child: Center(
                                child: FutureBuilder<Daily>(
                              future: futureDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!.description1.toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            )),
                          ),
                          Container(
                            height: 20,
                            width: 60,
                            child: Center(
                              child: FutureBuilder<Daily>(
                                future: futureDaily,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.tempmax1
                                              .round()
                                              .toString() +
                                          '/' +
                                          snapshot.data!.tempmin1
                                              .round()
                                              .toString() +
                                          ' °C',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      )),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 50,
                            child: Center(
                              child: Text("Lusa",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500))),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 50,
                            child: Center(
                                child: FutureBuilder<Daily>(
                              future: futureDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  int date = snapshot.data!.date2;
                                  return Text(
                                    convertTimeStampToHumanDate(date),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            )),
                          ),
                          Container(
                              height: 20,
                              width: 50,
                              child: Center(
                                  child: FutureBuilder<Daily>(
                                future: futureDaily,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String mains =
                                        snapshot.data!.icon2.toString();
                                    return Image(
                                      image: AssetImage(
                                          'images/weather/$mains.png'),
                                      height: 30,
                                      width: 30,
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ))),
                          Container(
                            height: 20,
                            width: 100,
                            child: Center(
                                child: FutureBuilder<Daily>(
                              future: futureDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!.description2.toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            )),
                          ),
                          Container(
                            height: 20,
                            width: 60,
                            child: Center(
                              child: FutureBuilder<Daily>(
                                future: futureDaily,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data!.tempmax2
                                              .round()
                                              .toString() +
                                          '/' +
                                          snapshot.data!.tempmin2
                                              .round()
                                              .toString() +
                                          ' °C',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      )),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0.0,
          child: Container(
            color: Colors.transparent,
            height: 100,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                    height: 50,
                    minWidth: 50,
                    textColor: Color(0xFFF8B21C),
                    child: Icon(
                      Icons.home,
                      size: 30,
                    ),
                    onPressed: () {}),
                MaterialButton(
                    height: 50,
                    minWidth: 50,
                    textColor: Color(0xFFFAFAFA),
                    child: Icon(
                      Icons.money_rounded,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LaporanNeraca()));
                    }),
                MaterialButton(
                    height: 50,
                    minWidth: 50,
                    textColor: Color(0xFFFAFAFA),
                    child: Icon(Icons.person, size: 30),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profil()));
                    })
              ],
            ),
          ),
        ));
  }
}

DateTime convertTimeStampToDateTime(int timeStamp) {
  var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  return dateToTimeStamp;
}

String convertTimeStampToHumanDate(int timeStamp) {
  var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  return DateFormat('dd/MM').format(dateToTimeStamp);
}

String convertTimeStampToHumanHour(int timeStamp) {
  var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  return DateFormat('HH:mm').format(dateToTimeStamp);
}
