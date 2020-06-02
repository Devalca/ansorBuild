import 'package:ansor_build/src/model/dataUser_model.dart';
import 'package:ansor_build/src/service/dataUser_service.dart';
import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:ansor_build/src/model/transfer_model.dart';
import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:ansor_build/src/service/local_service.dart';

class TransferBerhasil extends StatefulWidget {
  final String url;
  TransferBerhasil({this.url});
  @override
  _TransferBerhasilState createState() => _TransferBerhasilState();
}

class _TransferBerhasilState extends State<TransferBerhasil> {
  String _url = "";
  DataUserService _dataUserServices = DataUserService();

  @override
  void initState() {
    super.initState();

    setState(() {
      _url = widget.url;
    });
  }

  Future<Berhasil> fetchBerhasil() async {
    final response = await http.get('http://103.9.125.18:3000' + _url);

    if (response.statusCode == 200) {
      return berhasilFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail Berhasil');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget middleSection = Expanded(
      child: new Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FutureBuilder<Berhasil>(
                    future: fetchBerhasil(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.data.isNotEmpty) {
                        DateTime tgl_trf = snapshot.data.data[0].tgl_trf;
                        return (Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      border: Border.all(
                                          color: Colors.grey[300], width: 1)),
                                ),
                              ),
                              Container(height: 10),
                              Center(
                                child: Text("Transaksi Berhasil",
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                              ),
                              Container(height: 15),
                              Center(
                                child: Text(
                                    NumberFormat.simpleCurrency(
                                            locale: 'id', decimalDigits: 0)
                                        .format(snapshot.data.data[0].total),
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                              ),
                              Container(height: 15),
                              Center(
                                child: Text(
                                    tanggal(tgl_trf) +
                                        ", " +
                                        DateFormat('HH:mm').format(tgl_trf),
                                    style: new TextStyle(
                                        fontSize: 12.0, color: Colors.black)),
                              ),
                              Center(
                                child: Text(
                                    "No Transaksi " +
                                        snapshot.data.data[0].no_transaksi,
                                    style: new TextStyle(
                                        fontSize: 12.0, color: Colors.black)),
                              ),
                              Container(height: 15),
                              // Container(
                              //     height: 100,
                              //     child: FutureBuilder<DataUser>(
                              //         future: _dataUserServices.getDataUser(),
                              //         builder: (context, snapshot) {
                              //           if (snapshot.hasData) {
                              //             return ListView.builder(
                              //                 itemCount:
                              //                     snapshot.data.data.length,
                              //                 itemBuilder: (context, i) {
                              //                   return Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       children: <Widget>[
                              //                         InkWell(
                              //                             onTap: () {},
                              //                             child: Container(
                              //                                 child: Column(
                              //                                     crossAxisAlignment:
                              //                                         CrossAxisAlignment
                              //                                             .start,
                              //                                     children: <
                              //                                         Widget>[
                              //                                   Padding(
                              //                                     padding: const EdgeInsets
                              //                                             .only(
                              //                                         top: 10.0,
                              //                                         bottom:
                              //                                             0.0),
                              //                                     child:
                              //                                         Container(
                              //                                             height:
                              //                                                 30,
                              //                                             child:
                              //                                                 Text(
                              //                                               snapshot.data.data[i].namaLengkap,
                              //                                               style:
                              //                                                   new TextStyle(fontSize: 16.0),
                              //                                             )),
                              //                                   ),
                              //                                   Divider(
                              //                                     height: 12,
                              //                                     color: Colors
                              //                                         .black,
                              //                                   ),
                              //                                 ]))),
                              //                       ]);
                              //                 });
                              //           } else if (snapshot.hasError) {
                              //             return Text("${snapshot.error}");
                              //           }
                              //           return Center(
                              //               child: CircularProgressIndicator());
                              //         })),
                              // Container(
                              //     child: FutureBuilder<DataUser>(
                              //   future: _dataUserServices.getDataUser(),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.hasData &&
                              //         snapshot.data.data.isNotEmpty) {
                              //       dynamic data = snapshot.data.data;
                              //       print(data);
                              //       return (Container(
                              //           child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: <Widget>[
                              //           Text("Dari",
                              //               style: new TextStyle(
                              //                   color: Colors.black,
                              //                   fontSize: 12.0,
                              //                   fontWeight: FontWeight.bold)),
                              //           Container(height: 5),
                              //           Row(children: <Widget>[
                              //             Container(
                              //               margin:
                              //                   EdgeInsets.only(right: 12.0),
                              //               child: Image.asset(
                              //                   "lib/src/assets/BPJS.png"),
                              //             ),
                              //             Container(
                              //               child: Text(
                              //                   "nama" + "\n" + "un1ty - nomor",
                              //                   style: new TextStyle(
                              //                       color: Colors.black,
                              //                       fontSize: 12.0)),
                              //             ),
                              //           ]),
                              //         ],
                              //       )));
                              //     } else if (snapshot.hasError) {
                              //       return Text("${snapshot.error}");
                              //     }
                              //     return CircularProgressIndicator();
                              //   },
                              // )),
                              Container(height: 5),
                              Divider(
                                height: 12,
                                color: Colors.black26,
                              ),
                              Container(height: 5),
                              Text("Penerima",
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold)),
                              Container(height: 5),
                              Row(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 12.0),
                                  child: Image.asset("lib/src/assets/BPJS.png"),
                                ),
                                Container(
                                  child: Text(
                                      snapshot.data.data[0].nama_penerima +
                                          "\n" +
                                          snapshot.data.data[0].sumber_dana +
                                          " " +
                                          snapshot.data.data[0].no_penerima,
                                      style: new TextStyle(
                                          color: Colors.black, fontSize: 12.0)),
                                ),
                              ]),
                              Container(height: 5),
                              Divider(
                                height: 12,
                                color: Colors.black26,
                              ),
                            ]));
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text("Gagal Memuat Detail Pembayaran"));
                      }
                      return Center(child: CircularProgressIndicator());
                    })
              ],
            ),
          )),
    );

    Widget bottomBanner = new Column(children: <Widget>[
      Divider(
        height: 12,
        color: Colors.black26,
      ),
      Container(height: 5),
      Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: RaisedButton(
            child: Text('SELESAI',
                style: TextStyle(color: Colors.green, fontSize: 16.0)),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ),
      Container(height: 10),
    ]);

    Widget body = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        middleSection,
        bottomBanner,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.push(context,
              new MaterialPageRoute(builder: (__) => new LandingPage())),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.2,
      ),
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}
