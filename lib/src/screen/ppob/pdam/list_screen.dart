import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/ppob/pdam/pdam_screen.dart';
import 'package:ansor_build/src/service/pdam_service.dart';
import 'package:flutter/material.dart';

class ListWilayah extends StatefulWidget {
  @override
  _ListWilayahState createState() => _ListWilayahState();
}

class _ListWilayahState extends State<ListWilayah> {
  String namaKotaKab;
  PdamService _pdamService = PdamService();
  List<Wilayah> _wilayah = List<Wilayah>();
  List<Wilayah> _wilayahForDisplay = List<Wilayah>();

  @override
  void initState() {
    _pdamService.getWilayah().then((value) {
      setState(() {
        _wilayah.addAll(value.data);
        _wilayahForDisplay = _wilayah;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PdamPage(namaKotaKab == null ? "Pilih Daerah" : namaKotaKab)));
              }),
          backgroundColor: Colors.white,
          title: Text(
            'Pilih Kota',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: <Widget>[
            _buildFieldKota(),
            _buildSearchBar()
          ],
        ));
  }

  Widget _buildFieldKota() {
    return FutureBuilder<NamaWilayah>(
          future: _pdamService.getWilayah(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text("Koneksi Terputus"),);
              case ConnectionState.waiting:
                return centerLoading();
              default:
                if (snapshot.hasData) {
                  return Stack(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 65.0),
                      color: Colors.white,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Container()
                              : _buildListKota(index - 1);
                        },
                        itemCount: _wilayahForDisplay.length + 1,
                      ),
                    ),
                    // _searchBar()
                  ]);
                } else {
                  return Text('Result: ${snapshot.error}');
                }
            }
          },
        );
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
            _wilayahForDisplay = _wilayah.where((kota) {
              var kotaTitle = kota.namaWilayah.toLowerCase();
              return kotaTitle.contains(text);
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

  Widget _buildListKota(index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          namaKotaKab = _wilayahForDisplay[index].namaWilayah.toString();
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PdamPage(namaKotaKab)));
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
            _wilayahForDisplay[index].namaWilayah,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
