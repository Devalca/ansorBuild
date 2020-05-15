import 'package:ansor_build/src/screen/histori/histori_detail.dart';
import 'package:flutter/material.dart';

class HistoriMainPage extends StatefulWidget {
  @override
  _HistoriMainPageState createState() => _HistoriMainPageState();
}

class _HistoriMainPageState extends State<HistoriMainPage> {
  final List<int> _listData = List<int>.generate(20, (i) => i);
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
      body: ListView(
        children: _listData.map((i) {
          return i % 10 == 0
              ? Container(
                  color: Colors.grey.withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("20 Desember, 2020",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black45,
                          )),
                    ],
                  ),
                  padding: EdgeInsets.all(10.0),
                )
              : Column(
                  children: <Widget>[
                    InkWell(
                      onTap: _toHistoriTrx,
                      child: ListTile(
                        title: Text("TopUp dari Bank BCA"),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Pembayaran"),
                            Text(
                              "Rp1.000.000",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(), //                           <-- Divider
                  ],
                );
        }).toList(),
      ),
    );
  }

  _toHistoriTrx() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HistoriDetailPage()));
  }
}
