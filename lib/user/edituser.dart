import 'package:apupsp/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUser extends StatefulWidget {
  final e;
  final String nama;
  final int luaslahan;
  final String jenislahan;

  const EditUser(
      {Key? key,
      required this.e,
      required this.nama,
      required this.luaslahan,
      required this.jenislahan})
      : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController _nama = TextEditingController();
  TextEditingController _luaslahan = TextEditingController();
  TextEditingController _jenislahan = TextEditingController();

  var items = ["padi", "jagung"];

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    _nama.text = widget.nama;
    _luaslahan.text = widget.luaslahan.toString();
    _jenislahan.text = widget.jenislahan;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",
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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/backgroundhome1.png"),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              Container(
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
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xFFFAFAFA),
                      width: double.infinity,
                      height: 300,
                      margin: EdgeInsets.only(left: 50, top: 20, right: 50),
                      padding: EdgeInsets.all(20),
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
                                            users.doc(widget.e.id).update({
                                              'nama': _nama.text,
                                              'luaslahan': int.tryParse(
                                                      _luaslahan.text) ??
                                                  0,
                                              'jenislahan': _jenislahan.text,
                                            });

                                            AlertDialog alert = AlertDialog(
                                              content: Text(
                                                  "Data Berhasil Disimpan"),
                                              actions: [
                                                MaterialButton(
                                                    child: Text(
                                                      "OK",
                                                    ),
                                                    onPressed: () => Navigator
                                                        .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Profil())))
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
                      )),
                    )
                  ],
                ),
              )
            ],
          )),
      extendBody: true,
    );
  }
}
