import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> homeIklan = [
  'lib/src/assets/produk.jpeg',
  'lib/src/assets/produk.jpeg',
  'lib/src/assets/produk.jpeg',
];

final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(
  homeIklan,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.asset(i, fit: BoxFit.fill, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class DetailKatalogPage extends StatefulWidget {
  @override
  _DetailKatalogPageState createState() => _DetailKatalogPageState();
}

class _DetailKatalogPageState extends State<DetailKatalogPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context, true)),
          actions: [
            InkWell(
              onTap: () => print("object"),
              child: Container(width: 40, child: Icon(Icons.more_vert)),
            ),
          ],
          title: Text(
            'SearchBar Yakin?',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            _buildDesKatalog(),
            _buildTitleKatalog(),
            _buildImageKatalog(),
          ],
        )));
  }

  Widget _buildImageKatalog() {
    return Column(children: [
      CarouselSlider(
        items: child,
        autoPlay: false,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        aspectRatio: 1.2,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(),
            Container(
              child: Row(
                children: map<Widget>(
                  homeIklan,
                  (index, url) {
                    return Container(
                      width: 8.0,
                      height: 10.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Colors.orange
                              : Color.fromRGBO(0, 0, 0, 0.4)),
                    );
                  },
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
      Divider(
        height: 1.0,
      )
    ]);
  }

  Widget _buildTitleKatalog() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              top: 350.0, bottom: 40.0, left: 16.0, right: 16.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nama Barang Dari Katalog",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }

  Widget _buildDesKatalog() {
    return Container(
      padding: EdgeInsets.only(top: 400.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            height: 0.1,
          ),
          Text(
            "Deskripsi Produk",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text("Sepatu kulit asli cibadayut \nTipe C786876"),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
                "Quality Premium made in cibaduyut \nsize tersedia 34-39 \nkelengkapan : spatu + BOX BINB"),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                  "Barang dijamin sesuai dengan gambar \nreal pic 100% jika barang tidak seusia gambar")),
        ],
      ),
    );
  }
}
