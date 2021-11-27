import 'package:apupsp/home/home.dart';
import 'package:apupsp/neraca/neraca.dart';
import 'package:apupsp/user/edituser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profil extends StatefulWidget {
  const Profil({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String luaslahan = "";
  String jenislahan = "";

  List list = [];

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(Icons.person, color: Colors.white),
              onPressed: () {}),
          title: Text("Profile",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16,
                      fontWeight: FontWeight.w500))),
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/backgroundhome1.png"),
                    fit: BoxFit.cover)),
            child: ListView(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: users.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.docs
                            .map((e) => ItemCard(
                                  e,
                                  e['nama'],
                                  e['luaslahan'],
                                  e['jenislahan'],
                                ))
                            .toList(),
                      );
                    } else {
                      return Center(child: Center(child: Text('Loading')));
                    }
                  },
                ),
              ],
            )),
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
                    textColor: Color(0xFFFAFAFA),
                    child: Icon(
                      Icons.home,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardHome()));
                    }),
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
                    textColor: Color(0xFFF8B21C),
                    child: Icon(Icons.person, size: 30),
                    onPressed: () {})
              ],
            ),
          ),
        ));
  }
}

class ItemCard extends StatelessWidget {
  final e;
  final String nama;
  final int luaslahan;
  final String jenislahan;

  ItemCard(this.e, this.nama, this.luaslahan, this.jenislahan);

  @override
  Widget build(BuildContext context) {
    TextEditingController _luaslahan = TextEditingController();
    TextEditingController _jenislahan = TextEditingController();

    var items = ["padi", "jagung"];
    _luaslahan.text = luaslahan.toString();
    _jenislahan.text = jenislahan;
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("images/avatar.png"),
                  radius: 40,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(nama,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Color(0xFFFAFAFA),
                            fontSize: 24,
                            fontWeight: FontWeight.w500)))
              ],
            ),
          ),
          Container(
            color: Color(0xFFFAFAFA),
            width: double.infinity,
            height: 250,
            margin: EdgeInsets.only(left: 50, top: 20, right: 50),
            padding: EdgeInsets.all(20),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  enabled: false,
                  controller: _luaslahan,
                  decoration: InputDecoration(
                    labelText: 'Luas Lahan (m²)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  enabled: false,
                  readOnly: true,
                  controller: _jenislahan,
                  decoration: InputDecoration(
                    hintText: "Pilih jenis lahan",
                    labelText: "Jenis Lahan",
                    suffixIcon: PopupMenuButton<String>(
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (String value) {
                        _jenislahan.text = value;
                      },
                      itemBuilder: (BuildContext context) {
                        return items.map<PopupMenuItem<String>>((String value) {
                          return new PopupMenuItem(
                              child: new Text(value), value: value);
                        }).toList();
                      },
                    ),
                  ),
                ),
                Container(
                  color: Color(0xFFFFFFFF),
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Color(0xFFF8B21C),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 3,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditUser(
                                            e: e,
                                            nama: nama,
                                            luaslahan: luaslahan,
                                            jenislahan: jenislahan)));
                              },
                              child: Text("Ubah Data Profile",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600))))),
                    ],
                  ),
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
