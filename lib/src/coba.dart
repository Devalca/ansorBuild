import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, 'A', ''));
    sampleData.add(new RadioModel(false, 'B', ''));
     sampleData.add(new RadioModel(false, 'A', ''));
    sampleData.add(new RadioModel(false, 'B', ''));
     sampleData.add(new RadioModel(false, 'A', ''));
    sampleData.add(new RadioModel(false, 'B', ''));
     sampleData.add(new RadioModel(false, 'A', ''));
    sampleData.add(new RadioModel(false, 'B', ''));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ListItem"),
      ),
      body: new GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: sampleData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            // splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
            },
            child: new RadioItem(sampleData[index]),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 150.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color:
                          _item.isSelected ? Colors.green : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: new BoxDecoration(
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Colors.green
                      : Colors.black),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}

// import 'dart:convert';

// import 'package:ansor_build/src/model/ansor_model.dart';
// import 'package:ansor_build/src/service/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'detail_screen.dart';

// class PulsaPage extends StatefulWidget {
//   @override
//   _PulsaPageState createState() => _PulsaPageState();
// }

// class _PulsaPageState extends State<PulsaPage> {
//   GlobalKey<FormState> _key = GlobalKey();
//   ApiService _apiService = ApiService();
//   bool _validate = true;
//   String inputNomor, inputNominal, hargaNominal;
//   int _nominalIndex = -1;
//   var mobi = "";
//   var idProv = "";
//   var logoProv = "";
//   TextEditingController _controllerNomor = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   void dispose() {
//     _controllerNomor.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       body: Container(
//         child:
//             Form(key: _key, autovalidate: _validate, child: formInputPulsa()),
//       ),
//     );
//   }

