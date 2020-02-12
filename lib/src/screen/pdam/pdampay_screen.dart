import 'package:flutter/material.dart';

class PdamPayPage extends StatefulWidget {
  @override
  _PdamPayPageState createState() => _PdamPayPageState();
}

class _PdamPayPageState extends State<PdamPayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(Icons.branding_watermark),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text('Air PDAM Kota Bandung'),
                              Text('Nomor 1234567890'),
                              Text('Toxic - 1234567890')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}