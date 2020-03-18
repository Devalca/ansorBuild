import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pembayaran.dart';
import 'package:intl/intl.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
final _formPrabayar = GlobalKey<FormState>();

class ListrikPrabayar extends StatefulWidget {
  @override
    _ListrikPrabayarState createState() => _ListrikPrabayarState();
  }

class _ListrikPrabayarState extends State<ListrikPrabayar> {
  bool _fieldNoMeter;
  PlnServices _plnServices = PlnServices();
  String url = "";
  String total = "";
  bool press1 = false;
  bool press2 = false;
  bool press3 = false;
  bool press4 = false;
  bool press5 = false;
  bool press6 = false;
  int nominal = 0;
  
  TextEditingController _noMeterController = TextEditingController();
  TextEditingController _nominalController = TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var _onPressed;
    if (press1 || press2 || press3 || press4 || press5 || press6 == true){
      _onPressed = (){
        setState(() => _isLoading = true);

        if(_noMeterController.text.isEmpty){
          setState(() {
            _isLoading = false; 
            _fieldNoMeter = true; 
          });
        }else{
          String noMeter = _noMeterController.text.toString();
          // String nominal = this.nominal;
          // String nominal = _nominalController.text.toString();

          PostPrabayar prabayar = PostPrabayar(noMeter: noMeter, nominal: nominal, userId: 1, walletId: 1);

          _plnServices.postPrabayar(prabayar).then((response) async {
            if(response.statusCode == 302) {
              print("berhasil body: " + response.body);
              print(response.statusCode);

              url = response.headers['location'];
              print("url: " + url);

              _plnServices.saveTransactionId(url).then((bool committed) {
                print(url);
              });

              Navigator.push(context, new MaterialPageRoute(builder: (__) => new ListrikPembayaran(status: "prabayar")));
              setState(() => _isLoading = false);

            }else if(response.statusCode == 200){
              print("berhasil body: " + response.body);
              print(response.statusCode);

              Map data = jsonDecode(response.body);
              transactionId = data['id'].toString();
              print("transactionId: " + transactionId);
              
              url= '/ppob/pln/' + transactionId;
              print("url: " + url);

              _plnServices.saveTransactionId(url).then((bool committed) {
                print(url);
              });

              Navigator.push(context, new MaterialPageRoute(builder: (__) => new ListrikPembayaran(status: "prabayar")));
              setState(() => _isLoading = false);
            } else {
              print("error: " + response.body);
              print(response.statusCode);
            }
          });
        }
      };
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formPrabayar,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: _isLoading ? Center(child: CircularProgressIndicator()) :  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(
                  "Nomor Meter/ID Pelanggan", 
                  style: new TextStyle(fontSize: 14.0)
                ),

                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _noMeterController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 123456789',
                    errorText: _fieldNoMeter == null || _fieldNoMeter ? null : "Kolom Nomor Meter harus diisi",
                  ),
                  style: new TextStyle(fontSize:  14.0),
                  onChanged: (value) {
                    bool isFieldValid = value.trim().isNotEmpty;
                    if (isFieldValid != _fieldNoMeter) {
                      setState(() => _fieldNoMeter = isFieldValid);
                    }
                  },
                ),

                Container( height: 14 ),

                Text(
                  "Nominal Token", 
                  style: new TextStyle(fontSize: 14.0) 
                ),

                // TextField(
                //   controller: _nominalController,
                //   decoration: const InputDecoration(
                //     hintText: 'Contoh: 20000',
                //   ),
                //   style: new TextStyle(fontSize:  14.0)
                // ),

                Container( height: 8 ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new GestureDetector(
                      onTap: (){
                        setState(() {
                          this.press1 = !press1;
                          this.press2 = false;
                          this.press3 = false;
                          this.press4 = false;
                          this.press5 = false;
                          this.press6 = false;
                          this.total= "21.500";
                          this.nominal= 20000;
                        });
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: press1 ? Colors.green : Colors.grey[300], width: 1)
                        ),
                        width: 160,
                        height: 57,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text ("20.000", style: TextStyle(fontSize : 18, color: press1 ? Colors.green : Colors.black)),
                              new Text ("Harga Rp. 21.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
                            ],
                          )
                        )
                      )
                    ),
                    new GestureDetector(
                      onTap: (){
                        setState(() {
                          this.press2 = !press2;
                          this.press1 = false;
                          this.press3 = false;
                          this.press4 = false;
                          this.press5 = false;
                          this.press6 = false;
                          this.total = "51.500";
                          this.nominal = 50000;
                        });
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: press2 ? Colors.green : Colors.grey[300], width: 1)
                        ),
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text ("50.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 18, color: press2 ? Colors.green : Colors.black)),
                              new Text ("Harga Rp. 51.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
                            ],
                          )
                        )
                      )
                    ),
                  ],
                ),

                Container( height: 5 ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new GestureDetector(
                      onTap: (){
                        setState(() {
                          this.press3 = !press3;
                          this.press1 = false;
                          this.press2 = false;
                          this.press4 = false;
                          this.press5 = false;
                          this.press6 = false;
                          this.total= "101.500";
                          this.nominal= 100000;
                        });
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: press3 ? Colors.green : Colors.grey[300], width: 1)
                        ),
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text ("100.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 18, color: press3 ? Colors.green : Colors.black)),
                              new Text ("Harga Rp. 101.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
                            ],
                          )
                        )
                      )
                    ),
                    new GestureDetector(
                      onTap: (){
                        setState(() {
                          this.press4 = !press4;
                          this.press1 = false;
                          this.press2 = false;
                          this.press3 = false;
                          this.press5 = false;
                          this.press6 = false;
                          this.total= "251.500";
                          this.nominal= 250000;
                        });
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: press4 ? Colors.green : Colors.grey[300], width: 1)
                        ),
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text ("250.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 18, color: press4 ? Colors.green : Colors.black)),
                              new Text ("Harga Rp. 251.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
                            ],
                          )
                        )
                      )
                    ),
                  ],
                ),

                Container( height: 5 ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new GestureDetector(
                      onTap: (){
                        setState(() {
                          this.press5 = !press5;
                          this.press1 = false;
                          this.press2 = false;
                          this.press3 = false;
                          this.press4 = false;
                          this.press6 = false;
                          this.total= "501.500";
                          this.nominal= 500000;
                        });
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: press5 ? Colors.green : Colors.grey[300], width: 1)
                        ),
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text ("500.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 18, color: press5 ? Colors.green : Colors.black)),
                              new Text ("Harga Rp. 501.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
                            ],
                          )
                        )
                      )
                    ),
                    new GestureDetector(
                      onTap: (){
                        setState(() {
                          this.press6 = !press6;
                          this.press1 = false;
                          this.press2 = false;
                          this.press3 = false;
                          this.press4 = false;
                          this.press5 = false;
                          this.total= "1.001.500";
                          this.nominal= 1000000;
                        });
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: press6 ? Colors.green : Colors.grey[300], width: 1)
                        ),
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text ("1.000.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 18, color: press6 ? Colors.green : Colors.black)),
                              new Text ("Harga Rp. 1.001.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
                            ],
                          )
                        )
                      )
                    ),
                  ],
                ),

                Container( height: 60 ),

                Divider(
                  height: 12,
                  color: Colors.black,
                ),

                Container(
                  height: 50.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: new Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text ("Total", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
                            press1 || press2 || press3 || press4 || press5 || press6 ? 
                            new Text (NumberFormat.simpleCurrency(locale: 'id').format(total), textAlign: TextAlign.left, style: TextStyle(fontSize : 14, fontWeight: FontWeight.bold)) 
                            : new Text (NumberFormat.simpleCurrency(locale: 'id').format(0), textAlign: TextAlign.left, style: TextStyle(fontSize : 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        child: SizedBox(
                          width : 150,
                          height: 35,
                          child: RaisedButton(
                            child: Text('LANJUT', style: TextStyle(color: Colors.white)),
                            color: Colors.green,
                            onPressed: _onPressed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            )
          ),
        )
      )
    );
  }
}