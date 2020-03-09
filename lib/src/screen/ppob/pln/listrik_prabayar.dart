import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/model/pln_model.dart';
import 'package:ansor_build/src/service/pln_services.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pembayaran.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class ListrikPrabayar extends StatefulWidget {
  @override
    _ListrikPrabayarState createState() => _ListrikPrabayarState();
  }

class _ListrikPrabayarState extends State<ListrikPrabayar> {
  bool _fieldNoMeter;
  PlnServices _plnServices = PlnServices();
  String url = "";
  String total = "";
  bool press = true;
  
  TextEditingController _noMeterController = TextEditingController();
  TextEditingController _nominalController = TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var _onPressed;
    if (press){
      _onPressed = (){
        setState(() => _isLoading = true);

        String noMeter = _noMeterController.text.toString();
        String nominal = _nominalController.text.toString();

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
      };
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _isLoading ? Center(child: CircularProgressIndicator()) :  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(
                "Nomor Meter/ID Pelanggan", 
                style: new TextStyle(fontSize: 14.0)
              ),

              TextField(
                controller: _noMeterController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Contoh: 123456789',
                  // errorText: _fieldNoMeter == null || _fieldNoMeter ? null : "Kolom Nommor Meter harus diisi",
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

              TextField(
                controller: _nominalController,
                decoration: const InputDecoration(
                  hintText: 'Contoh: 20000',
                ),
                style: new TextStyle(fontSize:  14.0)
              ),

              Container( height: 8 ),

              // Container(
              //   height: 50.0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       new GestureDetector(
              //         onTap: (){
              //           setState(() {
              //             this.press = !press;
              //             this.total= "21.500";
              //           });
              //         },
              //         child: new Container(
              //           decoration: BoxDecoration(
              //             shape: BoxShape.rectangle,
              //             borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              //             border: Border.all(color: press ? Colors.green : Colors.grey[300], width: 1)
              //           ),
              //           width: 160,
              //           height: 60,
              //           padding: const EdgeInsets.all(10.0),
              //           child: new Column(
              //             children: <Widget>[
              //               new Text ("20.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 14, color: press ? Colors.green : Colors.black)),
              //               new Text ("Harga Rp. 21.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
              //             ],
              //           )
              //         )
              //       ),
              //       new GestureDetector(
              //         onTap: (){
              //           setState(() {
              //             this.press = !press;
              //             this.total= "51.500";
              //           });
              //         },
              //         child: new Container(
              //           decoration: BoxDecoration(
              //             shape: BoxShape.rectangle,
              //             borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              //             border: Border.all(color: press ? Colors.green : Colors.grey[300], width: 1)
              //           ),
              //           width: 160,
              //           height: 60,
              //           padding: const EdgeInsets.all(10.0),
              //           child: new Column(
              //             children: <Widget>[
              //               new Text ("50.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 14, color: press ? Colors.green : Colors.black)),
              //               new Text ("Harga Rp. 51.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
              //             ],
              //           )
              //         )
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //           shape: BoxShape.rectangle,
              //           borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              //           border: Border.all(color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.grey[300], width: 1)
              //         ),
              //         child: SizedBox(
              //           width: 160,
              //           child: RaisedButton(
              //             padding: const EdgeInsets.all(10.0),
              //             color: Colors.white,
              //             child: new Column (
              //               children: <Widget>[
              //                 new Text ("20.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 14, color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.black)),
              //                 new Text ("Harga Rp. 21.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
              //               ],
              //             ),
              //             onPressed: () {
              //               setState(() {
              //                 this.press = !press;
              //                 this.total= "21.500";
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //           shape: BoxShape.rectangle,
              //           borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              //           border: Border.all(color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.grey[300], width: 1)
              //         ),
              //         child: SizedBox(
              //           width: 160,
              //           child: RaisedButton(
              //             padding: const EdgeInsets.all(10.0),
              //             color: Colors.white,
              //             child: new Column (
              //               children: <Widget>[
              //                 new Text ("50.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 14, color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.black)),
              //                 new Text ("Harga Rp. 51.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
              //               ],
              //             ),
              //             onPressed: () {
              //               setState(() {
              //                 this.press = !press;
              //                 this.total= "51.500";
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Container( height: 8 ),

              // Container(
              //   height: 50.0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Container(
              //         decoration: BoxDecoration(
              //           shape: BoxShape.rectangle,
              //           borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              //           border: Border.all(color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.grey[300], width: 1)
              //         ),
              //         child: SizedBox(
              //           width: 160,
              //           child: RaisedButton(
              //             padding: const EdgeInsets.all(10.0),
              //             color: Colors.white,
              //             child: new Column (
              //               children: <Widget>[
              //                 new Text ("100.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 14, color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.black)),
              //                 new Text ("Harga Rp. 101.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
              //               ],
              //             ),
              //             onPressed: () {
              //               setState(() {
              //                 this.press = !press;
              //                 this.total= "101.500";
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //           shape: BoxShape.rectangle,
              //           borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              //           border: Border.all(color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.grey[300], width: 1)
              //         ),
              //         child: SizedBox(
              //           width: 160,
              //           child: RaisedButton(
              //             padding: const EdgeInsets.all(10.0),
              //             color: Colors.white,
              //             child: new Column (
              //               children: <Widget>[
              //                 new Text ("250.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 14, color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.black)),
              //                 new Text ("Harga Rp. 251.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
              //               ],
              //             ),
              //             onPressed: () {
              //               setState(() {
              //                 this.press = !press;
              //                 this.total= "201.500";
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Container( height: 8 ),

              // Container(
              //   height: 50.0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Container(
              //         decoration: BoxDecoration(
              //           shape: BoxShape.rectangle,
              //           borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              //           border: Border.all(color: press ? Color.fromARGB(1, 0, 128, 0) : Colors.grey[300], width: 1)
              //         ),
              //         child: SizedBox(
              //           width: 160,
              //           child: RaisedButton(
              //             padding: const EdgeInsets.all(10.0),
              //             color: Colors.white,
              //             child: new Column (
              //               children: <Widget>[
              //                 new Text ("500.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 14, color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.black)),
              //                 new Text ("Harga Rp. 501.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
              //               ],
              //             ),
              //             onPressed: () {
              //               setState(() {
              //                 this.press = !press;
              //                 this.total= "501.500";
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //           shape: BoxShape.rectangle,
              //           borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              //           border: Border.all(color: press ? Color.fromARGB(1, 0, 128, 0) : Colors.grey[300], width: 1)
              //         ),
              //         child: SizedBox(
              //           width: 160,
              //           child: RaisedButton(
              //             padding: const EdgeInsets.all(10.0),
              //             color: Colors.white,
              //             child: new Column (
              //               children: <Widget>[
              //                 new Text ("1.000.000", textAlign: TextAlign.left, style: TextStyle(fontSize : 14, color: press ? Color.fromARGB(1, 11, 156, 49) : Colors.black)),
              //                 new Text ("Harga Rp. 1.001.500", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
              //               ],
              //             ),
              //             onPressed: () {
              //               setState(() {
              //                 this.press = !press;
              //                 this.total= "1.001.500";
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Container( height: 8 ),

              Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: new Column (
                        children: <Widget>[
                          // new Text ("Total", textAlign: TextAlign.left, style: TextStyle(fontSize : 12)),
                          // new Text ("Rp. " + total, textAlign: TextAlign.left, style: TextStyle(fontSize : 14, fontWeight: FontWeight.bold)),
                          new Text ("", textAlign: TextAlign.left, style: TextStyle(fontSize : 12))
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

                          // onPressed: () {
                          //   PostResult.connectToAPI(_noMeterController.text).then((value){
                          //     postResult = value;
                          //     setState((){});
                          //   });

                          //   setState(() {
                          //     _futureBayar = createPascabayar(_noMeterController.text);
                          //   });

                          //   Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (_) => ListrikPembayaran()));

                          //   if (transId != null) {
                          //     Navigator.of(context)
                          //       .push(MaterialPageRoute(builder: (_) => ListrikPembayaran()));
                          //   }else{
                              
                          //   }
                          // },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container( height: 8 ),

              // Container(
              //   height: 50.0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Container(
              //         child: SizedBox(
              //           width: 150,
              //           height: 35,
              //           child: RaisedButton(
              //             child: Text(
              //               '20.000', 
              //               style: TextStyle(color: Colors.black)
              //             ),
              //             color: Colors.white,
              //             onPressed: () async{
              //               print("clicked");
              //             },
              //           ),
              //         ),
              //       ),
              //       Container(
              //         child: SizedBox(
              //           width: 150,
              //           height: 35,
              //           child: RaisedButton(
              //             child: Text(
              //               '50.000', 
              //               style: TextStyle(color: Colors.black)
              //             ),
              //             color: Colors.white,
              //             onPressed: () async{
              //               print("clicked");
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // Container(
              //   height: 50.0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Container(
              //         child: SizedBox(
              //           width: 150,
              //           height: 35,
              //           child: RaisedButton(
              //             child: Text(
              //               '100.000', 
              //               style: TextStyle(color: Colors.black)
              //             ),
              //             color: Colors.white,
              //             onPressed: () async{
              //               print("clicked");
              //             },
              //           ),
              //         ),
              //       ),
              //       Container(
              //         child: SizedBox(
              //           width: 150,
              //           height: 35,
              //           child: RaisedButton(
              //             child: Text(
              //               '250.000', 
              //               style: TextStyle(color: Colors.black)
              //             ),
              //             color: Colors.white,
              //             onPressed: () async{
              //               print("clicked");
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // Container(
              //   height: 50.0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Container(
              //         child: SizedBox(
              //           width: 150,
              //           height: 35,
              //           child: RaisedButton(
              //             child: Text(
              //               '500.000', 
              //               style: TextStyle(color: Colors.black)
              //             ),
              //             color: Colors.white,
              //             onPressed: () async{
              //               print("clicked");
              //             },
              //           ),
              //         ),
              //       ),
              //       Container(
              //         child: SizedBox(
              //           width: 150,
              //           height: 35,
              //           child: RaisedButton(
              //             child: Text(
              //               '1.000.000', 
              //               style: TextStyle(color: Colors.black)
              //             ),
              //             color: Colors.white,
              //             onPressed: () async{
              //               print("clicked");
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // SizedBox(
              //   width :double.infinity,
              //   height: 35,
              //   child: RaisedButton(
              //     child: Text(
              //       'BELI', 
              //       style: TextStyle(color: Colors.white)
              //     ),
              //     color: Colors.green,
              //     onPressed: () async{
              //       print(_noMeterController.text);
              //       print(_nominalController.text);

              //       setState(() {
              //         _isLoading = false;
              //       });

              //       final prabayar = PrabayarInsert(
              //         noMeter: _noMeterController.text, 
              //         nominal: int.parse(_nominalController.text)
              //       );
              //       final result = await prabayarService.createPrabayar(prabayar);
                    
              //       setState(() {
              //         _isLoading = false;
              //       });

              //       final title = 'Done';
              //       final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your data was inserted';

              //       showDialog(
              //         context: context,
              //         builder: (_) => AlertDialog(
              //           title: Text(title),
              //           content: Text(text),
              //           actions: <Widget>[
              //             FlatButton(
              //               child: Text('OK'),
              //               onPressed: () {
              //                 Navigator.of(context).pop();
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
        ),
      )
    );
  }
}