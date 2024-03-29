import 'package:ansor_build/src/screen/beranda/landing_screen.dart';
import 'package:indonesia/indonesia.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:ansor_build/src/service/pln_services.dart';

class PembayaranBerhasilPln extends StatefulWidget {
  final String status;
  PembayaranBerhasilPln({this.status});

  @override
  _PembayaranBerhasilPlnState createState() => _PembayaranBerhasilPlnState();
}

class _PembayaranBerhasilPlnState extends State<PembayaranBerhasilPln> {
  bool _isLoading = false;
  String _url = "";
  PlnServices _plnServices = PlnServices();

  @override
  void initState() {
    super.initState();
    _plnServices.getTransactionId().then(updateUrl);
  }

  void updateUrl(String url) {
    setState(() {
      this._url = url;
    });
  }

  Future<Detail> fetchDetail() async {
    final response = await http.get('http://103.9.125.18:3000' + _url);

    if (response.statusCode == 200) {
      return detailFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail transaction');
    }
  }

  token(data) {
    var arr = new List(3);
    var item = data.length;
    arr[0] = data.substring(0, 4);
    arr[1] = data.substring(4, 8);
    arr[2] = data.substring(8, item);
    return arr.join(" - ");
  }

  tgl(data) {
    var data2 = data.toString();
    return data2.substring(8, 10);
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder<Detail>(
                          future: fetchDetail(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              DateTime periode = snapshot.data.createdAt;
                              if (widget.status == "prabayar") {
                                return (Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  color: Colors.grey[300],
                                                  width: 1)),
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
                                            tgl(periode) +
                                                " " +
                                                tanggal(periode).substring(2) +
                                                ", " +
                                                DateFormat('HH:mm')
                                                    .format(periode),
                                            textAlign: TextAlign.center,
                                            style:
                                                new TextStyle(fontSize: 12.0)),
                                      ),
                                      Center(
                                        child: Text("via Un1ty",
                                            textAlign: TextAlign.center,
                                            style:
                                                new TextStyle(fontSize: 12.0)),
                                      ),
                                      Container(height: 25),
                                      Text("Nomor Token",
                                          textAlign: TextAlign.start,
                                          style: new TextStyle(fontSize: 14.0)),
                                      Container(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            border: Border.all(
                                                color: Colors.grey[300],
                                                width: 1)),
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                        token(snapshot
                                                            .data.noToken),
                                                        style: new TextStyle(
                                                            fontSize: 14.0)),
                                                  ),
                                                  Container(
                                                    child: Text("Salin",
                                                        style: new TextStyle(
                                                            fontSize: 12.0,
                                                            color:
                                                                Colors.green)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(height: 15),
                                      Text("Detail",
                                          textAlign: TextAlign.start,
                                          style: new TextStyle(fontSize: 14.0)),
                                      Container(height: 10),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 12.0,
                                            bottom: 12.0),
                                        width: double.infinity,
                                        height: 200.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            border: Border.all(
                                                color: Colors.grey[300],
                                                width: 1)),
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Jenis Layanan",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        "Listrik " +
                                                            NumberFormat.simpleCurrency(
                                                                    locale:
                                                                        'id',
                                                                    decimalDigits:
                                                                        0)
                                                                .format(snapshot
                                                                    .data
                                                                    .nominal),
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                        "Nama Pelanggan",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot
                                                            .data.namaPelanggan,
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Periode",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        tanggal(periode)
                                                            .substring(2),
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                        "No Meter/ID Pelanggan",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot.data.noMeter,
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Tarif/Daya",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot.data.tarif +
                                                            '/' +
                                                            snapshot.data.daya,
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Total Kwh",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot.data.totalKwh
                                                            .toString(),
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                        "Nomor Transaksi",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot
                                                            .data.noTransaksi,
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Total Tagihan",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        NumberFormat
                                                                .simpleCurrency(
                                                                    locale:
                                                                        'id',
                                                                    decimalDigits:
                                                                        0)
                                                            .format(snapshot
                                                                .data.total),
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])));
                              } else if (widget.status == "pascabayar") {
                                return (Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  color: Colors.grey[300],
                                                  width: 1)),
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
                                            tgl(periode) +
                                                " " +
                                                tanggal(periode).substring(2) +
                                                ", " +
                                                DateFormat('HH:mm')
                                                    .format(periode),
                                            textAlign: TextAlign.center,
                                            style:
                                                new TextStyle(fontSize: 12.0)),
                                      ),
                                      Center(
                                        child: Text("via Un1ty",
                                            textAlign: TextAlign.center,
                                            style:
                                                new TextStyle(fontSize: 12.0)),
                                      ),
                                      Container(height: 25),
                                      Text("Detail",
                                          textAlign: TextAlign.start,
                                          style: new TextStyle(fontSize: 14.0)),
                                      Container(height: 10),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 12.0,
                                            bottom: 12.0),
                                        width: double.infinity,
                                        height: 200.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            border: Border.all(
                                                color: Colors.grey[300],
                                                width: 1)),
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Jenis Layanan",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        "Listrik " +
                                                            NumberFormat.simpleCurrency(
                                                                    locale:
                                                                        'id',
                                                                    decimalDigits:
                                                                        0)
                                                                .format(snapshot
                                                                    .data
                                                                    .nominal),
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                        "Nama Pelanggan",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot
                                                            .data.namaPelanggan,
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Periode",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        tanggal(periode)
                                                            .substring(2),
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                        "No Meter/ID Pelanggan",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot.data.noMeter,
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Tarif/Daya",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot.data.tarif +
                                                            '/' +
                                                            snapshot.data.daya,
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Total Kwh",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot.data.totalKwh
                                                            .toString(),
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                        "Nomor Transaksi",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        snapshot
                                                            .data.noTransaksi,
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("Total Tagihan",
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        NumberFormat
                                                                .simpleCurrency(
                                                                    locale:
                                                                        'id',
                                                                    decimalDigits:
                                                                        0)
                                                            .format(snapshot
                                                                .data.total),
                                                        style: new TextStyle(
                                                            fontSize: 13.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])));
                              }
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return Center(child: CircularProgressIndicator());
                          })
                    ],
                  )
                ]),
          )),
    );

    Widget bottomBanner = new Column(children: <Widget>[
      Divider(
        height: 12,
        color: Colors.black26,
      ),
      Container(height: 5),
      Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                child: Text('SELESAI',
                    style: TextStyle(color: Colors.green, fontSize: 16.0)),
                color: Colors.white,
                onPressed: () {
                  setState(() => _isLoading = true);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) => new LandingPage()));
                  setState(() => _isLoading = false);
                },
              ),
            ),
          )),
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
