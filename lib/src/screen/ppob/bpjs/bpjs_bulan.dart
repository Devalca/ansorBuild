import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_main.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:flutter/material.dart';

class BpjsBulan extends StatefulWidget {
  final String jenis;
  final String noVa;
  final String noKtp;
  BpjsBulan({this.jenis, this.noVa, this.noKtp});

  @override
  _BpjsBulanState createState() => _BpjsBulanState();
}

class _BpjsBulanState extends State<BpjsBulan> {
  @override
  void initState() {
    super.initState();

    print("di bulan");
    print(widget.noVa);
    print(widget.noKtp);
  }

  bool _isLoading = false;

  BpjsServices _bpjsServices = BpjsServices();

  final bulanBpjsKerja = [
    {"id": 1, "bulan": "1 Bulan"},
    {"id": 2, "bulan": "3 Bulan"},
    {"id": 3, "bulan": "6 Bulan"},
    {"id": 4, "bulan": "12 Bulan"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
            backgroundColor: Colors.white,
            title: Text(
              widget.jenis == "kesehatan" ? 'Bayar Hingga' : 'Bayar Untuk',
              style: TextStyle(color: Colors.black),
            )),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: widget.jenis == "kesehatan"
                    ? Container(
                        child: FutureBuilder<Bulan>(
                        future: _bpjsServices.fetchBulan(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, i) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new GestureDetector(
                                          onTap: () {
                                            setState(() => _isLoading = true);
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (__) => new Bpjs(
                                                        index: 0,
                                                        tgl: snapshot.data
                                                            .data[i].tanggal,
                                                        nm: snapshot
                                                            .data.data[i].nama,
                                                        noVa: widget.noVa)));
                                            setState(() => _isLoading = false);
                                          },
                                          child: Container(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                Container(
                                                    height: 30,
                                                    child: Text(
                                                      snapshot
                                                          .data.data[i].nama,
                                                      style: new TextStyle(
                                                          fontSize: 16.0),
                                                    )),
                                                Divider(
                                                  height: 12,
                                                  color: Colors.black,
                                                ),
                                                Container(height: 15),
                                              ]))),
                                    ]);
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ))
                    : Container(
                        child: FutureBuilder<Bayar>(
                            future: _bpjsServices.fetchBayar(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: (context, i) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new GestureDetector(
                                              onTap: () {
                                                setState(
                                                    () => _isLoading = true);
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (__) =>
                                                            new Bpjs(
                                                                index: 1,
                                                                bln: snapshot
                                                                    .data
                                                                    .data[i]
                                                                    .nama,
                                                                periode: snapshot
                                                                    .data
                                                                    .data[i]
                                                                    .periodeByr,
                                                                noKtp: widget
                                                                    .noKtp)));
                                                setState(
                                                    () => _isLoading = false);
                                              },
                                              child: Container(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                    Container(
                                                        height: 30,
                                                        child: Text(
                                                          snapshot.data.data[i]
                                                              .nama,
                                                          style: new TextStyle(
                                                              fontSize: 16.0),
                                                        )),
                                                    Divider(
                                                      height: 12,
                                                      color: Colors.black,
                                                    ),
                                                    Container(height: 15),
                                                  ]))),
                                        ]);
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ),
              ));
  }
}
