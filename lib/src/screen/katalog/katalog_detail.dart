import 'package:ansor_build/src/model/katalog_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/katalog/katalog_serach.dart';
import 'package:ansor_build/src/service/katalog_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// final List<String> _produkImage = [
//   'lib/src/assets/BANNER_PULSA.jpg',
//   'lib/src/assets/BANNER_PULSA.jpg',
//   'lib/src/assets/BANNER_PULSA.jpg'
// ];

class DetailKatalogPage extends StatefulWidget {
  final String detNama;
  final String detDes;
  List<String> allPot;
  DetailKatalogPage(this.detNama, this.detDes, this.allPot);

  @override
  _DetailKatalogPageState createState() => _DetailKatalogPageState();
}

class _DetailKatalogPageState extends State<DetailKatalogPage> {
  int _current = 0;
  KatalogService _katalogService = KatalogService();
  List<DataKatalog> _dataKatalog = List<DataKatalog>();
  List<DataKatalog> _dataKatalogsForDisplay = List<DataKatalog>();
  List<Product> _product = List<Product>();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    _katalogService.getKatalog().then((value) {
      setState(() {
        _dataKatalog.addAll(value.data);
        _dataKatalogsForDisplay = _dataKatalog;
        for (int i = 0; i < _dataKatalogsForDisplay.length; i++) {
          setState(() {
            _product.addAll(_dataKatalogsForDisplay[i].products);
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 1,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
            actions: [
              InkWell(
                onTap: () => underDialog(context),
                child: Container(width: 40, child: Icon(Icons.more_vert)),
              ),
            ],
            title: _buildSearchBar()),
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            _buildImageKatalog(),
          ],
        )));
  }

  Widget _buildSearchBar() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            height: 37,
            child: TextField(
              readOnly: true,
              onChanged: (text) {
                text = text.toLowerCase();
              },
              decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: "Cari apa saja?",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => KatalogSearchPage()));
          },
          child: Container(
            height: 50.0,
            width: 300.0,
          ),
        ),
      ],
    );
  }

  Widget _buildImageKatalog() {
    List<String> _produkImage = widget.allPot;
    return Container(
      padding: EdgeInsets.only(top: 12.0),
      child: Column(children: [
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
        _buildTitleKatalog()
      ]),
    );
  }

  Widget _buildTitleKatalog() {
    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Divider(
            thickness: 2.0,
            height: 0.1,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 26.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.detNama,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                )),
          ),
          Container(
            child: Divider(
              thickness: 2.0,
              height: 0.2,
            ),
          ),
          _buildDesKatalog(),
        ],
      ),
    );
  }

  Widget _buildDesKatalog() {
    return Container(
      padding: EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Deskripsi Produk",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(widget.detNama),
          ),
          Container(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(widget.detDes),
          ),
          Container(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(widget.detDes)),
        ],
      ),
    );
  }
}
