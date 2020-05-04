import 'package:ansor_build/src/model/katalog_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/katalog/katalog_detail.dart';
import 'package:ansor_build/src/service/katalog_service.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class KatalogHomePage extends StatefulWidget {
  @override
  _KatalogHomePageState createState() => _KatalogHomePageState();
}

class _KatalogHomePageState extends State<KatalogHomePage> {
  bool filter1 = true;
  bool filter2 = false;
  bool filter3 = false;
  bool filter4 = false;
  KatalogService _katalogService = KatalogService();
  List<DataKatalog> _dataKatalog = List<DataKatalog>();
  List<DataKatalog> _dataKatalogsForDisplay = List<DataKatalog>();
  List<Product> _product = List<Product>();
  List<Product> _productForDisplay = List<Product>();

  @override
  void initState() {
    _katalogService.getKatalog().then((value) {
      setState(() {
        _dataKatalog.addAll(value.data);
        _dataKatalogsForDisplay = _dataKatalog;
        for (int i = 0; i < _dataKatalogsForDisplay.length; i++) {
          setState(() {
            _product.addAll(_dataKatalogsForDisplay[i].products);
            _productForDisplay = _product;
          });
        }
      });
    });
    super.initState();
  }

  _filSemua() {
     setState(() {
      _productForDisplay.sort((a, b) {
        return b.namaProduk.length.compareTo(a.namaProduk.length);
      });
    });
  }

  _filTerbaru() {
    setState(() {
      _productForDisplay.sort((a, b) {
        return b.produkId.compareTo(a.produkId);
      });
    });
  }

    _filTerpopuler() {
    setState(() {
      _productForDisplay.sort((a, b) {
        return b.priorityId.compareTo(a.priorityId);
      });
    });
  }

  _filSale() {
    setState(() {
      _productForDisplay.sort((a, b) {
        return a.hargaProduk.compareTo(b.hargaProduk);
      });
    });
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
              onPressed: () => Navigator.pop(context, true)),
          title: Text(
            'Produk Daerah',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: <Widget>[
            _buildListKatalog(),
            _buildTabButton(),
            _buildSearchBar()
          ],
        ));
  }

  Widget _buildTabButton() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: Container(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            width: 3.0,
                            color: filter1 ? Colors.green : Colors.white))),
                width: 100.0,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _filSemua();
                        if (filter1 == false) {
                          this.filter1 = !filter1;
                          this.filter2 = false;
                          this.filter3 = false;
                          this.filter4 = false;
                        }
                      });
                    },
                    child: Text("Semua"))),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            width: 3.0,
                            color: filter2 ? Colors.green : Colors.white))),
                width: 100.0,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _filTerbaru();
                        if (filter2 == true) {
                          filter1 = false;
                          filter3 = false;
                          filter4 = false;
                        } else {
                          this.filter2 = !filter2;
                          filter1 = false;
                          filter3 = false;
                          filter4 = false;
                        }
                      });
                    },
                    child: Text("Terbaru"))),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            width: 3.0,
                            color: filter3 ? Colors.green : Colors.white))),
                width: 100.0,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _filTerpopuler();
                        if (filter3 == true) {
                          filter1 = false;
                          filter2 = false;
                          filter4 = false;
                        } else {
                          this.filter3 = !filter3;
                          filter2 = false;
                          filter1 = false;
                          filter4 = false;
                        }
                      });
                    },
                    child: Text("Terpopuler"))),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            width: 3.0,
                            color: filter4 ? Colors.green : Colors.white))),
                width: 100.0,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _filSale();
                        if (filter4 == true) {
                          filter1 = false;
                          filter2 = false;
                          filter3 = false;
                        } else {
                          this.filter4 = !filter4;
                          filter3 = false;
                          filter2 = false;
                          filter1 = false;
                        }
                      });
                    },
                    child: Text("Sale!"))),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: TextField(
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  _productForDisplay = _product.where((katalog) {
                    var barTitle = katalog.namaProduk.toLowerCase();
                    return barTitle.contains(text);
                  }).toList();
                });
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
          Expanded(
              flex: 1,
              child: IconButton(icon: Icon(Icons.menu), onPressed: null))
        ],
      ),
    );
  }

  Widget _buildListKatalog() {
    return FutureBuilder<Katalog>(
      future: _katalogService.getKatalog(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text("Koneksi Terputus"),
            );
          case ConnectionState.waiting:
            return centerLoading();
          default:
            if (snapshot.hasData) {
              return _buildListBarang(_productForDisplay);
            } else {
              return Text('Result: ${snapshot.error}');
            }
        }
      },
    );
  }

  Widget _buildListBarang(_productForDisplay) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.6;
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 95.0, left: 15.0, right: 15.0),
        color: Colors.white,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: (itemWidth / itemHeight),
          ),
          itemBuilder: (context, index) {
            return index == -1 ? Container() : _buildListBarangItem(index);
          },
          itemCount: _productForDisplay.length,
        ),
      ),
      // _searchBar()
    ]);
  }

  Widget _buildListBarangItem(index) {
    var detNama = _productForDisplay[index].namaProduk;
    var detDes = _productForDisplay[index].deskripsiProduk;
    var detPot1 = _productForDisplay[index].photos[0].photo;
    var detPot2 = _productForDisplay[index].photos[1].photo;
    List<String> allPot = [detPot1, detPot2];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailKatalogPage(detNama, detDes, allPot)));
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              child: FadeInImage.assetNetwork(
                  placeholder: 'lib/src/assets/placeholder.jpg',
                  fit: BoxFit.cover,
                  height: 132,
                  width: 300,
                  image: _productForDisplay[index].photos[0].photo),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: <Widget>[
                        Text(_productForDisplay[index].namaProduk),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
