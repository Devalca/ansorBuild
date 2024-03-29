import 'package:ansor_build/src/model/branda_model.dart';
import 'package:ansor_build/src/model/katalog_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/component/formatIndo.dart';
import 'package:ansor_build/src/screen/component/iklan_home.dart';
import 'package:ansor_build/src/screen/component/iklan_kecil.dart';
import 'package:ansor_build/src/screen/component/loading.dart';
import 'package:ansor_build/src/screen/component/saldo_appbar.dart';
import 'package:ansor_build/src/screen/histori/histori_main.dart';
import 'package:ansor_build/src/screen/katalog/katalog_detail.dart';
import 'package:ansor_build/src/screen/katalog/katalog_home.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_main.dart';
import 'package:ansor_build/src/screen/ppob/pdam/pdam_screen.dart';
import 'package:ansor_build/src/screen/ppob/pln/listrik.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/main_pulsa.dart';
import 'package:ansor_build/src/screen/topup/topup_screen.dart';
import 'package:ansor_build/src/screen/transfer/transfer.dart';
import 'package:ansor_build/src/service/beranda_service.dart';
import 'package:ansor_build/src/service/katalog_service.dart';
import 'package:ansor_build/src/service/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BerandaPage extends StatefulWidget {
  final int index;
  BerandaPage({this.index});

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  WalletService _walletService = WalletService();
  BerandaService _berandaService = BerandaService();
  KatalogService _katalogService = KatalogService();
  final cF = NumberFormat.currency(locale: 'ID');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SaldoAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _buildEmoneyMenu(),
                Container(
                  child: Divider(),
                ),
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
                              child: GestureDetector(
                                onTap: () {
                                  _toKatalog();
                                },
                                child: Text(
                                  'Lihat Semuanya',
                                  style: TextStyle(color: Colors.green),
                                ),
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
                              child: GestureDetector(
                                onTap: () {
                                  _toKatalog();
                                },
                                child: Text(
                                  'Lihat Semuanya',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildBarangService()
                    ],
                  ),
                ),
                _donasiService()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // KUMPULAN WIDGET UNTUK HOME PAGE

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

  Widget _buildEmoneyMenu() {
    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 120.0,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: _toTopup,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.add_circle_outline,
                              size: 35.0,
                              color: Colors.green,
                            ),
                            Text("Top Up")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) => new Transfer()));
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.sentiment_very_dissatisfied,
                              size: 35.0,
                              color: Colors.green,
                            ),
                            Text("Transfer")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _toHistori,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.history,
                              size: 35.0,
                              color: Colors.green,
                            ),
                            Text("History")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => underDialog(context),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.code,
                              size: 35.0,
                              color: Colors.green,
                            ),
                            Text("MyQR")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 40.0,
            child: Card(
              color: Colors.green,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Container(
                        child: Row(
                      children: <Widget>[
                        Icon(Icons.account_balance_wallet, color: Colors.white),
                        Container(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Saldo",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )),
                  )),
                  Container(
                    height: 25,
                    child: VerticalDivider(
                      width: 10,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: FutureBuilder<Wallet>(
                            future: _walletService.getSaldo(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Center(
                                    child: Text("Koneksi Terputus"),
                                  );
                                case ConnectionState.waiting:
                                  return Text(
                                    "Mohon Tunggu...",
                                    style: TextStyle(color: Colors.white),
                                  );
                                default:
                                  if (snapshot.hasData) {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          formatRupiah(snapshot
                                                  .data.data[0].saldoAkhir)
                                              .replaceAll("Rp ", "Rp"),
                                          style:
                                              TextStyle(color: Colors.white)),
                                    );
                                  } else {
                                    // return Text('MOHON TUNGGU...');
                                    return Text('Result: ${snapshot.error}');
                                  }
                              }
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 3.0),
                            child: Icon(Icons.refresh,
                                size: 20.0, color: Colors.white),
                          ),
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ),
        ],
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPulsa("", "")));
        } else if (ppobService.title == "Listrik PLN") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Listrik(index: widget.index)));
        } else if (ppobService.title == "Air PDAM") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PdamPage("")));
        } else if (ppobService.title == "BPJS") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Bpjs()));
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
            child: FutureBuilder<Katalog>(
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
                        for (int i = 0; i < snapshot.data.data.length; i++) {
                          List<Product> productService =
                              snapshot.data.data[i].products;
                          return _katalogListItem(productService);
                        }
                      } else {
                        return Text('Result: ${snapshot.error}');
                      }
                      return Text('Result: ${snapshot.error}');
                  }
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
        itemCount: productService == null ? 0 : productService.length = 3,
        itemBuilder: (context, index) {
          for (int i = 0; i < productService.length; i++) {
            if (productService.length != null) {
              var detNama = productService[index].namaProduk;
              var detDes = productService[index].deskripsiProduk;
              var detPot1 = productService[index].photos[0].photo;
              var detPot2 = productService[index].photos[1].photo;
              List<String> allPot = [detPot1, detPot2];
              return InkWell(
                  onTap: () {
                    // underDialog(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailKatalogPage(detNama, detDes, allPot)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: 132.0,
                              height: 132.0,
                              child: FadeInImage.assetNetwork(
                                  fadeInCurve: Curves.bounceIn,
                                  placeholder: 'lib/src/assets/placeholder.jpg',
                                  fit: BoxFit.fill,
                                  image: productService[index].photos[0].photo),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                        ),
                        Text(productService[index].namaProduk),
                      ],
                    ),
                  ));
            } else {
              return CircularProgressIndicator();
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _donasiService() {
    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 30.0,
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
                border: Border.all(width: 1, color: Colors.grey[200])),
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
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: FlatButton(
                              onPressed: null,
                              child: Text(
                                'Donasi',
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget _buildSaldoForm() {
  //   return Container(
  //     color: Colors.white,
  //     child: Column(
  //       children: <Widget>[
  //         Container(
  //             padding: const EdgeInsets.only(left: 16),
  //             child: Row(
  //               children: <Widget>[
  //                 Icon(Icons.account_balance_wallet, color: Colors.green),
  //                 Container(
  //                   padding: EdgeInsets.only(left: 5.0),
  //                   child: Text("Saldo"),
  //                 )
  //               ],
  //             )),
  //         Container(
  //           padding: const EdgeInsets.only(left: 16),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Container(
  //                 child: FutureBuilder<Wallet>(
  //                   future: _walletService.getSaldo(),
  //                   builder: (context, snapshot) {
  //                     switch (snapshot.connectionState) {
  //                       case ConnectionState.none:
  //                         return Center(
  //                           child: Text("Koneksi Terputus"),
  //                         );
  //                       case ConnectionState.waiting:
  //                         return centerLoading();
  //                       default:
  //                         if (snapshot.hasData) {
  //                           return Center(
  //                             child: Column(
  //                               children: <Widget>[
  //                                 Container(
  //                                   child: Row(
  //                                     children: <Widget>[
  //                                       Text(
  //                                           formatRupiah(snapshot
  //                                                   .data.data[0].saldoAkhir)
  //                                               .replaceAll("Rp ", "Rp"),
  //                                           style: TextStyle(fontSize: 24.0)),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           );
  //                         } else {
  //                           // return Text('MOHON TUNGGU...');
  //                           return Text('Result: ${snapshot.error}');
  //                         }
  //                     }
  //                   },
  //                 ),
  //               ),
  //               Container(
  //                 child: Column(
  //                   children: <Widget>[
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: <Widget>[
  //                         IconButton(
  //                             icon: Icon(
  //                               Icons.refresh,
  //                               color: Colors.green,
  //                             ),
  //                             onPressed: () {
  //                               setState(() {
  //                                 _walletService.getSaldo();
  //                               });
  //                             }),
  //                         FlatButton(
  //                           onPressed: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => TopupPage()));
  //                           },
  //                           child: Container(
  //                               decoration: BoxDecoration(
  //                                   color: Colors.green,
  //                                   border: Border.all(
  //                                       width: 1.0, color: Colors.green),
  //                                   borderRadius: BorderRadius.circular(5.0)),
  //                               padding: EdgeInsets.all(8.0),
  //                               child: Text(
  //                                 'ISI SALDO',
  //                                 style: TextStyle(
  //                                     fontSize: 10.0, color: Colors.white),
  //                               )),
  //                         )
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Divider()
  //       ],
  //     ),
  //   );
  // }

  _toKatalog() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => KatalogHomePage("")));
  }

  _toTopup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TopupPage()));
  }

  _toHistori() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HistoriMainPage()));
  }
}
