import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: BankingPage()));
}

class BankingPage extends StatelessWidget {
  final List<String> namaBank = [
    'BCA',
    'MANDIRI',
    'BRI',
    'BNI',
    'DKI',
    'CIMB NIAGA',
    'MAYBANK',
    'LAINNYA'
  ];

  final List<String> iconBank = [
  'lib/src/assets/BANNER_ATAS.jpg',
  'lib/src/assets/BANNER_ATAS.jpg',
  'lib/src/assets/BANNER_ATAS.jpg'
  'lib/src/assets/BANNER_ATAS.jpg',
  'lib/src/assets/BANNER_ATAS.jpg',
   'lib/src/assets/BANNER_ATAS.jpg',
  'lib/src/assets/BANNER_ATAS.jpg',
  'lib/src/assets/BANNER_ATAS.jpg'
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        backgroundColor: Colors.white,
        title: Text(
          'Internet/Mobile Banking',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    height: 150.0,
                    width: 250.0,
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 230.0),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTopupPage(title: namaBank[index]);
              },
              itemCount: namaBank.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ListTopupPage extends StatefulWidget {
  final String title;
  final String iconBank;

  const ListTopupPage({Key key, this.title, this.iconBank}) : super(key: key);

  @override
  _ListTopupPageState createState() => _ListTopupPageState();
}

class _ListTopupPageState extends State<ListTopupPage> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 1.0),
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          icon: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            height: 50.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.0, color: Colors.green),
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                expandFlag ? Icons.remove : Icons.add,
                                color: Colors.green,
                                size: 30.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              expandFlag = !expandFlag;
                            });
                          }),
                      Container(
                        height: 30.0,
                        width: 50.0,
                        padding: EdgeInsets.only(left: 10.0),
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ExpandableContainer(
              expanded: expandFlag,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                },
              ))
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 400.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 5),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: Container(
        padding: EdgeInsets.only(left: 45.0, top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text('Tata Cara'),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Masukan Kartu ATM dan PIN ATM Kamu')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Pilih menu transaksi lainya')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Pilih menu transfer')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Pilih Menu ke rek Bank Virtual Account')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Masukan 12345+ Nomor ponsel kamu : 12345 08xx-xxx-xxx')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Masukan Nominal Topup')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Ikuti tatacara menyelesaikan transaksi')
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('Catatan'),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Minimum Top Up Rp 100.000')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Biaya Top-Up Rp 2.500')
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey[200]))),
      ),
    );
  }

  Widget _boxDot() {
    return Container(
      margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4)
        ),
        color: Colors.grey
      ),
    );
  }
}
