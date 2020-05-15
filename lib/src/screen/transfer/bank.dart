import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/screen/ppob/bpjs/bpjs_main.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:flutter/material.dart';

class Bank extends StatefulWidget {
  @override
  _BankState createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  bool _isLoading = false;

  BpjsServices _bpjsServices = BpjsServices();
  TextEditingController _searchController = TextEditingController();

  final bulanBpjsKerja = [
    {"id": 1, "bulan": "1 Bulan"},
    {"id": 2, "bulan": "3 Bulan"},
    {"id": 3, "bulan": "6 Bulan"},
    {"id": 4, "bulan": "12 Bulan"}
  ];

  // void searchOperation(String searchText){
  //   searchresult.clear();
  //   if(_isSearching != null){
  //     for(int i = 0; i < snapshot.data.data.length; i++){
  //       String data = snapshot.data.data[i];
  //       if(data.toLowerCase().contains(searchText.toLowerCase())){
  //         searchresult.add(data);
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: Colors.white,
            title: Text(
              'Bank Tujuan',
              style: TextStyle(color: Colors.black),
            )),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border:
                                Border.all(color: Colors.grey[300], width: 1)),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: new Icon(
                              Icons.search,
                            ),
                            hintText: 'Cari Bank',
                          ),
                          style: new TextStyle(fontSize: 15.0),
                          onChanged: (value) {},
                          onSubmitted: (value) {},
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Column(children: <Widget>[
                            Divider(
                              height: 12,
                              color: Colors.black26,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(
                                          Icons.account_balance_wallet,
                                          color: Colors.green,
                                          size: 24.0,
                                        ),
                                        Text(
                                          " BCA",
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.black,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 12,
                              color: Colors.black26,
                            ),
                          ]),
                        )),
                      )
                    ])),
                //     child: FutureBuilder<Bulan>(
                //   future: _bpjsServices.fetchBulan(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       return ListView.builder(
                //         itemCount: snapshot.data.data.length,
                //         itemBuilder: (context, i) {
                //           return Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: <Widget>[
                //                 InkWell(
                //                     onTap: () {
                //                       setState(() => _isLoading = true);
                //                       Navigator.push(
                //                           context,
                //                           new MaterialPageRoute(
                //                               builder: (__) => new Bpjs()));
                //                       setState(() => _isLoading = false);
                //                     },
                //                     child: Container(
                //                         child: Column(
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.start,
                //                             children: <Widget>[
                //                           Padding(
                //                             padding: const EdgeInsets.only(
                //                                 top: 10.0, bottom: 0.0),
                //                             child: Container(
                //                                 height: 30,
                //                                 child: Text(
                //                                   snapshot.data.data[i].nama,
                //                                   style: new TextStyle(
                //                                       fontSize: 16.0),
                //                                 )),
                //                           ),
                //                           Divider(
                //                             height: 12,
                //                             color: Colors.black,
                //                           ),
                //                           Container(height: 15),
                //                         ]))),
                //               ]);
                //         },
                //       );
                //     } else if (snapshot.hasError) {
                //       return Text("${snapshot.error}");
                //     }
                //     return Center(child: CircularProgressIndicator());
                //   },
                // )
              ));
  }
}
