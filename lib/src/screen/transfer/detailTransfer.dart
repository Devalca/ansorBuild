import 'package:ansor_build/src/model/transfer_model.dart';
import 'package:ansor_build/src/screen/component/pin.dart';
import 'package:ansor_build/src/screen/transfer/kesesama.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DetailTransfer extends StatefulWidget {
  final String url;
  DetailTransfer({this.url});

  @override
  _DetailTransferState createState() => _DetailTransferState();
}

class _DetailTransferState extends State<DetailTransfer> {
  String _url = "";

  @override
  void initState() {
    super.initState();

    _url = widget.url;
  }

  Future<Berhasil> fetchBerhasil() async {
    final response = await http.get('http://103.9.125.18:3000' + _url);

    if (response.statusCode == 200) {
      return berhasilFromJson(response.body);
    } else {
      throw Exception('Failed to load Transfer Berhasil');
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
                        return (Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Penerima",
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold)),
                                Container(height: 10),
                                Row(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 12.0),
                                    child:
                                        Image.asset("lib/src/assets/BPJS.png"),
                                  ),
                                  Container(
                                    child: Text(
                                        snapshot.data.data[0].nama_penerima +
                                            "\n" +
                                            snapshot.data.data[0].sumber_dana +
                                            " - " +
                                            snapshot.data.data[0].no_penerima,
                                        style: new TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0)),
                                  ),
                                ]),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  width: double.infinity,
                                  height: 130.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(
                                          color: Colors.grey[300], width: 1)),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Text("Sumber Dana",
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0)),
                                            ),
                                            Container(
                                              child: Text(
                                                  snapshot
                                                      .data.data[0].sumber_dana,
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Text("Nominal Transfer",
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0)),
                                            ),
                                            Container(
                                              child: Text(
                                                  NumberFormat.simpleCurrency(
                                                          locale: 'id',
                                                          decimalDigits: 0)
                                                      .format(snapshot
                                                          .data
                                                          .data[0]
                                                          .nominal_trf),
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Text("Biaya Transaksi",
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0)),
                                            ),
                                            Container(
                                              child: Text(
                                                  NumberFormat.simpleCurrency(
                                                          locale: 'id',
                                                          decimalDigits: 0)
                                                      .format(snapshot.data
                                                          .data[0].admin_fee),
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                          height: 12, color: Colors.black87),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Text("Total",
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.0)),
                                            ),
                                            Container(
                                              child: Text(
                                                  NumberFormat.simpleCurrency(
                                                          locale: 'id',
                                                          decimalDigits: 0)
                                                      .format(snapshot
                                                          .data.data[0].total),
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ));
                      } else if (snapshot.hasError &&
                          snapshot.data.data.isEmpty) {
                        return Center(
                            child: Text("Gagal Memuat Detail Transfer"));
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
          height: 35,
          child: RaisedButton(
            child: Text('TRANSFER', style: TextStyle(color: Colors.white)),
            color: Colors.green,
            onPressed: () async {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new Pin(statusbyr: "transferSesama")));
            },
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
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (__) => new Kesesama()));
              }),
          title: Text(
            "Detail",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}
