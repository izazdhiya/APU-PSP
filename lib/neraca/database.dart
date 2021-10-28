import 'package:cloud_firestore/cloud_firestore.dart';

var today = DateTime.now();
String date = '${today.day} - ${today.month} - ${today.year}';

List list = [];
List pemasukan = [];
List pengeluaran = [];

Future fetchData() async {
  var data = await FirebaseFirestore.instance.collection("neraca").get();
  for (int i = 0; i < data.docs.length; i++) {
    if (data.docs[i].data()['tanggal'] == '$date') {
      List model = [
        data.docs[i].data()['tanggal'],
        data.docs[i].data()['tipe'],
        data.docs[i].data()['jumlah'],
        data.docs[i].data()['keterangan']
      ];
      if (data.docs[i].data()['tipe'] == "Pemasukan") {
        pemasukan.add(data.docs[i].data()['tipe']);
      } else {
        pengeluaran.add(data.docs[i].data()['tipe']);
      }
      list.add(model);
    }
  }
}
