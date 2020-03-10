import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik.dart';

class PembayaranBerhasil extends StatefulWidget {
  @override
  _PembayaranBerhasilState createState() => _PembayaranBerhasilState();
}

class _PembayaranBerhasilState extends State<PembayaranBerhasil> {
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

  // Future<Detail> fetchDetail() async {
  //   final response = await http.get('http://192.168.10.11:3000/ppob/detail/pln/' + _id);

  //   if (response.statusCode == 200) {
  //     return detailFromJson(response.body);
  //   } else {
  //     throw Exception('Failed to load Detail transaction');
  //   }
  // }

  Future<Detail> fetchDetail() async {
    final response = await http.get('http://192.168.10.11:3000' + _url);

    if (response.statusCode == 200) {
      return detailFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail transaction');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.white),
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              FutureBuilder<Detail>(
                future: fetchDetail(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return(
                      Container(
                        child: Column(
                          children: <Widget>[

                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(color: Colors.grey[300], width: 1)
                              ),
                            ),

                            Container( height: 10 ),

                            Text("Transaksi Berhasil", style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.green)),
                            
                            Container( height: 15 ),
                            
                            Text(DateFormat('dd M yyyy').format(snapshot.data.createdAt), textAlign: TextAlign.center, style: new TextStyle(fontSize: 12.0)),
                            Text("via Un1ty", textAlign: TextAlign.center, style: new TextStyle(fontSize: 12.0)),

                            Container( height: 25 ),

                            Text("Nomor Token", style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),

                            Container( height: 10 ),

                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(color: Colors.grey[300], width: 1)
                              ),
                              child: Column(
                                children: <Widget>[
                                  
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text(snapshot.data.noToken, style: new TextStyle(fontSize: 14.0)),
                                        ),
                                        Container(
                                          child: Text("Salin", style: new TextStyle(fontSize: 12.0, color: Colors.green)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container( height: 15 ),

                            Text("Detail", style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),

                            Container( height: 10 ),

                            Container(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 12.0,
                                bottom: 12.0
                              ),
                              width: double.infinity,
                              height: 200.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(color: Colors.grey[300],width: 1)
                              ),
                              child: Column(
                                children: <Widget>[
                                  
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Jenis Layanan", style: new TextStyle(fontSize: 12.0)),
                                        ),
                                        Container(
                                          child: Text("Token Listrik Rp. " + snapshot.data.nominal.toString(), style: new TextStyle(fontSize: 12.0)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Nama Pelanggan", style: new TextStyle(fontSize: 12.0)),
                                        ),
                                        Container(
                                          child: Text(snapshot.data.namaPelanggan, style: new TextStyle(fontSize: 12.0)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("No Meter/ID Pelanggan", style: new TextStyle(fontSize: 12.0)),
                                        ),
                                        Container(
                                          child: Text(snapshot.data.noMeter, style: new TextStyle(fontSize: 12.0)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Tarif/Daya", style: new TextStyle(fontSize: 12.0)),
                                        ),
                                        Container(
                                          child: Text(snapshot.data.tarif + '/' + snapshot.data.daya, style: new TextStyle(fontSize: 12.0)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Total Kwh", style: new TextStyle(fontSize: 12.0)),
                                        ),
                                        Container(
                                          child: Text(snapshot.data.totalKwh.toString(), style: new TextStyle(fontSize: 12.0)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Nomor Transaksi", style: new TextStyle(fontSize: 12.0)),
                                        ),
                                        Container(
                                          child: Text(snapshot.data.noTransaksi, style: new TextStyle(fontSize: 12.0)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Total Tagihan", style: new TextStyle(fontSize: 12.0)),
                                        ),
                                        Container(
                                          child: Text("Rp." + snapshot.data.total.toString(), style: new TextStyle(fontSize: 12.0)),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            
                            Container( height: 15 ),

                            Container( height: 1, width: double.infinity, color: Colors.grey[300] ),

                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                              ),
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width :double.infinity,
                                height: 35,
                                child: RaisedButton(
                                  child: Text('SELESAI', style: TextStyle(color: Colors.green)),
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() => _isLoading = true);
                                    Navigator.push(context, new MaterialPageRoute(builder: (__) => new Listrik()));
                                    setState(() => _isLoading = false);
                                  },
                                ),
                              ),
                            ),
                          ]
                        )
                      )
                    );
                  }else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }
              )
            ]
          )
        )
      )
    );
  }
}