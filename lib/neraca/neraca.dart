import 'package:apupsp/home/home.dart';
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
  var formatedTanggal = new DateFormat.yMMMd().format(today);
  String date = '${today.day} - ${today.month} - ${today.year}';
  String yesterday = '${today.day} - ${today.month} - ${today.year}';

  List list = [];
  List pemasukan = [];
  List pengeluaran = [];
  num totalpemasukan = 0;
  num totalpengeluaran = 0;

  void fetchData() async {
    var data = await FirebaseFirestore.instance.collection("neraca").get();
    for (int i = 0; i < data.docs.length; i++) {
      List model = [
        data.docs[i].data()['tanggal'],
        data.docs[i].data()['tipe'],
        data.docs[i].data()['jumlah'],
        data.docs[i].data()['keterangan']
      ];
      if (data.docs[i].data()['tanggal'] == '$date') {
        if (data.docs[i].data()['tipe'] == "Pemasukan") {
          pemasukan.add(data.docs[i].data()['jumlah']);
        } else {
          pengeluaran.add(data.docs[i].data()['jumlah']);
        }
      }
      list.add(model);
    }
    setState(() {});
  }

  totalPemasukan() {
    num a = 0;
    for (var i = 0; i < pemasukan.length; i++) {
      a = a + pemasukan[i];
    }
    totalpemasukan = a;
    return totalpemasukan.toString();
  }

  totalPengeluaran() {
    num a = 0;
    for (var i = 0; i < pengeluaran.length; i++) {
      a = a + pengeluaran[i];
    }
    totalpengeluaran = a;
    return totalpengeluaran.toString();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference neraca = firestore.collection('neraca');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(Icons.money_rounded, color: Colors.white),
              onPressed: () {}),
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
                  height: 250,
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
                                  Text('Rp ' + totalPengeluaran(),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFFDF2828),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)))
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
                                  Text('Rp ' + totalPemasukan(),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Color(0xFF44B210),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)))
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
                          height: 180,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: list.length == 0
                              ? Center(child: Text("Tidak Ada Data"))
                              : ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (_, index) {
                                    if (list[index][0] == '$date') {
                                      return TextButton(
                                          onPressed: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(top: 0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      list[index][3].toString(),
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFF808080),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))),
                                                  Text(
                                                      'Rp ' +
                                                          list[index][2]
                                                              .toString(),
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              color: list[index]
                                                                          [1] ==
                                                                      "Pemasukan"
                                                                  ? Color(
                                                                      0xFF44B210)
                                                                  : Color(
                                                                      0xFFDF2828),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)))
                                                ]),
                                          ));
                                    } else {
                                      return Container();
                                    }
                                  },
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
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 2; i++)
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
                                //margin: EdgeInsets.only(right: 10),
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Color(0xFF808080),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: Center(
                                  child: Text(formatedTanggal.toString(),
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
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Pengeluaran",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF808080),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                            Text("Rp 500000",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFFDF2828),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600)))
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Pemasukan",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF808080),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                            Text("Rp 500000",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xFF44B210),
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
                              builder: (context) => HomePage(
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

// class ItemTransaksi extends StatelessWidget {
//   final List listtransaksi;

//   const ItemTransaksi({Key? key, required this.listtransaksi})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: listtransaksi.length,
//         itemBuilder: (context, index) {
//           String keterangan = listtransaksi.data["keterangan"].toString();
//         });
//   }
// }

// class Neraca {
//   final String tanggal;
//   final String tipe;
//   final int jumlah;
//   final double keterangan;

//   Neraca({
//     required this.tanggal, 
//     required this.tipe, 
//     required this.jumlah, 
//     required this.keterangan})

//   Neraca.fromSnapshot(DocumentSnapshot snapshot)
//       : assert(snapshot != null),
//         tanggal = snapshot.data()['tanggal'],
//         tipe = snapshot.data()['tipe'],
//         jumlah = snapshot.data()['jumlah'],
//         keterangan = snapshot.data()['keterangan'];

//   factory Neraca.random() {
//     return Neraca(
//       tanggal: getRandomCategory(),
//       city: getRandomCity(),
//       name: getRandomName(),
//       price: Random().nextInt(3) + 1,
//       photo: getRandomPhoto(),
//     );
//   }
// }