//   Widget formInputPulsa() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.0),
//       child: FutureBuilder<ProviderCall>(
//           future: _apiService.getProvider(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List<Datum> providers = snapshot.data.data;
//               return Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           Container(
//                               margin: EdgeInsets.only(top: 16.0),
//                               child: Text('Nomor HandPhone $mobi')),
//                           Stack(
//                             children: <Widget>[
//                               Positioned(
//                                 child: Container(
//                                   child: TextFormField(
//                                       inputFormatters: [
//                                         LengthLimitingTextInputFormatter(12)
//                                       ],
//                                       controller: _controllerNomor,
//                                       onChanged: (String value) async {
//                                         for (var i = 0;
//                                             i < snapshot.data.data.length;
//                                             i++) {
//                                           if (value.length == 4) {
//                                             if (value ==
//                                                 providers[i].kodeProvider) {
//                                               setState(() {
//                                                 mobi =
//                                                     providers[i].namaProvider;
//                                                 idProv = providers[i]
//                                                     .operatorId
//                                                     .toString();
//                                                 logoProv = providers[i]
//                                                     .file
//                                                     .toString();
//                                               });
//                                             }
//                                           } else if (value.length == 3) {
//                                             setState(() {
//                                               mobi = "";
//                                               logoProv = "";
//                                             });
//                                           }
//                                         }
//                                       },
//                                       keyboardType: TextInputType.phone,
//                                       validator: validateNomor,
//                                       onSaved: (String val) {
//                                         inputNomor = val;
//                                       }),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.fromLTRB(240, 12, 0, 16),
//                                 child: Container(
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Container(
//                                           margin: EdgeInsets.only(right: 12.0),
//                                           child: Container(
//                                             height: 30.0,
//                                             width: 30.0,
//                                             child: Image.network(logoProv),
//                                           )),
//                                       Container(
//                                         margin: EdgeInsets.only(right: 12.0),
//                                         height: 30.0,
//                                         width: 1.0,
//                                         color: Colors.black,
//                                       ),
//                                       Container(
//                                         child:
//                                             Icon(Icons.perm_contact_calendar),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             height: 450.0,
//                             padding: EdgeInsets.only(top: 15.0),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   FutureBuilder<NominalList>(
//                                     future: _apiService.getNominal(),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState ==
//                                           ConnectionState.done) {
//                                         for (var i = 0;
//                                             i < snapshot.data.data.length;
//                                             i++) {
//                                           if (idProv == "") {
//                                             return Container();
//                                           } else if (idProv ==
//                                               snapshot.data.data[i].operatorId
//                                                   .toString()) {
//                                             List<Listharga> hargaList =
//                                                 snapshot.data.data[i].listharga;
//                                             return Container(
//                                               height: 430.0,
//                                               child: _btnListView(hargaList),
//                                             );
//                                           }
//                                         }
//                                       }
//                                       return Container();
//                                     },
//                                   ),
//                                 ]),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       child: Column(
//                         children: <Widget>[
//                           Divider(
//                             height: 12,
//                             color: Colors.black,
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Container(
//                                       child: Text('Total'),
//                                     ),
//                                     Row(children: <Widget>[
//                                       Text('Rp'),
//                                       Text(hargaNominal == null
//                                           ? ""
//                                           : hargaNominal),
//                                     ])
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   margin: EdgeInsets.only(left: 100.0),
//                                   child: RaisedButton(
//                                     color: Colors.green,
//                                     onPressed: _sendToServer,
//                                     child: Text(
//                                       'BELI',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             }
//             return Container();
//           }),
//     );
//   }

//   Widget _btnListView(List<Listharga> hargaList) {
//     return GridView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: hargaList == null ? 0 : hargaList.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 2,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           bool isSelected = _nominalIndex == index;
//           int a = hargaList[index].nominalPulsa;
//           int b = 1500;
//           return GestureDetector(
//             child: Container(
//               padding: EdgeInsets.all(12.0),
//               alignment: Alignment.centerLeft,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6),
//                 border: Border.all(
//                     color: isSelected
//                         ? Colors.green.withOpacity(0.8)
//                         : Colors.grey[700].withOpacity(0.5)),
//                 color: Colors.white,
//               ),
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       hargaList[index].nominalPulsa.toString(),
//                       style: TextStyle(
//                           fontSize: 28,
//                           color: isSelected ? Colors.green : null),
//                     ),
//                     Text(
//                       "Harga Rp.${a + b}",
//                       style: TextStyle(
//                         fontSize: 14,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             onTap: () {
//               FocusScope.of(context).requestFocus(new FocusNode());
//               setState(() {
//                 _nominalIndex = index;
//               });
//               if (_nominalIndex == index) {
//                 inputNominal = hargaList[index].nominalPulsa.toString();
//                 hargaNominal = 'Rp.${a + b}';
//                 print(index);
//                 print(_nominalIndex);
//                 print(inputNominal);
//               }
//             },
//           );
//         });
//   }

//   String validateNomor(String value) {
//     String patttern = r'(^[0-9]*$)';
//     RegExp regExp = RegExp(patttern);
//     // if (value.length == 4) {
//     // } else
//     if (value.length != 11 && value.length != 12 && value.length != 13) {
//       return "Harus 12";
//     } else if (!regExp.hasMatch(value)) {
//       return "Harus Angka";
//     }
//     return null;
//   }

//   String validateNominal(String value) {
//     String patttern = r'(^[0-9]*$)';
//     RegExp regExp = RegExp(patttern);
//     if (value.length == 0) {
//       return "Tidak Boleh Kosong";
//     } else if (!regExp.hasMatch(value)) {
//       return "Harus Angka";
//     }
//     return null;
//   }

//   _sendToServer() {
//     if (_key.currentState.validate()) {
//       _key.currentState.save();
//       // setState(() => _isLoading = true);
//       String nomor = inputNomor.toString();
//       int nominal = int.parse(inputNominal.toString());
//       String namaProv = mobi.toString();
//       if (nomor != null || nominal != null || namaProv != null) {
//         Post post = Post(
//             noHp: nomor,
//             nominal: nominal,
//             userId: 1,
//             walletId: 1,
//             provider: namaProv);
//         _apiService.createPost(post).then((response) async {
//           if (response.statusCode == 200) {
//             Map blok = jsonDecode(response.body);
//             userUid = blok['id'].toString();
//             var koId = userUid;
//             _apiService.saveNameId(userUid).then((bool committed) {
//               print(userUid);
//             });
//             print("INI KOID : " + koId);
//             print("INI RESPONSE :" + response.body);
//             print("NI PROVIDER : " + namaProv);
//             Navigator.push(
//                 context,
//                 new MaterialPageRoute(
//                     builder: (__) => new DetailPage(koId, namaProv)));
//             _key.currentState.reset();
//           } else {
//             print("INI STATUS CODE : " + response.statusCode.toString());
//           }
//         });
//       } else {
//         print("error");
//       }
//     } else {
//       setState(() {
//         _validate = true;
//       });
//     }
//   }
// }




























// =======================================================================================
// import 'dart:convert';

// import 'package:ansor_build/src/model/ansor_model.dart';
// import 'package:ansor_build/src/service/api_service.dart';
// import 'package:flutter/material.dart';

// import 'detail_screen.dart';

// final GlobalKey<ScaffoldState> _statePrabayar = GlobalKey<ScaffoldState>();
// final GlobalKey<FormState> _key = GlobalKey();

// class PulsaPage extends StatefulWidget {
//   @override
//   _PulsaPageState createState() => _PulsaPageState();
// }

// class _PulsaPageState extends State<PulsaPage> {
//   ApiService _apiService = ApiService();
//   bool _validate = true;
//   String inputNomor, inputNominal, hargaNominal;
//   String _jsonContent = "";
//   var mobi = "";
//   var idProv = "";
//   var logoProv = "";
//   bool btn1 = false;
//   bool btn2 = false;
//   bool btn3 = false;
//   bool btn4 = false;
//   bool btn5 = false;
//   bool btn6 = false;
//   TextEditingController _controllerNomor = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   void dispose() {
//     _controllerNomor.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       key: _statePrabayar,
//       body: Container(
//         child: Form(
//           key: _key,
//           autovalidate: _validate,
//           child: formInputPulsa(),
//         ),
//       ),
//     );
//   }

//   Widget formInputPulsa() {
//     return Container(
//         color: Colors.white,
//         padding: EdgeInsets.symmetric(horizontal: 16.0),
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     Container(
//                         margin: EdgeInsets.only(top: 16.0),
//                         child: Text('Nomor HandPhone $mobi')),
//                     Stack(
//                       children: <Widget>[
//                         Positioned(
//                           child: Container(
//                             child: TextFormField(
//                                 controller: _controllerNomor,
//                                 keyboardType: TextInputType.phone,
//                                 validator: validateNomor,
//                                 onSaved: (String val) {
//                                   inputNomor = val;
//                                 }),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.fromLTRB(240, 12, 0, 16),
//                           child: Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Container(
//                                     margin: EdgeInsets.only(right: 12.0),
//                                     child: Container(
//                                       height: 30.0,
//                                       width: 30.0,
//                                       child: Image.network(logoProv),
//                                     )),
//                                 Container(
//                                   margin: EdgeInsets.only(right: 12.0),
//                                   height: 30.0,
//                                   width: 1.0,
//                                   color: Colors.black,
//                                 ),
//                                   Container(
//                                 child: Icon(Icons.contacts)
//                               )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                 padding: EdgeInsets.only(top: 15.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(child: Text('Nomor HandPhone')),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 12.0),
//                       child: Row(children: <Widget>[
//                         Expanded(
//                           child: Container(
//                             height: 65.0,
//                             decoration: BoxDecoration(
//                               border: btn1
//                                   ? Border.all(width: 1, color: Colors.green)
//                                   : Border.all(width: 1, color: Colors.grey),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8.0)),
//                             ),
//                             child: FlatButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     btn1 = !btn1;
//                                     if (btn1 == true) {
//                                       btn2 = false;
//                                       btn3 = false;
//                                       btn4 = false;
//                                       btn5 = false;
//                                       btn6 = false;
//                                       inputNominal = "10000";
//                                       hargaNominal = "11500";
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.only(right: 20),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         '10.000',
//                                         style: btn1
//                                             ? TextStyle(
//                                                 fontSize: 27.0,
//                                                 color: Colors.green)
//                                             : TextStyle(
//                                                 fontSize: 27.0,
//                                                 color: Colors.black),
//                                       ),
//                                       Text(
//                                         'Harga Rp11.500',
//                                         style: TextStyle(fontSize: 10.0),
//                                       )
//                                     ],
//                                   ),
//                                 )),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             height: 65.0,
//                             margin: EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               border: btn2
//                                   ? Border.all(width: 1, color: Colors.green)
//                                   : Border.all(width: 1, color: Colors.grey),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8.0)),
//                             ),
//                             child: FlatButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     btn2 = !btn2;
//                                     if (btn2 == true) {
//                                       btn1 = false;
//                                       btn3 = false;
//                                       btn4 = false;
//                                       btn5 = false;
//                                       btn6 = false;
//                                       inputNominal = "20000";
//                                       hargaNominal = "21500";
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.only(right: 20),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Text(
//                                         '20.000',
//                                         style: btn2
//                                             ? TextStyle(
//                                                 fontSize: 27.0,
//                                                 color: Colors.green)
//                                             : TextStyle(
//                                                 fontSize: 27.0,
//                                                 color: Colors.black),
//                                       ),
//                                       Text(
//                                         'Harga Rp21.500',
//                                         style: TextStyle(fontSize: 10.0),
//                                       )
//                                     ],
//                                   ),
//                                 )),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   ],
//                 ),
//               ),
//                   ],
//                 ),
//               ),
              
//               Container(
//                 child: Column(
//                   children: <Widget>[
//                     Divider(
//                       color: Colors.black,
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(bottom: 8.0),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Container(
//                                   child: Text('Total'),
//                                 ),
//                                 Row(children: <Widget>[
//                                   Text('Rp'),
//                                   Text(btn1 ||
//                                           btn2 ||
//                                           btn3 ||
//                                           btn4 ||
//                                           btn5 ||
//                                           btn6
//                                       ? hargaNominal
//                                       : ""),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.only(left: 100.0),
//                               child: RaisedButton(
//                                 color: Colors.green,
//                                 onPressed: _sendToServer,
//                                 child: Text(
//                                   'BELI',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }

//   Widget _simpleList(List<Listharga> hargaList) {
//     return GridView.builder(
//         itemCount: hargaList == null ? 0 : hargaList.length,
//         gridDelegate:
//             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             child: Card(
//               elevation: 5.0,
//               child: Container(
//                 alignment: Alignment.center,
//                 child: Text(hargaList[index].nominalPulsa.toString()),
//               ),
//             ),
//           );
//         });
//   }

//   String validateNomor(String value) {
//     String patttern = r'(^[0-9]*$)';
//     RegExp regExp = RegExp(patttern);
//     // if (value.length == 4) {
//     // } else
//     if (value.length != 12) {
//       return "Harus 12";
//     } else if (!regExp.hasMatch(value)) {
//       return "Harus Angka";
//     }
//     return null;
//   }

//   String validateNominal(String value) {
//     String patttern = r'(^[0-9]*$)';
//     RegExp regExp = RegExp(patttern);
//     if (value.length == 0) {
//       return "Tidak Boleh Kosong";
//     } else if (!regExp.hasMatch(value)) {
//       return "Harus Angka";
//     }
//     return null;
//   }

//   _sendToServer() {
//     if (_key.currentState.validate()) {
//       _key.currentState.save();
//       // setState(() => _isLoading = true);
//       String nomor = inputNomor.toString();
//       int nominal = int.parse(inputNominal.toString());
//       String namaProv = mobi.toString();
//       if (nomor != null || nominal != null || namaProv != null) {
//         Post post = Post(
//             noHp: nomor,
//             nominal: nominal,
//             userId: 1,
//             walletId: 1,
//             provider: namaProv);
//         _apiService.createPost(post).then((response) async {
//           if (response.statusCode == 200) {
//             // _statePrabayar.currentState.showSnackBar(SnackBar(
//             //     duration: Duration(minutes: 5),
//             //     content: Text("SEDANG PROSES")));
//             Map blok = jsonDecode(response.body);
//             var userUid = blok['id'].toString();
//             var koId = userUid;
//             _apiService.saveNameId(userUid).then((bool committed) {
//               print(userUid);
//             });
//             print("INI KOID : " + koId);
//             print("INI RESPONSE :" + response.body);
//             print("NI PROVIDER : " + namaProv);
//             // await new Future.delayed(
//             //     const Duration(seconds: 2));
//             Navigator.push(
//                 context,
//                 new MaterialPageRoute(
//                     builder: (__) => new DetailPage(koId, namaProv)));
//             // setState(() => _isLoading = false);
//           } else {
//             print("INI STATUS CODE : " + response.statusCode.toString());
//           }
//         });
//       } else {
//         print("error");
//       }
//     } else {
//       setState(() {
//         _validate = true;
//       });
//     }
//   }
// }
