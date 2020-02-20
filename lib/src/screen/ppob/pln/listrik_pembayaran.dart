import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ansor_build/src/service/pln/pascabayar_services.dart';

class ListrikPembayaran extends StatefulWidget {
  @override
  _ListrikPembayaranState createState() => _ListrikPembayaranState();
}

class _ListrikPembayaranState extends State<ListrikPembayaran> {
  PascaBayarServices get service => GetIt.I<PascaBayarServices>();
  bool _isLoading = false;
  // APIResponse<List<Pembayaran>> _apiResponse;

  @override
  void initState() {
    _fetchDetail();
    super.initState();
  }

  _fetchDetail() async{
    setState(() {
      _isLoading = true;
    });

    // _apiResponse = await service.getDetail();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text((postResult != null) ? postResult.transactionId : "Tidak Ada Data"),
            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50,
                    child: Text(
                      "gambar"
                    ),
                  ),
                  Container(
                    child: Text(
                      "Token Listrik PLN\n" + "Nama\n" + "Nomor"
                    ),
                  ),
                ],
              ),
            ),

            Container( height: 8 ),

            Text("Detail Pembayaran", style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),

            Container( height: 8 ),
                      
            Container(
              padding: const EdgeInsets.all((10.0)),
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0)
                ),
                border: Border.all(
                  color: Colors.grey[300],
                  width: 1,
                )
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Periode",
                      style: new TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Tanggal",
                      style: new TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              height: 40.0,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1.0, color: Colors.grey[300]),
                  right: BorderSide(width: 1.0, color: Colors.grey[300])
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Total Tagihan"
                    ),
                  ),
                  Container(
                    child: Text(
                      "Rp. 0"
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              height: 40.0,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1.0, color: Colors.grey[300]),
                  right: BorderSide(width: 1.0, color: Colors.grey[300])
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Biaya Pelayanan"
                    ),
                  ),
                  Container(
                    child: Text(
                      "Rp. 0"
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0)
                ),
                border: Border.all(
                  color: Colors.grey[300],
                  width: 1,
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Total"
                    ),
                  ),
                  Container(
                    child: Text(
                      "Rp. 0"
                    ),
                  ),
                ],
              ),
            ),

            Container( height: 8 ),

            Container(
              padding: const EdgeInsets.all((10.0)),
              height: 40.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0)
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Un1ty",
                      style: new TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    child: Text(
                      "icon",
                      style: new TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all((10.0)),
              height: 40.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0)
                ),
                border: Border.all(
                  color: Colors.grey[300],
                  width: 1,
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Saldo Un1ty"
                    ),
                  ),
                  Container(
                    child: Text(
                      "Rp. 0"
                    ),
                  ),
                ],
              ),
            ),

            Container( height: 8 ),

            SizedBox(
              width :double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('BAYAR', style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: () async{
                  
                },
              ),
            ),
          ]
        )
      ),
    );
  }
}