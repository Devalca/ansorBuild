import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DetailKatalogPage extends StatefulWidget {
  final String detNama;
  final String detDes;
  List<String> allPot;
  DetailKatalogPage(
      this.detNama, this.detDes, this.allPot);

  @override
  _DetailKatalogPageState createState() => _DetailKatalogPageState();
}

class _DetailKatalogPageState extends State<DetailKatalogPage> {
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

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
              onPressed: () {
                // setState(() {
                //   _produkImage.clear();
                // });
                Navigator.pop(context, true);
              }),
          actions: [
            InkWell(
              onTap: () => print("object"),
              child: Container(width: 40, child: Icon(Icons.more_vert)),
            ),
          ],
          title: Text(
            'Detail Produk',
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
    List<String> _produkImage = widget.allPot;
    return Column(children: [
      CarouselSlider(
        items: _produkImage.map((imgUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: false,
            aspectRatio: 1.3,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _produkImage.map((url) {
          int index = _produkImage.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
      Divider(
        thickness: 2.0,
        height: 0.1,
      ),
    ]);
  }

  Widget _buildTitleKatalog() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              top: 330.0, left: 16.0, right: 16.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.detNama,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }

  Widget _buildDesKatalog() {
    return Container(
      padding: EdgeInsets.only(top: 380.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Divider(
              thickness: 2.0,
              height: 0.2,
            ),
          ),
          Text(
            "Deskripsi Produk",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(widget.detNama),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(widget.detDes),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(widget.detDes)),
        ],
      ),
    );
  }
}
