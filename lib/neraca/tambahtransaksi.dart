//import 'package:dropdownfield/dropdownfield.dart';
import 'package:apupsp/neraca/neraca.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TambahTransaksi extends StatefulWidget {
  final String nama;
  final String luaslahan;
  final String jenislahan;

  const TambahTransaksi(
      {Key? key,
      required this.nama,
      required this.luaslahan,
      required this.jenislahan})
      : super(key: key);

  @override
  _TambahTransaksiState createState() => _TambahTransaksiState();
}

class _TambahTransaksiState extends State<TambahTransaksi> {
  String tipe = "";
  String jumlah = "";
  String keterangan = "";

  TextEditingController _tipe = TextEditingController();
  TextEditingController _jumlah = TextEditingController();
  TextEditingController _keterangan = TextEditingController();

  static var today = new DateTime.now();
  String date = '${today.day} - ${today.month} - ${today.year}';

  @override
  void initState() {
    super.initState();
    //  _myActivity = '';
  }

  var items = ["Pemasukan", "Pengeluaran"];

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference neraca = firestore.collection('neraca');
    return Scaffold(
        appBar: AppBar(
          title: Text("Tambah Transaksi",
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
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/backgroundhome1.png"),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                margin: EdgeInsets.only(left: 70, top: 20, right: 70),
                child: MaterialButton(
                    minWidth: 40,
                    color: Color(0xFFF8B21C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Color(0xFFFAFAFA),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Tanggal Transaksi",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFFFAFAFA),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500))),
                              Text("$date",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFFFAFAFA),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500))),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: TextFormField(
                              readOnly: true,
                              controller: _tipe,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Pilih tipe",
                                labelText: "Tipe",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                suffixIcon: PopupMenuButton<String>(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onSelected: (String value) {
                                    _tipe.text = value;
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
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            controller: _jumlah,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Rp",
                              labelText: "Jumlah",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            controller: _keterangan,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Masukan keterangan",
                              labelText: "Keterangan",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                  minWidth: 40,
                                  color: Color(0xFFF8B21C),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    if (_tipe.text == "" ||
                                        _jumlah.text == "" ||
                                        _keterangan.text == "") {
                                      AlertDialog alert = AlertDialog(
                                        content: Text("Harap isi Data!"),
                                        actions: [
                                          MaterialButton(
                                              child: Text("OK"),
                                              onPressed: () =>
                                                  Navigator.of(context).pop()),
                                        ],
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    } else {
                                      neraca.add({
                                        'tanggal': DateTime.now(),
                                        'tipe': _tipe.text,
                                        'jumlah':
                                            int.tryParse(_jumlah.text) ?? 0,
                                        'keterangan': _keterangan.text,
                                      });

                                      _tipe.text = '';
                                      _jumlah.text = '';
                                      _keterangan.text = '';

                                      AlertDialog alert = AlertDialog(
                                        content: Text("Data Berhasil Disimpan"),
                                        actions: [
                                          MaterialButton(
                                              child: Text(
                                                "OK",
                                              ),
                                              onPressed: () => Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NeracaPage(
                                                              nama: widget.nama,
                                                              luaslahan: widget
                                                                  .luaslahan,
                                                              jenislahan: widget
                                                                  .jenislahan))))
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
                                  child: Center(
                                    child: Text("Simpan",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color(0xFFFAFAFA),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500))),
                                  )),
                              MaterialButton(
                                  minWidth: 40,
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NeracaPage(
                                                nama: widget.nama,
                                                luaslahan: widget.luaslahan,
                                                jenislahan:
                                                    widget.jenislahan)));
                                  },
                                  child: Center(
                                    child: Text("Batal",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Color(0xFFFAFAFA),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500))),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}

String selectTipe = "";

final tipeSelected = TextEditingController();
