import 'package:ansor_build/src/model/branda_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/component/iklan_home.dart';
import 'package:ansor_build/src/screen/component/iklan_kecil.dart';
import 'package:ansor_build/src/screen/component/saldo_appbar.dart';
import 'package:ansor_build/src/screen/ppob/pdam/pdam_screen.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/main_pulsa.dart';
import 'package:ansor_build/src/screen/topup/topup_screen.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:ansor_build/src/service/beranda_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  ApiService _apiService = ApiService();
  BerandaService _berandaService = BerandaService();
  final cF = NumberFormat.currency(locale: 'ID');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return SafeArea(
      child: Scaffold(
        appBar: SaldoAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _buildSaldoForm(),
                _buildIklanOne(),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Layanan Islami'),
                      ),
                      Container(
                        child: _buildServiceIslamic(),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Pembayaran'),
                      ),
                      Container(
                        child: _buildServicePembayaran(),
                      ),
                    ],
                  ),
                ),
                _buildIklanTwo(),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text('Produk Daerah'),
                            ),
                            Container(
                              child: Text(
                                'Lihat Semuanya',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildBarangService()
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text('Produk National'),
                            ),
                            Container(
                              child: Text('Lihat Semuanya',
                                  style: TextStyle(color: Colors.green)),
                            ),
                          ],
                        ),
                      ),
                      _buildBarangService()
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: Text('Donasi'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.grey[200])),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child:
                                  Image.asset('lib/src/assets/BANNER_ATAS.jpg'),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text('Donasi Ansor'),
                                  ),
                                  Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          border: Border.all(
                                              width: 1, color: Colors.green),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: FlatButton(
                                          onPressed: null,
                                          child: Text(
                                            'Donasi',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // KUMPULAN WIDGET UNTUK HOME PAGE

  Widget _buildSaldoForm() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_balance_wallet, color: Colors.green),
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text("Saldo"),
                  )
                ],
              )),
          Container(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: FutureBuilder<Wallet>(
                    future: _apiService.getSaldo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData)
                          return Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                          rupiah(snapshot
                                                  .data.data[0].saldoAkhir)
                                              .replaceAll("Rp ", "Rp"),
                                          style: TextStyle(fontSize: 24.0)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Text('MOHON TUNGGU...');
                    },
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  _apiService.getSaldo();
                                });
                              }),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TopupPage()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                        width: 1.0, color: Colors.green),
                                    borderRadius: BorderRadius.circular(5.0)),
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'ISI SALDO',
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _buildIklanOne() {
    return InkWell(
      child: Container(
        child: IklanHome(),
      ),
    );
  }

  Widget _buildIklanTwo() {
    return InkWell(
      child: Container(
        child: IklanKecil(),
      ),
    );
  }

  Widget _buildServiceIslamic() {
    return SizedBox(
        width: double.infinity,
        height: 120.0,
        child: Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: FutureBuilder<List>(
              future: _berandaService.fetchIslamService(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _rowIslamService(snapshot.data[index]);
                    },
                  );
                }
                return Center(
                  child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: const CircularProgressIndicator()),
                );
              }),
        ));
  }

  Widget _buildServicePembayaran() {
    return SizedBox(
        width: double.infinity,
        height: 120.0,
        child: Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: FutureBuilder<List>(
              future: _berandaService.fetchPpobService(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _rowPpobService(snapshot.data[index]);
                    },
                  );
                }
                return Center(
                  child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: const CircularProgressIndicator()),
                );
              }),
        ));
  }

  Widget _rowIslamService(IslamService islamService) {
    return InkWell(
      onTap: () {
        if (islamService.title == "ISlam") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PdamPage("")));
        } else {
          print('Under Maintence');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: islamService.image),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
            ),
            Text(islamService.title, style: TextStyle(fontSize: 10.0))
          ],
        ),
      ),
    );
  }

  Widget _rowPpobService(PpobService ppobService) {
    return InkWell(
      onTap: () {
        if (ppobService.title == "PULSA") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPulsa()));
        } else if (ppobService.title == "Listrik PLN") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Listrik()));
        } else if (ppobService.title == "Air PDAM") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PdamPage("")));
        } else {
          print('Under Maintence');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: ppobService.image),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
            ),
            Text(ppobService.title, style: TextStyle(fontSize: 10.0))
          ],
        ),
      ),
    );
  }

  Widget _buildBarangService() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 200.0,
            child: FutureBuilder<KatalogService>(
                future: _berandaService.getKatalog(),
                builder: (context, snapshot) {
                  for (int i = 0; i < snapshot.data.data.length; i++) {
                    if (snapshot.hasData) {
                      List<Product> productService =
                          snapshot.data.data[i].products;
                      return _katalogListItem(productService);
                    } 
                  }
                 return Text(
            'No value yet!',
          );
                }),
          ),
        ],
      ),
    );
  }

  Widget _katalogListItem(List<Product> productService) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        padding: EdgeInsets.only(top: 12.0),
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: productService == null ? 0 : productService.length,
        itemBuilder: (context, index) {
          for (int i = 0; i < productService.length; i++) {
            if (productService != null) {
              return InkWell(
                  onTap: () {
                    print('INI BARANG');
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            "lib/src/assets/produk.jpeg",
                            // productService[i].photos[1].photo,
                            width: 132.0,
                            height: 132.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                        ),
                        Text(productService[index].namaProduk),
                      ],
                    ),
                  ));
            } else {
              return Text('Tidak Ada Product');
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _rowBarangService(Katalog katalog) {
    return InkWell(
        onTap: () {
          print('INI BARANG');
        },
        child: Container(
          margin: EdgeInsets.only(right: 16.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  katalog.products[0].photos[0].photo.toString(),
                  color: Colors.green,
                  width: 132.0,
                  height: 132.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Text(
                katalog.products[0].namaProduk,
              ),
            ],
          ),
        ));
  }
}
