import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'modelweather.dart';
import 'dart:convert';
import 'api.dart';

class InfoSaran extends StatefulWidget {
  final String luaslahan;
  final String jenislahan;
  //final List cuaca;

  const InfoSaran({
    Key? key,
    required this.luaslahan,
    required this.jenislahan,
    //required this.cuaca
  }) : super(key: key);

  @override
  _InfoSaranState createState() => _InfoSaranState();
}

class _InfoSaranState extends State<InfoSaran> {
  List data = [];

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/profil.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  List hasilsaran = [];
  String marketplace = '';

  hasilSaran(String weather, int temperature, String jenislahan) {
    List saran = [];
    //Weather :  Clear, Clouds, Drizzle, Rain, Thunderstorm, Snow (curah hujan)
    //Temperature : 27 < x < 30 (normal padi), 21 < x < 28 (normal jagung)
    //jenislahan : padi, jagung
    if (jenislahan == "padi") {
      marketplace = 'https://shopee.co.id/search?keyword=pupuk%20padi';
      if (weather == "Clear") {
        saran.add("Kebutuhan air sangat kurang, segera lakukan pengairan");
        if (temperature <= 27) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 30) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman padi");
        }
      } else if (weather == "Clouds") {
        saran.add("Kebutuhan air kurang, segera lakukan pengairan");
        if (temperature <= 27) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 30) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman padi");
        }
      } else if (weather == "Drizzle") {
        saran.add("Perlu tambahan air, segera lakukan pengairan");
        if (temperature <= 27) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 30) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman padi");
        }
      } else if (weather == "Rain") {
        saran.add("Kebutuhan air tercukupi");
        if (temperature <= 27) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 30) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman padi");
        }
      } else if (weather == "Thunderstorm") {
        saran.add("Terlalu banyak air, pastikan pembuangan air lancar");
        if (temperature <= 27) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 30) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman padi");
        }
      }
    } else if (jenislahan == "jagung") {
      marketplace = 'https://shopee.co.id/search?keyword=pupuk%20jagung';
      if (weather == "Clear") {
        saran.add("Kebutuhan air sangat tercukupi");
        if (temperature <= 21) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 28) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman jagung");
        }
      } else if (weather == "Clouds") {
        saran.add("Kebutuhan air tercukupi");
        if (temperature <= 21) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 28) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman jagung");
        }
      } else if (weather == "Drizzle") {
        saran.add("Kebutuhan air tercukupi");
        if (temperature <= 21) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 28) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman jagung");
        }
      } else if (weather == "Rain") {
        saran.add("Banyak air, pastikan pembuangan air lancar");
        if (temperature <= 21) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 28) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman jagung");
        }
      } else if (weather == "Thunderstorm") {
        saran.add("Terlalu banyak air, pastikan pembuangan air lancar");
        if (temperature <= 21) {
          saran.add("Suhu terlalu rendah, lakukan pemberian obat");
        } else if (temperature > 28) {
          saran.add("Suhu terlalu tinggi, lakukan pemberian obat");
        } else {
          saran.add("Suhu normal untuk tanaman jagung");
        }
      }
    } else {}
    hasilsaran = saran;
  }

  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/backgroundhome1.png"),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            Container(
              child: Row(
                children: [
                  Image(
                    image: AssetImage("images/info.png"),
                  ),
                  SizedBox(width: 10),
                  Text("Peringatan",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFFF6E120),
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 20),
              padding: EdgeInsets.all(10),
              height: 150,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: FutureBuilder<Weather>(
                            future: futureWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                String mains = snapshot.data!.icon.toString();
                                return Image(
                                  image:
                                      AssetImage('images/weather/$mains.png'),
                                  height: 100,
                                  width: 100,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                        Container(
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
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: 150,
                      width: 150,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Data Lahan",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500))),
                            Text(widget.luaslahan + " m²",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color(0xFF4B4B4B),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))),
                            Text(widget.jenislahan,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color(0xFF4B4B4B),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)))
                          ])),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              padding: EdgeInsets.all(20),
              height: 150,
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
                  Text("Penyelesaian",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 14,
                              fontWeight: FontWeight.w500))),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: FutureBuilder<Weather>(
                            future: futureWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                String mains = snapshot.data!.main.toString();
                                int suhu = snapshot.data!.temp.round();
                                hasilSaran(mains, suhu, widget.jenislahan);
                                return Text("1. " + hasilsaran[0],
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)));
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                        Container(
                          child: FutureBuilder<Weather>(
                            future: futureWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                String mains = snapshot.data!.main.toString();
                                int suhu = snapshot.data!.temp.round();
                                hasilSaran(mains, suhu, widget.jenislahan);
                                return Text("2. " + hasilsaran[1],
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500)));
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                        // Container(
                        //   child: FutureBuilder<Weather>(
                        //     future: futureWeather,
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData) {
                        //         String mains = snapshot.data!.main.toString();
                        //         int suhu = snapshot.data!.temp.round();
                        //         hasilSaran(mains, suhu, widget.jenislahan);
                        //         return Text("3. " + hasilsaran[2],
                        //             style: GoogleFonts.poppins(
                        //                 textStyle: TextStyle(
                        //                     color: Color(0xFF000000),
                        //                     fontSize: 10,
                        //                     fontWeight: FontWeight.w500)));
                        //       } else if (snapshot.hasError) {
                        //         return Text('${snapshot.error}');
                        //       }
                        //       return const CircularProgressIndicator();
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFF6E120)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: _launchURL,
                      child: Text("Recomendation Store",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Color(0xFFF6E120),
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600)))),
                  Image.asset("images/shop.png", height: 20, width: 20)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://shopee.co.id/search?keyword=pupuk%20padi';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
