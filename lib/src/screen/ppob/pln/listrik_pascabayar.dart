import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ansor_build/src/model/pln/pascabayar.dart';
import 'package:ansor_build/src/model/pln/pascabayar_insert.dart';
import 'package:ansor_build/src/service/pln/pascabayar_services.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik_pembayaran.dart';

class ListrikPascabayar extends StatefulWidget {
  @override
  _ListrikPascabayarState createState() => _ListrikPascabayarState();
}

class _ListrikPascabayarState extends State<ListrikPascabayar> {
  PascaBayarServices get pascabayarService => GetIt.I<PascaBayarServices>();
  
  String errorMessage;
  PascaBayar pascabayar;

  TextEditingController _noMeterController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              decoration: const InputDecoration(
                hintText: 'Contoh: 123456789',
              ),
              style: new TextStyle(fontSize:  14.0)
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
            
            Container( height: 8 ),
            
            SizedBox(
              width :double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('LANJUT', style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: () async{
                  print(_noMeterController.text);

                  setState(() {
                    _isLoading = false;
                  });

                  final pascabayar = PascaBayarInsert(
                    noMeter: _noMeterController.text, 
                  );
                  final result = await pascabayarService.createPascabayar(pascabayar);
                    
                  setState(() {
                    _isLoading = false;
                  });

                  final title = result.data.toString();
                  final text = result.error ? (result.errorMessage ?? 'An error occurred') : result.data;

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(title),
                      content: Text(text),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.push(
                              // Navigator.of(context).pop();
                              context, MaterialPageRoute(builder: (context) => ListrikPembayaran())
                            );
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