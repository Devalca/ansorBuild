import 'package:ansor_build/src/model/dataUser_model.dart';
import 'package:ansor_build/src/service/dataUser_service.dart';
import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:ansor_build/src/model/transfer_model.dart';

class HistoriTransferPage extends StatefulWidget {
  final String headUrl;
  final String nomorUser;
  HistoriTransferPage(this.headUrl, this.nomorUser);

  @override
  _HistoriTransferPageState createState() => _HistoriTransferPageState();
}

class _HistoriTransferPageState extends State<HistoriTransferPage> {
  DataUserService _dataUserService = DataUserService();
  List<DetailUser> _detailUser = List<DetailUser>();
  List<DetailUser> _detailUserForDisplay = List<DetailUser>();

  @override
  void initState() {
    _dataUserService.getDataUser().then((value) => {
          setState(() {
            _detailUser.addAll(value.data);
            _detailUserForDisplay = _detailUser;
          })
        });
    super.initState();
  }

  Future<Berhasil> fetchBerhasil() async {
    final response = await http.get(widget.headUrl);
    if (response.statusCode == 200) {
      return berhasilFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail Berhasil');
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _detailUserForDisplay = _detailUser.where((userID) {
        var uu = userID.noHp;
        return uu.contains(widget.nomorUser);
      }).toList();
    });
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
                              Container(height: 5),
                              Text("Dari",
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold)),
                              Container(height: 5),
                              Row(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 12.0),
                                  child: Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        border: Border.all(
                                            color: Colors.grey[300], width: 1)),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                      _detailUserForDisplay[0].namaLengkap.toUpperCase() +
                                          "\n" +
                                          snapshot.data.data[0].sumber_dana +
                                          " - " +
                                          _detailUserForDisplay[0].noHp,
                                      style: new TextStyle(
                                          color: Colors.black, fontSize: 12.0)),
                                ),
                              ]),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Divider(
                                  height: 12,
                                  color: Colors.black26,
                                ),
                              ),
                              Text("Penerima",
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold)),
                              Container(height: 5),
                              Row(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 12.0),
                                  child: Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        border: Border.all(
                                            color: Colors.grey[300], width: 1)),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                      snapshot.data.data[0].nama_penerima.toUpperCase() +
                                          "\n" +
                                          snapshot.data.data[0].sumber_dana +
                                          " - " +
                                          snapshot.data.data[0].no_penerima,
                                      style: new TextStyle(
                                          color: Colors.black, fontSize: 12.0)),
                                ),
                              ]),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Divider(
                                  height: 12,
                                  color: Colors.black26,
                                ),
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
        height: 1,
        color: Colors.grey,
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 5.0, bottom: 5.0, top: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: Icon(Icons.message)),
            Expanded(
                flex: 8,
                child: Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Text("Butuh Bantuan ?"))),
            Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
          ],
        ),
      )
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
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
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
