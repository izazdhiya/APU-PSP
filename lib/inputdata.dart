import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apupsp/home/home.dart';

class FormDataLahan extends StatefulWidget {
  const FormDataLahan({Key? key}) : super(key: key);

  @override
  _FormDataLahanState createState() => _FormDataLahanState();
}

class _FormDataLahanState extends State<FormDataLahan> {
  String nama = "";
  String luaslahan = "";
  String jenislahan = "";

  TextEditingController _nama = TextEditingController();
  TextEditingController _luaslahan = TextEditingController();
  TextEditingController _jenislahan = TextEditingController();

  var items = ["padi", "jagung"];

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 60),
                    child: Text('LAHAN',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Color(0xFF3391B7),
                                fontSize: 30,
                                fontWeight: FontWeight.w800))),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 30, top: 20, right: 30),
                      child: Form(
                          child: Column(
                        children: [
                          TextFormField(
                            controller: _nama,
                            decoration: InputDecoration(
                              labelText: 'Nama Petani',
                            ),
                          ),
                          TextFormField(
                            controller: _luaslahan,
                            decoration: InputDecoration(
                              labelText: 'Luas Lahan (m²)',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
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
                                  return items.map<PopupMenuItem<String>>(
                                      (String value) {
                                    return new PopupMenuItem(
                                        child: new Text(value), value: value);
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                          Container(
                            color: Color(0xFFFFFFFF),
                            padding: EdgeInsets.only(top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    height: 35,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF3391B7),
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
                                          if (_nama.text == "" ||
                                              _luaslahan.text == "" ||
                                              _jenislahan.text == "") {
                                            AlertDialog alert = AlertDialog(
                                              content: Text("Harap isi Data!"),
                                              actions: [
                                                MaterialButton(
                                                    child: Text("OK"),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop()),
                                              ],
                                            );
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          } else {
                                            AlertDialog alert = AlertDialog(
                                              title: Text("Konfirmasi"),
                                              content: Text(
                                                  "Apakah Anda ingin menyimpan data lahan?"),
                                              actions: [
                                                MaterialButton(
                                                    child: Text(
                                                      "Batal",
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop()),
                                                MaterialButton(
                                                  child: Text("Simpan",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF3391B7),
                                                      )),
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DashboardHome(
                                                                  nama: "izaz",
                                                                  luaslahan:
                                                                      "1000",
                                                                  jenislahan:
                                                                      "padi",
                                                                )));
                                                    users.add({
                                                      'nama': _nama.text,
                                                      'luaslahan': int.tryParse(
                                                              _luaslahan
                                                                  .text) ??
                                                          0,
                                                      'jenislahan':
                                                          _jenislahan.text,
                                                    });
                                                    _nama.text = '';
                                                    _luaslahan.text = '';
                                                    _jenislahan.text = '';
                                                  },
                                                )
                                              ],
                                            );
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          }
                                        },
                                        child: Text("Simpan",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Color(0xFFFFFFFF),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600))))),
                              ],
                            ),
                          )
                        ],
                      ))),
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("images/backgroundinput.png"),
                        fit: BoxFit.cover,
                      )))
                ],
              ),
            ),
          ],
        ));
  }
}

class Jenis {
  String nama;
  Jenis(this.nama);
}
