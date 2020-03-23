import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pembayaran.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/model/pln_model.dart';

class BpjsKesehatan extends StatefulWidget {
  @override
  _BpjsKesehatanState createState() => _BpjsKesehatanState();
}

class _BpjsKesehatanState extends State<BpjsKesehatan> {
  String url = "";

  bool _isLoading = false;
  bool _fieldNoPelanggan;

  PlnServices _plnServices = PlnServices();

  TextEditingController _noPelangganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
            child: _isLoading ? Center(child: CircularProgressIndicator()) :  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  child: Text(
                    "Nomor VA", 
                    style: new TextStyle(fontSize: 14.0), 
                    textAlign: TextAlign.left
                  )
                ),

                TextField(
                  controller: _noPelangganController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 123456789',
                    errorText: _fieldNoPelanggan == null || _fieldNoPelanggan ? null : "Kolom Nomor Meter harus diisi",
                  ),
                  style: new TextStyle(fontSize:  14.0),
                  onChanged: (value) {
                    bool isFieldValid = value.trim().isNotEmpty;
                    if (isFieldValid != _fieldNoPelanggan) {
                      setState(() => _fieldNoPelanggan = isFieldValid);
                    }
                  },
                ),

                Container( height: 15 ),

                Container(
                  child: Text(
                    "Nomor Pelanggan", 
                    style: new TextStyle(fontSize: 14.0), 
                    textAlign: TextAlign.left
                  )
                ),

                TextField(
                  controller: _noPelangganController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 123456789',
                    errorText: _fieldNoPelanggan == null || _fieldNoPelanggan ? null : "Kolom Nomor Pelanggan harus diisi",
                  ),
                  style: new TextStyle(fontSize:  14.0),
                  onChanged: (value) {
                    bool isFieldValid = value.trim().isNotEmpty;
                    if (isFieldValid != _fieldNoPelanggan) {
                      setState(() => _fieldNoPelanggan = isFieldValid);
                    }
                  },
                ),

                // Container( height: 250 ),

                Divider(
                  height: 12,
                  color: Colors.black,
                ),

                SizedBox(
                  width :double.infinity,
                  height: 35,
                  child: RaisedButton(
                    child: Text('LANJUT', style: TextStyle(color: Colors.white)),
                    color: Colors.green,
                    onPressed: () {

                      setState(() { 
                        _isLoading = true; 
                      });

                      Navigator.push(context, new MaterialPageRoute(builder: (__) => new ListrikPembayaran()));

                      // if(_noMeterController.text.isEmpty){
                      //   setState(() {
                      //     _isLoading = false; 
                      //     _fieldNoPelanggan = false; 
                      //   });
                      // }else{
                      //   String noMeter = _noMeterController.text.toString();

                      //   PostPascabayar pascabayar = PostPascabayar(noMeter: noMeter, userId: 1, walletId: 1);

                      //   _plnServices.postPascabayar(pascabayar).then((response) async {
                      //     if (response.statusCode == 302){
                      //       print("berhasil body: " + response.body);
                      //       print(response.statusCode);

                      //       url = response.headers['location'];
                      //       print("url: " + url);

                      //       _plnServices.saveTransactionId(url).then((bool committed) {
                      //         print(url);
                      //       });

                      //       Navigator.push(context, new MaterialPageRoute(builder: (__) => new ListrikPembayaran(status: "pascabayar")));
                      //       setState(() => _isLoading = false);

                      //     }else if(response.statusCode == 200) {
                      //       print("berhasil body: " + response.body);
                      //       print(response.statusCode);

                      //       Map data = jsonDecode(response.body);
                      //       transactionId = data['transactionId'].toString();
                      //       print("transactionId: " + transactionId);
                            
                      //       url = '/ppob/pln/' + transactionId;
                      //       print("url: " + url);

                      //       _plnServices.saveTransactionId(url).then((bool committed) {
                      //         print(url);
                      //       });
                
                      //       Navigator.push(context, new MaterialPageRoute(builder: (__) => new ListrikPembayaran(status: "pascabayar")));
                      //       setState(() => _isLoading = false);
                      //     } else {
                      //       print("error: " + response.body);
                      //       print(response.statusCode);
                      //     }
                      //   });
                      // }
                    },
                  ),
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.orangeAccent,
                      height: 250,
                    ),
                    Positioned(
                      bottom: 40.0,
                      child: Container(
                        height: 50,
                        width: 250,
                        color: Colors.black38,
                        child: Center(
                          child: Text(
                            "Stack & Positioned",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]
            )
          )
      )
    );
  }
}