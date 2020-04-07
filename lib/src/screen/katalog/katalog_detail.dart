import 'package:flutter/material.dart';

class DetailKatalogPage extends StatefulWidget {
  @override
  _DetailKatalogPageState createState() => _DetailKatalogPageState();
}

class _DetailKatalogPageState extends State<DetailKatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detail "Nama Barang"'),
      ),
      body: Center(
        child: Text('Detail "Nama Barang"'),
      ),
    );
  }
}