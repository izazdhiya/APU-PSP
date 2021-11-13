import 'package:apupsp/home/home.dart';
import 'package:apupsp/neraca/edittransaksi.dart';
import 'package:apupsp/neraca/tambahtransaksi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NeracaPage extends StatefulWidget {
  final String nama;
  final String luaslahan;
  final String jenislahan;

  const NeracaPage(
      {Key? key,
      required this.nama,
      required this.luaslahan,
      required this.jenislahan})
      : super(key: key);

  @override
  _NeracaPageState createState() => _NeracaPageState();
}

class _NeracaPageState extends State<NeracaPage> {
  static var today = new DateTime.now();
  static var yesterday = new DateTime.now().subtract(Duration(days: 1));
  String date = '${today.day} - ${today.month} - ${today.year}';
  String date1 = '${yesterday.day} - ${yesterday.month} - ${yesterday.year}';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference neraca = firestore.collection('neraca');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(Icons.money_rounded, color: Colors.white),
              onPressed: () {}),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.layers, color: Colors.white),
              onPressed: () {},
            ),
          ],
          title: Text("Laporan Neraca",
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
            child: Column(children: [
              Container(
                  width: double.infinity,
                  height: 300,
                  margin: EdgeInsets.only(left: 10, top: 80, right: 10),
                  padding: EdgeInsets.all(5),
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
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text("Hari Ini",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFF808080),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                  Text('$date',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFF808080),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)))
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text("Pengeluaran",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFF808080),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: neraca
                                        .where("tipe", isEqualTo: "Pengeluaran")
                                        .where("tanggal",
                                            isGreaterThan: DateTime.now()
                                                .subtract(Duration(days: 1)))
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List myDocCount = snapshot.data!.docs
                                            .map((e) => e['jumlah'])
                                            .toList();
                                        num jumlahtransaksi = 0;
                                        for (var i in myDocCount) {
                                          jumlahtransaksi = jumlahtransaksi + i;
                                        }
                                        return Text(
                                            NumberFormat.simpleCurrency(
                                                    locale: 'id')
                                                .format(jumlahtransaksi),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Color(0xFFDF2828),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)));
                                      } else {
                                        return Center(
                                            child: Center(
                                                child: Text('Rp 0',
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            color: Color(
                                                                0xFFDF2828),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)))));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text("Pemasukan",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFF808080),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: neraca
                                        .where('tanggal',
                                            isGreaterThan: DateTime.now()
                                                .subtract(Duration(days: 1)))
                                        .where('tipe', isEqualTo: "Pemasukan")
                                        .snapshots(),
                                    builder: (_, snapshot) {
                                      if (snapshot.hasData) {
                                        List myDocCount = snapshot.data!.docs
                                            .map((e) => e['jumlah'])
                                            .toList();
                                        num jumlahtransaksi = 0;
                                        for (var i in myDocCount) {
                                          jumlahtransaksi = jumlahtransaksi + i;
                                        }
                                        return Text(
                                            NumberFormat.simpleCurrency(
                                                    locale: 'id')
                                                .format(jumlahtransaksi),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF44B210),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)));
                                      } else {
                                        return Center(
                                            child: Center(
                                                child: Text('Rp 0',
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            color: Color(
                                                                0xFF44B210),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)))));
                                      }
                                    },
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
                        color: Colors.black,
                      ),
                      Container(
                          width: double.infinity,
                          height: 220,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: ListView(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: neraca
                                    .where('tanggal',
                                        isGreaterThan: DateTime.now()
                                            .subtract(Duration(days: 1)))
                                    .orderBy('tanggal', descending: true)
                                    .snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: snapshot.data!.docs
                                          .map((e) => ItemCard(
                                              e['keterangan'],
                                              e['tipe'],
                                              e['jumlah'],
                                              e,
                                              widget.nama,
                                              widget.luaslahan,
                                              widget.jenislahan))
                                          .toList(),
                                    );
                                  } else {
                                    return Center(
                                        child: Center(child: Text('Loading')));
                                  }
                                },
                              )
                            ],
                          ))
                    ],
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    MaterialButton(
                        minWidth: 40,
                        color: Color(0xFFF8B21C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TambahTransaksi(
                                      nama: widget.nama,
                                      luaslahan: widget.luaslahan,
                                      jenislahan: widget.jenislahan)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.add_circle,
                              color: Color(0xFFFAFAFA),
                            ),
                            Text("Tambah Transaksi",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color(0xFFFAFAFA),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))),
                          ],
                        ))
                  ])),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 2,
                            blurRadius: 2,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Color(0xFF808080),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: Center(
                                child: Text('$date1',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Color(0xFFFAFAFA),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600))),
                              )),
                          Container(
                              width: 250,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Pengeluaran",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF808080),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500))),
                                          Text("Rp ",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFFDF2828),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600)))
                                        ],
                                      )),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Pemasukan",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF808080),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500))),
                                          Text("Rp ",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF44B210),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600)))
                                        ],
                                      ))
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ])),
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
                              builder: (context) => DashboardHome(
                                  nama: widget.nama,
                                  luaslahan: widget.luaslahan,
                                  jenislahan: widget.jenislahan)));
                    }),
                MaterialButton(
                    height: 50,
                    minWidth: 50,
                    textColor: Color(0xFFF8B21C),
                    child: Icon(
                      Icons.money_rounded,
                      size: 30,
                    ),
                    onPressed: () {}),
                MaterialButton(
                    height: 50,
                    minWidth: 50,
                    textColor: Color(0xFFFAFAFA),
                    child: Icon(Icons.person, size: 30),
                    onPressed: () {})
              ],
            ),
          ),
        ));
  }
}

class ItemCard extends StatelessWidget {
  final String keterangan;
  final String tipe;
  final int jumlah;
  final e;
  final String nama;
  final String luaslahan;
  final String jenislahan;

  ItemCard(this.keterangan, this.tipe, this.jumlah, this.e, this.nama,
      this.luaslahan, this.jenislahan);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference neraca = firestore.collection('neraca');
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(keterangan,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                    NumberFormat.simpleCurrency(locale: 'id').format(jumlah),
                    style: GoogleFonts.poppins(
                        color: tipe == "Pemasukan"
                            ? Color(0xFF44B210)
                            : Color(0xFFDF2828),
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: MaterialButton(
                    shape: CircleBorder(),
                    color: Colors.yellow[600],
                    child: Center(
                        child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditTransaksi(
                                  keterangan: keterangan,
                                  jumlah: jumlah,
                                  tipe: tipe,
                                  e: e,
                                  nama: nama,
                                  luaslahan: luaslahan,
                                  jenislahan: jenislahan)));
                    }),
              ),
              SizedBox(
                height: 40,
                width: 60,
                child: MaterialButton(
                    shape: CircleBorder(),
                    color: Colors.red[900],
                    child: Center(
                        child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      AlertDialog alert = AlertDialog(
                        title: Text("Konfirmasi"),
                        content: Text("Apakah Anda ingn menghapus transaksi?"),
                        actions: [
                          MaterialButton(
                            color: Color(0xFFC4C4C4),
                            child: Text("Batal",
                                style: TextStyle(
                                  color: Color(0xFFF8B21C),
                                )),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          MaterialButton(
                            color: Color(0xFFF8B21C),
                            child: Text("Hapus",
                                style: TextStyle(
                                  color: Color(0xFFFAFAFA),
                                )),
                            onPressed: () {
                              neraca.doc(e.id).delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Data berhasil dihapus!')),
                              );
                              Navigator.of(context).pop();
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
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
