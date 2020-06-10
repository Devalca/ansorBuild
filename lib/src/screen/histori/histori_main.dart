import 'package:ansor_build/src/model/histori_model.dart';
import 'package:ansor_build/src/screen/component/formatIndo.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/histori/histori_bpjs.dart';
import 'package:ansor_build/src/screen/histori/histori_pdam.dart';
import 'package:ansor_build/src/screen/histori/histori_pln.dart';
import 'package:ansor_build/src/screen/histori/histori_pulsa.dart';
import 'package:ansor_build/src/service/histori_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:indonesia/indonesia.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'histori_transfer.dart';

class HistoriMainPage extends StatefulWidget {
  @override
  _HistoriMainPageState createState() => _HistoriMainPageState();
}

class _HistoriMainPageState extends State<HistoriMainPage> {
  String headUrl;
  HistoriService _historiService = HistoriService();
  List<DataHistori> _histori = List<DataHistori>();
  List<DataHistori> _historiForDisplay = List<DataHistori>();

  @override
  void initState() {
    _historiService.getData().then((value) {
      setState(() {
        _histori.addAll(value.data);
        _historiForDisplay = _histori;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
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
          'Histori',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<Histori>(
        future: _historiService.getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text("Koneksi Terputus"),
              );
            case ConnectionState.waiting:
              return centerLoading();
            default:
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: _historiForDisplay.length,
                  itemBuilder: (context, index) {
                    DateTime datePlus = _historiForDisplay[index].tglTrx;
                    String plusDate = formatTanggal(datePlus);
                    if (index == 0) {
                      return _buildListHeader(index);
                    } else {
                      String lag =
                          formatTanggal(_historiForDisplay[index - 1].tglTrx);
                      if (plusDate == lag) {
                        return _buildListItem(index);
                      } else {
                        return _buildListHeader(index);
                      }
                    }
                  },
                );
              } else {
                return Text('Result: ${snapshot.error}');
              }
          }
        },
      ),
    );
  }

  Widget _buildListHeader(index) {
    return Material(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: StickyHeader(
            header: Container(
              color: Colors.grey[200],
              height: 40.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerRight,
              child: Text(
                '${formatTanggal(_historiForDisplay[index].tglTrx)}',
              ),
            ),
            content: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: _buildListItem(index))),
      ),
    );
  }

  Widget _buildListItem(index) {
    return GestureDetector(
      onTap: () {
        _toHistoriTrx(index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black38)),
        ),
        child: ListTile(
          title: Text(_historiForDisplay[index].deskripsi),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_historiForDisplay[index].label),
              Text(
                rupiah(_historiForDisplay[index].nominalTrx),
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }

  _toHistoriTrx(index) {
    String deskiTrans = _historiForDisplay[index].deskripsi;
    if (deskiTrans == "Pulsa Prabayar" || deskiTrans == "Pulsa Pascabayar") {
      String idTrx = _historiForDisplay[index].idTrx.toString();
      setState(() {
        headUrl = "http://103.9.125.18:3000/ppob/detail/pulsa/$idTrx";
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HistoriPulsaPage(headUrl)));
    } else if (deskiTrans == "PDAM") {
      String idTrx = _historiForDisplay[index].idTrx.toString();
      setState(() {
        headUrl = "http://103.9.125.18:3000/ppob/detail/pdam/$idTrx";
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HistoriPdamPage(headUrl)));
    } else if (deskiTrans == "Token Listrik PLN") {
      String idTrx = _historiForDisplay[index].idTrx.toString();
      setState(() {
        headUrl = "http://103.9.125.18:3000/ppob/detail/pln/$idTrx";
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HistoriPlnPage(headUrl)));
    } else if (deskiTrans == "BPJS Ketenagakerjaan") {
      String idTrx = _historiForDisplay[index].idTrx.toString();
      String jenis = "kerja";
      setState(() {
        headUrl =
            "http://103.9.125.18:3000/ppob/bpjs/detail/ketenagakerjaan/$idTrx";
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoriBpjsPage(headUrl, jenis)));
    } else if (deskiTrans == "BPJS Kesehatan") {
      String idTrx = _historiForDisplay[index].idTrx.toString();
      String jenis = "kesehatan";
      setState(() {
        headUrl = "http://103.9.125.18:3000/ppob/bpjs/detail/kesehatan/$idTrx";
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoriBpjsPage(headUrl, jenis)));
    } else {
      String idTrx = _historiForDisplay[index].idTrx.toString();
      setState(() {
        headUrl = "http://103.9.125.18:3000/detail/transfer/$idTrx";
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoriTransferPage(headUrl)));
    }
  }
}
