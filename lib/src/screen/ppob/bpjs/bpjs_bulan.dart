import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:flutter/material.dart';

class BpjsBulan extends StatefulWidget {
  final String jenis;
  BpjsBulan({this.jenis});

  @override
  _BpjsBulanState createState() => _BpjsBulanState();
}

class _BpjsBulanState extends State<BpjsBulan> {
  BpjsServices _bpjsServices = BpjsServices();
  
  final data = [
    {"id": 1, "bulan": "2020-01-01"},
    {"id": 2, "bulan": "2020-02-01"},
    {"id": 3, "bulan": "2020-02-01"}
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
              widget.jenis == "kesehatan" ? 'Bayar Hingga' : 'Bayar Untuk',
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

                          widget.jenis == "kesehatan" ?

                            Container(
                              child: Column(
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
                                ]
                              )
                            )
                          : 
                            Container(
                              child: Column(
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
                                ]
                              )
                            )

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
