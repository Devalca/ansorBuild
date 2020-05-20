import 'package:ansor_build/src/model/katalog_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/katalog/katalog_home.dart';
import 'package:ansor_build/src/service/katalog_service.dart';
import 'package:flutter/material.dart';

class KatalogSearchPage extends StatefulWidget {
  @override
  _KatalogSearchPageState createState() => _KatalogSearchPageState();
}

class _KatalogSearchPageState extends State<KatalogSearchPage> {
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
            elevation: 1,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context, true)),
            title: _buildSearchBar()),
        body: Stack(
          children: <Widget>[
            _buildListKatalog(),
          ],
        ));
  }

  Widget _buildSearchBar() {
    final FocusNode _weightFocus = FocusNode();
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 35.0,
              child: TextFormField(
                onFieldSubmitted: (value) {
                  _weightFocus.unfocus();
                  Navigator.pop(context, true);
                },
                textInputAction: TextInputAction.done,
                focusNode: _weightFocus,
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
          ),
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
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? Container() : _buildListBarangItem(index - 1);
          },
          itemCount: _productForDisplay.length + 1,
        ),
      ),
      // _searchBar()
    ]);
  }

  Widget _buildListBarangItem(index) {
    var namaBarang =  _productForDisplay[index].namaProduk;
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => KatalogHomePage(namaBarang)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black38)),
        ),
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
          title: Text(
            _productForDisplay[index].namaProduk,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
