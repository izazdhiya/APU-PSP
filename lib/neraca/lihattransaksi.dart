import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LihatTransaksi extends StatefulWidget {
  const LihatTransaksi({
    Key? key,
  }) : super(key: key);

  @override
  _LihatTransaksiState createState() => _LihatTransaksiState();
}

class _LihatTransaksiState extends State<LihatTransaksi> {
  var items = ["7 Hari Terakhir", "30 Hari Terakhir", "Semua Transaksi"];
  int filter = 10000;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference neraca = firestore.collection('neraca');
    return Scaffold(
        appBar: AppBar(
          title: Text("Lihat Transaksi",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16,
                      fontWeight: FontWeight.w500))),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list_sharp),
                onSelected: (String value) {
                  if (value == "7 Hari Terakhir") {
                    filter = 7;
                  } else if (value == "30 Hari Terakhir") {
                    filter = 30;
                  } else {
                    filter = 10000;
                  }
                  setState(() {});
                },
                itemBuilder: (BuildContext context) {
                  return items.map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/backgroundhome1.png"),
                    fit: BoxFit.cover)),
            child: Column(children: [
              // Container(
              //   height: 40,
              //   width: double.infinity,
              //   margin:
              //       EdgeInsets.only(left: 60, top: 100, right: 60, bottom: 20),
              //   child: MaterialButton(
              //       minWidth: 40,
              //       color: Color(0xFFF8B21C),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10)),
              //       onPressed: () {},
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           Icon(
              //             Icons.filter_list_sharp,
              //             color: Color(0xFFFAFAFA),
              //           ),
              //           Container(
              //             child: Text("Semua transaksi",
              //                 style: GoogleFonts.poppins(
              //                     textStyle: TextStyle(
              //                         color: Color(0xFFFAFAFA),
              //                         fontSize: 12,
              //                         fontWeight: FontWeight.w500))),
              //           ),
              //           Icon(
              //             Icons.arrow_drop_down,
              //             color: Color(0xFFFAFAFA),
              //           ),
              //         ],
              //       )),
              // ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 100),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 450,
                  child: ListView(children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: neraca
                          .where('tanggal',
                              isGreaterThan: DateTime.now()
                                  .subtract(Duration(days: filter)))
                          .orderBy('tanggal', descending: true)
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data!.docs
                                .map((e) => ItemCard(
                                      e['tanggal'],
                                      e['keterangan'],
                                      e['tipe'],
                                      e['jumlah'],
                                      e,
                                    ))
                                .toList(),
                          );
                        } else {
                          return Center(child: Center(child: Text('Loading')));
                        }
                      },
                    )
                  ])),
              Container(
                margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pengeluaran",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600))),
                            StreamBuilder<QuerySnapshot>(
                              stream: neraca
                                  .where('tanggal',
                                      isGreaterThan: DateTime.now()
                                          .subtract(Duration(days: filter)))
                                  .snapshots(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  List myDocCount = snapshot.data!.docs
                                      .map((e) => [
                                            e['jumlah'],
                                            e['tipe'],
                                            e['tanggal']
                                          ])
                                      .toList();
                                  num jumlahtransaksi = 0;
                                  for (var i in myDocCount) {
                                    if (i[1] == "Pengeluaran") {
                                      jumlahtransaksi = jumlahtransaksi + i[0];
                                    }
                                  }
                                  return Text(
                                      NumberFormat.simpleCurrency(locale: 'id')
                                          .format(jumlahtransaksi),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFFDF2828),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)));
                                } else {
                                  return Center(
                                      child: Center(
                                          child: Text('Rp 0',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFFDF2828),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)))));
                                }
                              },
                            ),
                          ]),
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pemasukan",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color(0xFF808080),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600))),
                            StreamBuilder<QuerySnapshot>(
                              stream: neraca
                                  .where('tanggal',
                                      isGreaterThan: DateTime.now()
                                          .subtract(Duration(days: filter)))
                                  .snapshots(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  List myDocCount = snapshot.data!.docs
                                      .map((e) => [
                                            e['jumlah'],
                                            e['tipe'],
                                            e['tanggal']
                                          ])
                                      .toList();
                                  num jumlahtransaksi = 0;
                                  for (var i in myDocCount) {
                                    if (i[1] == "Pemasukan") {
                                      jumlahtransaksi = jumlahtransaksi + i[0];
                                    }
                                  }
                                  return Text(
                                      NumberFormat.simpleCurrency(locale: 'id')
                                          .format(jumlahtransaksi),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFF44B210),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)));
                                } else {
                                  return Center(
                                      child: Center(
                                          child: Text('Rp 0',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF44B210),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)))));
                                }
                              },
                            ),
                          ]),
                    ),
                  ],
                ),
              )
            ])));
  }
}

class ItemCard extends StatelessWidget {
  final tanggal;
  final String keterangan;
  final String tipe;
  final int jumlah;
  final e;

  ItemCard(
    this.tanggal,
    this.keterangan,
    this.tipe,
    this.jumlah,
    this.e,
  );

  @override
  Widget build(BuildContext context) {
    DateTime myDateTime = tanggal.toDate();
    var date = DateFormat.yMMMd().format(myDateTime);
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(top: 5, bottom: 5),
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
                child: Text(date,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Color(0xFFFAFAFA),
                            fontSize: 12,
                            fontWeight: FontWeight.w600))),
              )),
          Container(
            width: 240,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(keterangan,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                Text(NumberFormat.simpleCurrency(locale: 'id').format(jumlah),
                    style: GoogleFonts.poppins(
                        color: tipe == "Pemasukan"
                            ? Color(0xFF44B210)
                            : Color(0xFFDF2828),
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

String convertTimeStampToHumanDate(int timeStamp) {
  var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  return DateFormat('dd/MM/yyyy').format(dateToTimeStamp);
}
