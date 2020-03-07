// // Flutter code sample for EditableText.onChanged

// // This example shows how onChanged could be used to check the TextField's
// // current value each time the user inserts or deletes a character.

// import 'package:flutter/material.dart';

// import 'model/ansor_model.dart';
// import 'service/api_service.dart';

// void main() => runApp(CobaApp());

// /// This Widget is the main application widget.
// class CobaApp extends StatelessWidget {
//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }

// class MyStatefulWidget extends StatefulWidget {
//   MyStatefulWidget({Key key}) : super(key: key);

//   @override
//   _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   var mobi;
//   ApiService _apiService = ApiService();
//   TextEditingController _controller;

//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//   }

//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: FutureBuilder<ProviderCall>(
//         future: _apiService.getProvider(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                   "Something wrong with message: ${snapshot.error.toString()}"),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done) {
//             List<Datum> providers = snapshot.data.data;
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text('What number comes next in the sequence?'),
//                 Text("data : $mobi"),
//                 TextField(
//                   controller: _controller,
//                   onChanged: (String value) async {
//                      for(var i = 0; i < snapshot.data.data.length; i++){
//                        if (value != snapshot.data.data[i].kodeProvider) {
//                          setState(() {
//                            mobi = snapshot.data.data[i].namaProvider.toString();
//                          });
//                           print("INI PRINAN NYA : " + snapshot.data.data[i].namaProvider + " - " + 
//                           snapshot.data.data[i].kodeProvider  + " - " + i.toString());
//                        }
//                       }
//                   },
//                 ),
//               ],
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     ));
//   }
// }
