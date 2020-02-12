import 'package:ansor_build/src/model/beranda_service.dart';
import 'package:ansor_build/src/screen/component/saldo_appbar.dart';
import 'package:ansor_build/src/screen/ppob/pulsa/pulsa_screen.dart';
import 'package:ansor_build/src/screen/topup/topup_screen.dart';
import 'package:flutter/material.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<PpobService> _ppobServiceList = [];

  @override
  void initState() {
    super.initState();

    _ppobServiceList
        .add(PpobService(image: Icons.directions_bike, title: "PDAM"));
    _ppobServiceList
        .add(PpobService(image: Icons.local_car_wash, title: "PULSA"));
    _ppobServiceList
        .add(PpobService(image: Icons.directions_car, title: "Entah"));
    _ppobServiceList
        .add(PpobService(image: Icons.restaurant, title: "Merasuki"));
    _ppobServiceList
        .add(PpobService(image: Icons.directions_bike, title: "PDAM"));
    _ppobServiceList
        .add(PpobService(image: Icons.local_car_wash, title: "PULSA"));
    _ppobServiceList
        .add(PpobService(image: Icons.directions_car, title: "Entah"));
    _ppobServiceList
        .add(PpobService(image: Icons.restaurant, title: "Merasuki"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SaldoAppBar(),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _buildSaldoForm(),
                _buildIklanOne(),
                _buildServiceIslamic(),
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
                              child: Text('Lihat Semuanya'),
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
                              child: Text('Lihat Semuanya'),
                            ),
                          ],
                        ),
                      ),
                      _buildBarangService()
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

  Widget _buildSaldoForm() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: <Widget>[
          Container(
              child: Row(
            children: <Widget>[
              Icon(Icons.account_balance_wallet),
              Text("Saldo")
            ],
          )),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text('Rp 1.050.000',
                  style: TextStyle(
                    fontSize: 40.0
                  ),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.refresh),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: 
                          (context) => TopupPage()
                          ));
                        },
                        child: Text('Saldo'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIklanOne() {
    return Container(
      height: 100.0,
      width: 400.0,
      color: Colors.white,
      child: Center(child: Text('INI IKLAN')),
    );
  }

  Widget _buildServiceIslamic() {
    return Container(
      height: 100.0,
      width: 400.0,
      color: Colors.white,
      child: Center(child: Text('Service Islamic')),
    );
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

  Widget _rowPpobService(PpobService ppobService) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: 
        (context) => PulsaPage()
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              padding: EdgeInsets.all(12.0),
              child: Icon(
                ppobService.image,
                color: ppobService.color,
                size: 32.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
            ),
            Text(ppobService.title, style: TextStyle(fontSize: 10.0))
          ],
        ),
      ),
    );
  }

  Widget _buildIklanTwo() {
    return Container(
      height: 100.0,
      width: 400.0,
      color: Colors.white,
      child: Center(child: Text('INI IKLAN KE DUA')),
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
      BarangService(title: "Steak Andakar", image: "lib/src/assets/hack.png"));
  _goBarangServiceFeaturedList.add(BarangService(
      title: "Mie Ayam Tumini", image: "lib/src/assets/hack.png"));
  _goBarangServiceFeaturedList.add(BarangService(
      title: "Tengkleng Hohah", image: "lib/src/assets/hack.png"));
  _goBarangServiceFeaturedList.add(
      BarangService(title: "Warung Steak", image: "lib/src/assets/hack.png"));
  _goBarangServiceFeaturedList.add(BarangService(
      title: "Kindai Warung Banjar", image: "lib/src/assets/hack.png"));

  return Future.delayed(Duration(seconds: 1), () {
    return _goBarangServiceFeaturedList;
  });
}
