import 'package:ansor_build/src/model/katalog_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/service/katalog_service.dart';
import 'package:flutter/material.dart';

class KatalogHomePage extends StatefulWidget {
  @override
  _KatalogHomePageState createState() => _KatalogHomePageState();
}

class _KatalogHomePageState extends State<KatalogHomePage> {
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
          children: <Widget>[_buildListKatalog(), _buildSearchBar()],
        ));
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
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
            hintText: "Cari Kota atau Kabupaten",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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
              print(_productForDisplay);
              return _buildListBarang(_productForDisplay);
            } else {
              return Text('Result: ${snapshot.error}');
            }
        }
      },
    );
  }

  Widget _buildListBarang(_productForDisplay) {
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 105.0),
        color: Colors.white,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return index == -1
                ? Container()
                : _buildListBarangItem(index);
          },
          itemCount: _productForDisplay.length,
        ),
      ),
      // _searchBar()
    ]);
  }

  Widget _buildListBarangItem(index) {
    return GestureDetector(
      onTap: () {
        print("INI Barang");
      },
       child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: 132.0,
                      height: 132.0,
                      child: FadeInImage.assetNetwork(
                          placeholder: 'lib/src/assets/placeholder.jpg',
                          fit: BoxFit.fill,
                          image: _productForDisplay[index].photos[0].photo),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Text(_productForDisplay[index].namaProduk),
        ],
      ),
    ),
    );
  }
}
