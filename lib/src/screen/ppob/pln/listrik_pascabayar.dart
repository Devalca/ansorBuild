import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pembayaran.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/model/pln_model.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

Future<Bayar> createPascabayar(String noMeter) async {
  final http.Response response = await http.post(
    'http://192.168.10.11:3000/ppob/pln/pascabayar',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'no_meter': noMeter,
    }),
  );
  if (response.statusCode == 200) {
    return Bayar.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Bayar {
  final int transactionId;
  final String noMeter;
  final String status;

  Bayar({this.transactionId, this.noMeter, this.status});

  factory Bayar.fromJson(Map<String, dynamic> json) {
    return Bayar(
      transactionId: json['transactionId'],
      noMeter: json['no_meter'],
      status: json['status']
    );
  }
}

class ListrikPascabayar extends StatefulWidget {
  @override
  _ListrikPascabayarState createState() => _ListrikPascabayarState();
}

class _ListrikPascabayarState extends State<ListrikPascabayar> {
  String id = "";
  String transId = "0";
  String text_to_show = "";
  bool _fieldNoMeter;
  PlnServices _plnServices = PlnServices();
  String url = "";

  @override
  void initState() {
    super.initState();
    getId();
  }

  getId() async{

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      id = prefs.getString('id');
    });
  }
  
  TextEditingController _noMeterController = TextEditingController();
  Future<Bayar> _futureBayar;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
            child: _isLoading ? Center(child: CircularProgressIndicator()) :  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  child: Text(
                    "Nomor Meter/ID Pelanggan", 
                    style: new TextStyle(fontSize: 14.0), 
                    textAlign: TextAlign.left
                  )
                ),

                TextField(
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

                Container( height: 15 ),

                Container(
                  padding: const EdgeInsets.all((10.0)),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0)
                    )
                  ),
                  width: double.infinity,
                  child: Text(
                    "Keterangan", 
                    style: new TextStyle(fontSize: 14.0)
                  )
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Text(
                    "1. Pembayaran tagihan listrik dapat dilakukan pada pukul 23.45 - 00.30 sesuai dengan ketentuan PLN", 
                    style: new TextStyle(fontSize: 13.0), 
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(10.0),
                      bottomRight: const Radius.circular(10.0)
                    )
                  ),
                  width: double.infinity,
                  child: Text(
                    "2. Total tagihan listrik yang tertera sudah termasuk denda (bila ada)", 
                    style: new TextStyle(fontSize: 13.0), 
                    textAlign: TextAlign.left
                  )
                ),

                Container( height: 200 ),

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

                      if(_noMeterController.text.isEmpty){
                        setState(() {
                          _isLoading = false; 
                          _fieldNoMeter = false; 
                        });
                      }else{
                        String noMeter = _noMeterController.text.toString();

                        PostPascabayar pascabayar = PostPascabayar(noMeter: noMeter, userId: 1, walletId: 1);

                        _plnServices.postPascabayar(pascabayar).then((response) async {
                          if (response.statusCode == 302){
                            print("berhasil body: " + response.body);
                            print(response.statusCode);

                            url = response.headers['location'];
                            print("url: " + url);
                            print('dataUrl' + url);

                            _plnServices.saveTransactionId(url).then((bool committed) {
                              print(url);
                            });

                            Navigator.push(context, new MaterialPageRoute(builder: (__) => new ListrikPembayaran(status: "pascabayar")));
                            setState(() => _isLoading = false);

                          }else if(response.statusCode == 200) {
                            print("berhasil body: " + response.body);
                            print(response.statusCode);

                            Map data = jsonDecode(response.body);
                            transactionId = data['transactionId'].toString();
                            print("transactionId: " + transactionId);
                            
                            url = '/ppob/pln/' + transactionId;
                            print("url: " + url);

                            _plnServices.saveTransactionId(url).then((bool committed) {
                              print(url);
                            });
                
                            Navigator.push(context, new MaterialPageRoute(builder: (__) => new ListrikPembayaran(status: "pascabayar")));
                            setState(() => _isLoading = false);
                          } else {
                            print("error: " + response.body);
                            print(response.statusCode);
                          }
                        });
                      }

                      // PostResult.connectToAPI(_noMeterController.text).then((value){
                      //   postResult = value;
                      //   setState((){});
                      // });

                      // setState(() {
                      //   _futureBayar = createPascabayar(_noMeterController.text);
                      // });

                      // Navigator.of(context)
                      //   .push(MaterialPageRoute(builder: (_) => ListrikPembayaran()));

                      // if (transId != null) {
                      //   Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (_) => ListrikPembayaran()));
                      // }else{
                        
                      // }
                    },
                  ),
                ),

                Container( height: 8 ),

                // FutureBuilder<Bayar>(
                //   future: _futureBayar,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       saveData(snapshot.data.transactionId.toString());

                //       Navigator.of(context)
                //           .push(MaterialPageRoute(builder: (_) => ListrikPembayaran()));

                //       // return Text(snapshot.data.transactionId.toString());
                //       // setState(() {
                //       //   transId = snapshot.data.transactionId.toString();
                //       // });
                //     } else if (snapshot.hasError) {
                //       return Text("${snapshot.error}");
                //     }
                //     return Text("");
                //     // return CircularProgressIndicator();
                //     // return null;
                //   },
                // ),
                
                Container( height: 8 ),

                // RaisedButton(onPressed:()=> readData("transactionId"), child: Text('Read Data')),
                // Text('$text_to_show'),
                
                // SizedBox(
                //   width :double.infinity,
                //   height: 35,
                //   child: RaisedButton(
                //     child: Text('LANJUT', style: TextStyle(color: Colors.white)),
                //     color: Colors.green,
                //     onPressed: () async{
                //       print(_noMeterController.text);

                //       setState(() {
                //         _isLoading = false;
                //       });

                //       final pascabayar = PascaBayarInsert(
                //         noMeter: _noMeterController.text, 
                //       );
                //       final result = await pascabayarService.createPascabayar(pascabayar);
                        
                //       setState(() {
                //         _isLoading = false;
                //       });

                //       final title = "Done";
                //       final text = result.error ? (result.errorMessage ?? 'An error occurred') : "Data was inserted";

                //       showDialog(
                //         context: context,
                //         builder: (_) => AlertDialog(
                //           title: Text(title),
                //           content: Text(text),
                //           actions: <Widget>[
                //             FlatButton(
                //               child: Text('OK'),
                //               onPressed: () {
                //                 Navigator.push(
                //                   // Navigator.of(context).pop();
                //                   context, MaterialPageRoute(builder: (context) => ListrikPembayaran())
                //                 );
                //               },
                //             )
                //           ],
                //         )
                //       )
                //       .then((data) {
                //         if (result.data) {
                //           Navigator.of(context).pop();
                //         }
                //       });
                //     },
                //   ),
                // ),
              ]
            )
          )

          // : FutureBuilder<Bayar>(
          //     future: _futureBayar,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return next(snapshot.data.transactionId.toString());
          //         // Navigator.of(context)
          //         //   .push(MaterialPageRoute(builder: (context) => ListrikPembayaran(transactionId: '10')));
          //       } else if (snapshot.hasError) {
          //         return Text("${snapshot.error}");
          //       }
          //       return CircularProgressIndicator();
          //     },
          //   ),
      )
    );
  }

  saveData(String id) async {
    final prefs = await SharedPreferences.getInstance();
    
    prefs.setString("transactionId", id);
  }

  readData(String text) async{
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      text_to_show = prefs.getString(text);
    });
  }
}