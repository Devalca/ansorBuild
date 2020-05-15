import 'package:ansor_build/src/screen/transfer/kesesama.dart';
import 'package:ansor_build/src/screen/transfer/transfer.dart';
import 'package:ansor_build/src/screen/transfer/transferBerhasil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailTransfer extends StatefulWidget {
  @override
  _DetailTransferState createState() => _DetailTransferState();
}

class _DetailTransferState extends State<DetailTransfer> {
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
                Text("Penerima",
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold)),
                Container(height: 10),
                Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 12.0),
                    child: Image.asset("lib/src/assets/BPJS.png"),
                  ),
                  Container(
                    child: Text("nama" + "\n" + "un1ty - nomor",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 12.0)),
                  ),
                ]),
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.infinity,
                  height: 130.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.grey[300], width: 1)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Sumber Dana",
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 12.0)),
                            ),
                            Container(
                              child: Text("Un1ty",
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 12.0)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Nominal Transfer",
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 12.0)),
                            ),
                            Container(
                              child: Text(NumberFormat.simpleCurrency(
                                      locale: 'id', decimalDigits: 0)
                                  .format(0)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Biaya Transaksi",
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 12.0)),
                            ),
                            Container(
                              child: Text(NumberFormat.simpleCurrency(
                                      locale: 'id', decimalDigits: 0)
                                  .format(0)),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 12, color: Colors.black87),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text("Total",
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 13.0)),
                            ),
                            Container(
                              child: Text(
                                  NumberFormat.simpleCurrency(
                                          locale: 'id', decimalDigits: 0)
                                      .format(0),
                                  style: new TextStyle(
                                      color: Colors.black, fontSize: 13.0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.all(10.0),
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       shape: BoxShape.rectangle,
                //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //       border: Border.all(color: Colors.grey[300], width: 1)),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Container(
                //               child: Text("Sumber Dana",
                //                   style: new TextStyle(
                //                       color: Colors.black, fontSize: 12.0)),
                //             ),
                //             Container(
                //               child: Text("Un1ty"),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Container(
                //               child: Text("Nominal Transfer",
                //                   style: new TextStyle(
                //                       color: Colors.black, fontSize: 12.0)),
                //             ),
                //             Container(
                //                 child: Text(NumberFormat.simpleCurrency(
                //                         locale: 'id', decimalDigits: 0)
                //                     .format(0))),
                //           ],
                //         ),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Container(
                //               child: Text("Biaya Transaksi",
                //                   style: new TextStyle(
                //                       color: Colors.black, fontSize: 12.0)),
                //             ),
                //             Container(
                //                 child: Text(NumberFormat.simpleCurrency(
                //                         locale: 'id', decimalDigits: 0)
                //                     .format(0))),
                //           ],
                //         ),
                //       ),
                //       Divider(height: 12, color: Colors.black87),
                //       Expanded(
                //         flex: 1,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Container(
                //               child: Text("Total",
                //                   style: new TextStyle(
                //                       color: Colors.black, fontSize: 12.0)),
                //             ),
                //             Container(
                //                 child: Text(NumberFormat.simpleCurrency(
                //                         locale: 'id', decimalDigits: 0)
                //                     .format(0))),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
              Navigator.push(context,
                  new MaterialPageRoute(builder: (__) => new TransferBerhasil()));
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
