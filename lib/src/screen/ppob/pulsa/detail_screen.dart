// import 'package:ansor_build/src/model/ansor_model.dart';
// import 'package:ansor_build/src/service/api_service.dart';
// import 'package:flutter/material.dart';

// final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

// class FormScreen extends StatefulWidget {
//   Kontak kontak;
//   FormScreen({this.kontak});

//   @override
//   _FormScreenState createState() => _FormScreenState();
// }

// class _FormScreenState extends State<FormScreen> {
//   ApiService api = new ApiService();
//   TextEditingController ctrlNamaDepan = new TextEditingController();
//   TextEditingController ctrlNamaBelakang = new TextEditingController();
//   TextEditingController ctrlNoTelepon = new TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldState,
//       appBar: AppBar(
//         backgroundColor: Colors.orange[400],
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text(
//           widget.kontak == null ? "Form Tambah" : "Form Update",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               controller: ctrlNamaDepan,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 labelText: 'Nomor Hp',
//                 hintText: 'Nomor Hp',
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               controller: ctrlNamaBelakang,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 labelText: 'Nominal',
//                 hintText: 'Nominal',
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: <Widget>[
//                 Spacer(),
//                 RaisedButton(
//                   onPressed: () {
//                     if (validateInput()) {
//                       Kontak dataIn = new Kontak(
//                           no_hp: ctrlNamaDepan.text,
//                           nominal: int.parse(ctrlNamaBelakang.text));
//                       if (this.widget.kontak != null) {
//                          _scaffoldState.currentState.showSnackBar(SnackBar(
//                               content: Text("Simpan data gagal"),
//                             ));
//                       } else {
//                         api.create(dataIn).then((result) {
//                           if (result != null) {
//                             Navigator.pop(_scaffoldState.currentState.context);
//                           } else {
//                             _scaffoldState.currentState.showSnackBar(SnackBar(
//                               content: Text("Simpan data gagal"),
//                             ));
//                           }
//                         });
//                       }
//                     } else {
//                       _scaffoldState.currentState.showSnackBar(SnackBar(
//                         content: Text("Data belum lengkap"),
//                       ));
//                     }
//                   },
//                   child: Text(
//                     widget.kontak == null ? "Simpan" : "Ubah",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   color: Colors.orange[400],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   bool validateInput() {
//     if (ctrlNamaDepan.text == "" ||
//         ctrlNamaBelakang.text == "" ) {
//       return false;
//     } else {
//       return true;
//     }
//   }
// }