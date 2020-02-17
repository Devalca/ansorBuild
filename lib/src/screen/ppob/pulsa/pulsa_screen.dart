import 'package:ansor_build/src/model/ansor_model.dart';
import 'package:ansor_build/src/service/api_service.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class PulsaPage extends StatefulWidget {
  @override
  _PulsaPageState createState() => _PulsaPageState();
}

class _PulsaPageState extends State<PulsaPage> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNomor;
  bool _isFieldNominal;
  TextEditingController _controllerNomor = TextEditingController();
  TextEditingController _controllerNominal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Form Add",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<Post>(
        future: _apiService.getPost(),
        builder: (context, snapshot) {
          return Container(
            child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldNomor(),
                _buildTextFieldNominal(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldNomor == null ||
                          _isFieldNominal == null ||
                          !_isFieldNomor ||
                          !_isFieldNominal) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("WOYYY 1!1!1!"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String no_hp = _controllerNomor.text.toString();
                      int nominal = int.parse(_controllerNominal.text.toString());
                      Post post =
                          Post(noHp: no_hp, nominal: nominal);
                      _apiService.createPost(post).then((post) {
                        setState(() => _isLoading = false);
                        if (post != null) {
                         _scaffoldState.currentState.showSnackBar(SnackBar(
                           content: Text("Berhasil")
                         ));
                        } else {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            content: Text("Submit data failed"),
                          ));
                        }
                      });
                    },
                    child: Text(
                      "Submit".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
          );
        },
      )
    );
  }

  Widget _buildTextFieldNomor() {
    return TextField(
      controller: _controllerNomor,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Nomor HP",
        errorText: _isFieldNomor == null || _isFieldNomor
            ? null
            : "WOYYY 1!1!1!",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNomor) {
          setState(() => _isFieldNomor = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNominal() {
    return TextField(
      controller: _controllerNominal,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Nominal",
        errorText: _isFieldNominal == null || _isFieldNominal
            ? null
            : "WOYYY 1!1!1!",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNominal) {
          setState(() => _isFieldNominal = isFieldValid);
        }
      },
    );
  }
}
// import 'package:ansor_build/src/service/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:ansor_build/src/model/ansor_model.dart';

// import 'form.dart';

// ApiService api = new ApiService();
// final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

// class PulsaPage extends StatefulWidget {
//   @override
//   _PulsaPageState createState() => _PulsaPageState();
// }

// class _PulsaPageState extends State<PulsaPage> {
//   Kontak data;
//   List<Kontak> allKontak;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldState,
//       appBar: AppBar(
//         title: Text(
//           'Simple CRUD Apps',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.orange[400],
//         automaticallyImplyLeading: true,
//         actions: <Widget>[
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return PulsaPage();
//               }));
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             ),
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: FutureBuilder(
          
//           builder:
//               (BuildContext context, AsyncSnapshot<List<Kontak>> snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                     "Something wrong with message: ${snapshot.error.toString()}"),
//               );
//             } else if (snapshot.connectionState == ConnectionState.done) {
//               allKontak = snapshot.data;
//               if (allKontak == null) {
//                 return Center(
//                   child: Text("Data not found"),
//                 );
//               } else {
//                 return buildKontakListView(context, allKontak);
//               }
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildKontakListView(BuildContext context, List<Kontak> allKontak) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: allKontak.isEmpty
//           ? Column(
//               children: <Widget>[
//                 Text(
//                   "No Transaction Data",
//                   style: Theme.of(context).textTheme.title,
//                 ),
//               ],
//             )
//           : ListView.builder(
//               itemBuilder: (context, index) {
//                 Kontak kontak = allKontak[index];
//                 return Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       child: Column(
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Text(
//                                   "kontak.namaDepan + " " + kontak.namaBelakang"),
//                               Spacer(),
//                               Text("kontak.noTelepon"),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Spacer(),
//                               RaisedButton(
//                                 child: Text("Ubah",
//                                     style: TextStyle(color: Colors.white)),
//                                 color: Colors.orange[400],
//                                 onPressed: () {
//                                   // panggil PulsaPage dengan parameter
//                                 },
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               RaisedButton(
//                                 child: Text("Hapus",
//                                     style: TextStyle(color: Colors.white)),
//                                 color: Colors.orange[400],
//                                 onPressed: () {
//                                   // panggil endpoint hapus
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               itemCount: allKontak.length,
//             ),
//     );
//   }
// }