import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ansor_build/src/model/pln/prabayar.dart';
import 'package:ansor_build/src/model/pln/prabayar_insert.dart';
import 'package:ansor_build/src/service/pln/prabayar_services.dart';

class ListrikPrabayar extends StatefulWidget {
  @override
    _ListrikPrabayarState createState() => _ListrikPrabayarState();
  }

class _ListrikPrabayarState extends State<ListrikPrabayar> {
  PrabayarServices get prabayarService => GetIt.I<PrabayarServices>();
  
  String errorMessage;
  Prabayar prabayar;
  
  TextEditingController _noMeterController = TextEditingController();
  TextEditingController _nominalController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              decoration: const InputDecoration(
                hintText: 'Contoh: 123456789',
              ),
              style: new TextStyle(fontSize:  14.0)
            ),

            Container( height: 14 ),

            Text(
              "Nominal Token", 
              style: new TextStyle(fontSize: 14.0), 
            ),

            TextField(
              controller: _nominalController,
              decoration: const InputDecoration(
                hintText: 'Contoh: 20000',
              ),
              style: new TextStyle(fontSize:  14.0)
            ),

            Container( height: 8 ),

            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: SizedBox(
                      width: 150,
                      height: 35,
                      child: RaisedButton(
                        child: Text(
                          '20.000', 
                          style: TextStyle(color: Colors.black)
                        ),
                        color: Colors.white,
                        onPressed: () async{
                          print("clicked");
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      width: 150,
                      height: 35,
                      child: RaisedButton(
                        child: Text(
                          '50.000', 
                          style: TextStyle(color: Colors.black)
                        ),
                        color: Colors.white,
                        onPressed: () async{
                          print("clicked");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: SizedBox(
                      width: 150,
                      height: 35,
                      child: RaisedButton(
                        child: Text(
                          '100.000', 
                          style: TextStyle(color: Colors.black)
                        ),
                        color: Colors.white,
                        onPressed: () async{
                          print("clicked");
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      width: 150,
                      height: 35,
                      child: RaisedButton(
                        child: Text(
                          '250.000', 
                          style: TextStyle(color: Colors.black)
                        ),
                        color: Colors.white,
                        onPressed: () async{
                          print("clicked");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: SizedBox(
                      width: 150,
                      height: 35,
                      child: RaisedButton(
                        child: Text(
                          '500.000', 
                          style: TextStyle(color: Colors.black)
                        ),
                        color: Colors.white,
                        onPressed: () async{
                          print("clicked");
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      width: 150,
                      height: 35,
                      child: RaisedButton(
                        child: Text(
                          '1.000.000', 
                          style: TextStyle(color: Colors.black)
                        ),
                        color: Colors.white,
                        onPressed: () async{
                          print("clicked");
                        },
                      ),
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
                child: Text(
                  'BELI', 
                  style: TextStyle(color: Colors.white)
                ),
                color: Colors.green,
                onPressed: () async{
                  print(_noMeterController.text);
                  print(_nominalController.text);

                  setState(() {
                    _isLoading = false;
                  });

                  final prabayar = PrabayarInsert(
                    noMeter: _noMeterController.text, 
                    nominal: int.parse(_nominalController.text)
                  );
                  final result = await prabayarService.createPrabayar(prabayar);
                  
                  setState(() {
                    _isLoading = false;
                  });

                  final title = 'Done';
                  final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your data was inserted';

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(title),
                      content: Text(text),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    )
                  )
                  .then((data) {
                    if (result.data) {
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
            ),
          ]
        )
      ),
    );
  }
}