import 'package:ansor_build/src/model/beranda_service.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/component/iklan_home.dart';
import 'package:ansor_build/src/screen/component/iklan_kecil.dart';
import 'package:ansor_build/src/screen/component/iklan_ppob.dart';
import 'package:ansor_build/src/screen/component/saldo_appbar.dart';
import 'package:ansor_build/src/screen/ppob/pdam/pdam_screen.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/main_pulsa_new.dart';
import 'package:ansor_build/src/screen/topup/topup_screen.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  ApiService _apiService = ApiService();
  List<PpobService> _ppobServiceList = [];
  List<IslamService> _islamServiceList = [];

  @override
  void initState() {
    super.initState();
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/PDAM.png'), title: "PDAM"));
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/PULSA.png'), title: "PULSA"));
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/LISTRIK.png'),
        title: "Listrik PLN"));
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/BPJS.png'), title: "BPJS"));
    _ppobServiceList.add(PpobService(
        image: Image.asset('lib/src/assets/PULSA.png'), title: "PDAM"));
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/CARI_MASJID.png'), title: "Cari Masjid"));
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/JADWAL_KAJIAN.png'), title: "Jadwal Kajian"));
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/JAM_SOLAT.png'), title: "Jam Solat"));
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/KIBLAT.png'), title: "Kiblat"));
    _islamServiceList.add(IslamService(
        image: Image.asset('lib/src/assets/QURAN.png'), title: "Quran"));
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
                              child: Text('Lihat Semuanya', style: TextStyle(color: Colors.green),),
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
                              child: Text('Lihat Semuanya', style: TextStyle(color: Colors.green)),
                            ),
                          ],
                        ),
                      ),
                      _buildBarangService()
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, ),
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
                          border: Border.all(
                            width: 1,
                            color: Colors.grey[200]
                          )
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Image.asset('lib/src/assets/BANNER_ATAS.jpg'),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        width: 1,
                                        color: Colors.green
                                      ),
                                      borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    child: FlatButton(onPressed: null, child: Text('Donasi', style: TextStyle(color: Colors.white),))
                                  )
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
                                      Text('Rp. ',
                                          style: TextStyle(fontSize: 24.0)),
                                      Text(
                                        snapshot.data.data[0].saldoAkhir
                                            .toString(),
                                        style: TextStyle(fontSize: 24.0),
                                      ),
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
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _islamServiceList.length,
                itemBuilder: (context, position) {
                  return _rowIslamService(_islamServiceList[position]);
                })));
  }

  Widget _buildServicePembayaran() {
    return SizedBox(
        width: double.infinity,
        height: 120.0,
        child: Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _ppobServiceList.length,
                itemBuilder: (context, position) {
                  return _rowPpobService(_ppobServiceList[position]);
                })));
  }

  Widget _rowIslamService(IslamService islamService) {
    return InkWell(
      onTap: () {
        if (islamService.title == "ISlam") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PdamPage()));
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
              child:  Container(
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
        if (ppobService.title == "PDAM") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PdamPage()));
        } else if (ppobService.title == "PULSA") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPulsa()));
        } else if (ppobService.title == "Listrik PLN") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Listrik()));
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
            height: 172.0,
            child: FutureBuilder<List>(
                future: fetchBarangService(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      padding: EdgeInsets.only(top: 12.0),
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _rowBarangService(snapshot.data[index]);
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
          ),
        ],
      ),
    );
  }

  Widget _rowBarangService(BarangService barangService) {
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
                  barangService.image,
                  width: 132.0,
                  height: 132.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Text(
                barangService.title,
              ),
            ],
          ),
        ));
  }
}

Future<List<BarangService>> fetchBarangService() async {
  List<BarangService> _goBarangServiceFeaturedList = [];
  _goBarangServiceFeaturedList.add(
      BarangService(title: "Steak Andakar", image: "lib/src/assets/produk.jpeg"));
  _goBarangServiceFeaturedList.add(BarangService(
      title: "Mie Ayam Tumini", image: "lib/src/assets/produk.jpeg"));
  _goBarangServiceFeaturedList.add(BarangService(
      title: "Tengkleng Hohah", image: "lib/src/assets/produk.jpeg"));
  _goBarangServiceFeaturedList.add(
      BarangService(title: "Warung Steak", image: "lib/src/assets/produk.jpeg"));
  _goBarangServiceFeaturedList.add(BarangService(
      title: "Kindai Warung Banjar", image: "lib/src/assets/produk.jpeg"));

  return Future.delayed(Duration(seconds: 1), () {
    return _goBarangServiceFeaturedList;
  });
}
