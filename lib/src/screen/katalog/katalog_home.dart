import 'package:flutter/material.dart';

class KatalogHomePage extends StatefulWidget {
  @override
  _KatalogHomePageState createState() => _KatalogHomePageState();
}

class _KatalogHomePageState extends State<KatalogHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: Center(
          child: Text("Katalog Home Page"),
        ),
      ),
    );
  }
}