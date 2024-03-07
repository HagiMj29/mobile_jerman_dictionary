import 'package:flutter/material.dart';
import 'package:mobile_jerman_dictionary/model/listdirectiory_model.dart';

class DetailKamus extends StatelessWidget {
  final Result? data;

  const DetailKamus(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data!.kataJerman),
        backgroundColor: Colors.blue[100],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(data?.kataJerman ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kata Indonesia: ${data?.kataIndonesia}"),
                Text("Jenis Kata: ${data?.jenisKata}"),
                Text("Contoh Penggunaan: ${data?.contohPenggunaan}"),
                Text("Contoh Penggunaan Jerman: ${data?.contohPenggunaanJerman}"),
                Text("Keterangan: ${data?.keterangan}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
