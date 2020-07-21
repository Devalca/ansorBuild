import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/screen/promo/MySeparator.dart';
import 'package:ansor_build/src/screen/promo/promo.dart';
import 'package:flutter/material.dart';

class DetailPromosi extends StatefulWidget {
  final String detailImg, title, desc, berlaku;
  final String sk;
  DetailPromosi({this.detailImg, this.title, this.desc, this.berlaku, this.sk});

  @override
  _DetailPromosiState createState() => _DetailPromosiState();
}

class _DetailPromosiState extends State<DetailPromosi> {
  @override
  Widget build(BuildContext context) {
    Widget middleSection = Expanded(
      child: new Container(
          color: Colors.grey[200],
          child: SingleChildScrollView(
            padding: new EdgeInsets.only(bottom: 12.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'lib/src/assets/${widget.detailImg}.png',
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  color: Colors.white,
                  padding: new EdgeInsets.all(12),
                  child: Text(widget.title,
                      style:
                          new TextStyle(color: Colors.black, fontSize: 14.0)),
                ),
                Container(
                  color: Colors.white,
                  padding: new EdgeInsets.all(12),
                  child: Text(widget.desc,
                      style:
                          new TextStyle(color: Colors.black54, fontSize: 12.0)),
                ),
                Container(
                  padding: new EdgeInsets.only(left: 12, right: 12),
                  height: 10,
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(child: Container()),
                          const MySeparator(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: new EdgeInsets.all(12),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Berlaku Sampai",
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 11.0))
                          ],
                        ),
                      ),
                      Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.berlaku,
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 11.0))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 15),
                Container(
                  color: Colors.white,
                  padding: new EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Text("Syarat dan Ketentuan",
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  color: Colors.white,
                  padding: new EdgeInsets.all(12),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 280,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.sk.substring(1, 203),
                                style: new TextStyle(
                                    color: Colors.black54, fontSize: 12.0)),
                          ],
                        ),
                      ),
                      Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey),
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         builder: (__) =>
                                  //             new Bpjs()));
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 15),
                Container(
                  color: Colors.white,
                  padding: new EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Text("Cara pakai voucher",
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  color: Colors.white,
                  padding: new EdgeInsets.all(12),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 280,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.sk.substring(1, 203),
                                style: new TextStyle(
                                    color: Colors.black54, fontSize: 12.0)),
                          ],
                        ),
                      ),
                      Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.grey),
                              onPressed: () => _showToast(context),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );

    Widget bottomBanner = new Column(children: <Widget>[
      Divider(
        height: 12,
        color: Colors.black26,
      ),
      Container(height: 5),
      Container(
        child: SizedBox(
          width: 333,
          height: 40,
          child: RaisedButton(
            child: Text('KLAIM VOUCHER',
                style: TextStyle(color: Colors.white, fontSize: 16.0)),
            color: Colors.green,
            onPressed: () {
              // setState(() => _isLoading = true);
              // Navigator.push(context,
              //     new MaterialPageRoute(builder: (__) => LandingPage()));
              // setState(() => _isLoading = false);
            },
          ),
        ),
      ),
      Container(height: 10),
    ]);

    Widget body = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        middleSection,
        bottomBanner,
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (__) => new Promo()));
              }),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Berhasil diklaim'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
