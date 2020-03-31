import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:flutter/material.dart';

class BpjsBulan extends StatefulWidget {
  @override
  _BpjsBulanState createState() => _BpjsBulanState();
}

class _BpjsBulanState extends State<BpjsBulan> {
  BpjsServices _bpjsServices = BpjsServices();

  final array = {
    "data": [
      {"id": 1, "tanggal": "2020-01-01", "nama": "Januari 2020"},
      {"id": 2, "tanggal": "2020-02-01", "nama": "Febuari 2020"},
      {"id": 3, "tanggal": "2020-02-01", "nama": "Maret 2020"}
    ],
    "message": "Berhasil"
  };

  final data = [
    {"id": 1, "tanggal": "2020-01-01", "nama": "Januari 2020"},
    {"id": 2, "tanggal": "2020-02-01", "nama": "Febuari 2020"},
    {"id": 3, "tanggal": "2020-02-01", "nama": "Maret 2020"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            title: Text(
              'Bayar Hingga',
              style: TextStyle(color: Colors.black),
            )),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: FutureBuilder<Bulan>(
            future: _bpjsServices.fetchBulan(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, i) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 30,
                            child: Text(
                              snapshot.data.data[i].nama,
                              style: new TextStyle(fontSize: 16.0),
                          )),

                          Divider(
                            height: 12,
                            color: Colors.black,
                          ),

                          Container( height: 15 ),
                        ]);
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child:CircularProgressIndicator());
            },
          )),
        ));
  }
}
