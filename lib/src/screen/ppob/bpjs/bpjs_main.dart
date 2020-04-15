import 'package:ansor_build/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_kesehatan.dart'
    as kesehatan;
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_ketenagakerjaan.dart'
    as ketenagakerjaan;

class Bpjs extends StatefulWidget {
  final int index, periode;
  final String tgl, nm, bln;
  final String noVa, noKtp;
  Bpjs(
      {this.index,
      this.tgl,
      this.nm,
      this.bln,
      this.periode,
      this.noVa,
      this.noKtp});

  @override
  _BpjsState createState() => _BpjsState();
}

class _BpjsState extends State<Bpjs> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
    print(widget.noVa);
    print(widget.noKtp);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: widget.index == null ? 0 : widget.index,
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.LandingScreen, (Route<dynamic> route) => false);
                  }),
              elevation: 0.2,
              backgroundColor: Colors.white,
              title: Text(
                'BPJS',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              overflow: Overflow.clip,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 0, left: 12.0, right: 12.0),
                  child: Scaffold(
                    resizeToAvoidBottomPadding: false,
                    appBar: AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                      bottom: PreferredSize(
                        preferredSize: Size(0.5, 0.5),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: TabBar(
                            onTap: (index) {
                              print(index);
                            },
                            labelColor: Colors.green,
                            indicatorColor: Colors.green,
                            tabs: [
                              Container(
                                child: Tab(text: 'Kesehatan'),
                              ),
                              Container(
                                child: Tab(text: 'Ketenagakerjaan'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        kesehatan.BpjsKesehatan(
                            tgl: widget.tgl, nm: widget.nm, noVa: widget.noVa),
                        ketenagakerjaan.BpjsKetenagakerjaan(
                            bln: widget.bln,
                            periode: widget.periode,
                            noKtp: widget.noKtp),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
