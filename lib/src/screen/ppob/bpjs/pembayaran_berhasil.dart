import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:ansor_build/src/screen/ppob/pln/pembayaran_berhasil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:indonesia/indonesia.dart';

class PembayaranBerhasil extends StatefulWidget {
  final String jenis;
  PembayaranBerhasil({this.jenis});

  @override
  _PembayaranBerhasilState createState() => _PembayaranBerhasilState();
}

class _PembayaranBerhasilState extends State<PembayaranBerhasil> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (__) => new BerandaPage())),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 333,
                  height: 35,
                  child: RaisedButton(
                    child: Text('SELESAI', style: TextStyle(color: Colors.green)),
                    color: Colors.white,
                    onPressed: () {
                      setState(() => _isLoading = true);
                      Navigator.push(context, new MaterialPageRoute(builder: (__) => new BerandaPage()));
                      setState(() => _isLoading = false);
                    },
                  ),
                )
              ]
            )
          ),
        
        elevation: 0
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                    Center(
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: Colors.grey[300], width: 1)
                        ),
                      ),
                    ),

                    Container( height: 10 ),

                    Center(
                      child: Text("Transaksi Berhasil", style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                    
                    Container( height: 15 ),
                    
                    Center(
                      child: Text("tanggal" + ", " + "jam", textAlign: TextAlign.center, style: new TextStyle(fontSize: 12.0)),
                    ),

                    Center(
                      child: Text("via Un1ty", textAlign: TextAlign.center, style: new TextStyle(fontSize: 12.0)),
                    ),
                    
                    Container( height: 25 ),

                    Text("Detail", textAlign: TextAlign.start, style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),

                    Container( height: 10 ),

                    widget.jenis == "kesehatan" ?
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
                                    child: Text("BPJS Kesehatan", style: new TextStyle(fontSize: 12.0)),
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
                                    child: Text("nama", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("No VA/Keluarga", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                  Container(
                                    child: Text("no", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Periode", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                  Container(
                                    child: Text("tgl", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Jumlah Keluarga", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                  Container(
                                    child: Text("jumlah", style: new TextStyle(fontSize: 12.0)),
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
                                    child: Text("no", style: new TextStyle(fontSize: 12.0)),
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
                                    child: Text("total", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        )
                      ) :
                      Container (
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 12.0,
                          bottom: 12.0
                        ),
                        width: double.infinity,
                        height: 300.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: Colors.grey[300],width: 1)
                        ),
                        child: Column(
                          children: <Widget>[

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Jenis Layanan", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                  Container(
                                    child: Text("BPJS Ketenagakerjaan", style: new TextStyle(fontSize: 12.0)),
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
                                    child: Text("nama", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("No KTP/Peserta", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                  Container(
                                    child: Text("no", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Periode", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                  Container(
                                    child: Text("Bulan", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Jaminan Kecelakaan Kerja", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                  Container(
                                    child: Text("Rp", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Jaminan Kematian", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                  Container(
                                    child: Text("Rp", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Jaminan Hari Tua", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                  Container(
                                    child: Text("Rp", style: new TextStyle(fontSize: 12.0)),
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
                                    child: Text("no", style: new TextStyle(fontSize: 12.0)),
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
                                    child: Text("Rp", style: new TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        )
                      ),

                    Container( height: 15 ),

                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}