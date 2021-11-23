import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LaporanAkhir extends StatefulWidget {
  const LaporanAkhir({
    Key? key,
  }) : super(key: key);

  @override
  _LaporanAkhirState createState() => _LaporanAkhirState();
}

class _LaporanAkhirState extends State<LaporanAkhir> {
  // String _date = "dd-mm-yyyy";
  var date1 = DateFormat.yMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference neraca = firestore.collection('neraca');
    return Scaffold(
        appBar: AppBar(
          title: Text("Laporan Akhir",
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
              //             child: Text("Semua laporan",
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
                  child: Column(children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      left: 60, top: 100, right: 60, bottom: 20),
                  child: MaterialButton(
                      minWidth: 40,
                      color: Color(0xFFF8B21C),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true,
                            minTime: DateTime(2000, 1, 1),
                            maxTime: DateTime(2030, 12, 31), onConfirm: (date) {
                          print('confirm $date');
                          date1 = DateFormat.yMMMd().format(date);
                          setState(() {});
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xFFFAFAFA),
                          ),
                          Container(
                            child: Text(date1,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color(0xFFFAFAFA),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      )),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream:
                      neraca.orderBy('tanggal', descending: true).snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      List myDocCount = snapshot.data!.docs
                          .map((e) => [e['jumlah'], e['tipe'], e['tanggal']])
                          .toList();
                      num jumlahpengeluaran = 0;
                      num jumlahpemasukan = 0;
                      for (var i in myDocCount) {
                        if (DateFormat.yMMMd().format(i[2].toDate()) == date1) {
                          if (i[1] == "Pengeluaran") {
                            jumlahpengeluaran = jumlahpengeluaran + i[0];
                          } else {
                            jumlahpemasukan = jumlahpemasukan + i[0];
                          }
                        }
                      }
                      num selisih = jumlahpemasukan - jumlahpengeluaran;
                      return Container(
                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        padding: EdgeInsets.only(left: 20, top: 10, right: 20),
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
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text("Total",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Color(0xFF808080),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600))),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Pengeluaran",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF808080),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                        Text(
                                            NumberFormat.simpleCurrency(
                                                    locale: 'id')
                                                .format(jumlahpengeluaran),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Color(0xFFDF2828),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Pemasukan",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF808080),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                        Text(
                                            NumberFormat.simpleCurrency(
                                                    locale: 'id')
                                                .format(jumlahpemasukan),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF44B210),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10, bottom: 5),
                                    width: 300,
                                    height: 1,
                                    color: Color(0xFF808080),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Selisih",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Color(0xFF808080),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                        Text(
                                            NumberFormat.simpleCurrency(
                                                    locale: 'id')
                                                .format(selisih),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: selisih >= 0
                                                        ? Color(0xFF44B210)
                                                        : Color(0xFFDF2828),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(child: Center(child: Text('Loading')));
                    }
                  },
                ),
              ])),
            ])));
  }
}
