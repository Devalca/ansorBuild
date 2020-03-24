import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/screen/ppob/pdam/pdam_screen.dart';
import 'package:ansor_build/src/service/pdam_service.dart';
import 'package:flutter/material.dart';

class ListWilayah extends StatefulWidget {
  @override
  _ListWilayahState createState() => _ListWilayahState();
}

class _ListWilayahState extends State<ListWilayah> {
  List<Wilayah> _notes = List<Wilayah>();
  List<Wilayah> _notesForDisplay = List<Wilayah>();

  @override
  void initState() {
    getWilayah().then((value) {
      setState(() {
        _notes.addAll(value.data);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
          'Pilih Kota',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 65.0),
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return index == 0 ? Container() : _listKota(index - 1);
            },
            itemCount: _notesForDisplay.length + 1,
          ),
        ),
        _searchBar()
      ]),
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: TextField(
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
              var noteTitle = note.namaWilayah.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
        decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            hintText: "Cari Kota atau Kabupaten",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      ),
    );
  }

  Widget _listKota(index) {
    String namaKotaKab = _notesForDisplay[index].namaWilayah.toString();
    return GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: 
            (context) => PdamPage(namaKotaKab)
            ));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black38)),
            ),
            child: ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              title: Text(
                 _notesForDisplay[index].namaWilayah,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        );
  }
}

  // Widget _listWilayah(List<Wilayah> wilayahList) {
  //   return ListView.builder(
  //     itemCount: wilayahList == null ? 0 : wilayahList.length,
  //     itemBuilder: (context, index) {
  //       return GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => ContohPage()));
  //         },
  //         child: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 16.0),
  //           decoration: BoxDecoration(
  //             border: Border(bottom: BorderSide(color: Colors.black38)),
  //           ),
  //           child: ListTile(
  //             dense: true,
  //             contentPadding:
  //                 EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
  //             title: Text(
  //               wilayahList[index].namaWilayah.toString(),
  //               style: TextStyle(fontSize: 16.0),
  //             ),
  //           ),
  //         ),
  //       );
  //       // return ListTile(
  //       //   title: Text(wilayahList[index].namaWilayah.toString()),
  //       // );
  //     },
  //   );
  // }

//  child: Column(
//     children: <Widget>[
//       Container(
//         decoration: BoxDecoration(
//             border: Border(
//                 bottom: BorderSide(width: 1.0, color: Colors.grey))),
//         padding:
//             const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
//         child: TextField(
//           onChanged: (value) {},
//           controller: srcController,
//           decoration: InputDecoration(
//               fillColor: Colors.grey[200],
//               filled: true,
//               hintText: "Cari Kota atau Kabupaten",
//               prefixIcon: Icon(
//                 Icons.search,
//                 color: Colors.grey,
//               ),
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//               focusedBorder: OutlineInputBorder(
//                 borderSide:
//                     const BorderSide(color: Colors.grey, width: 1.0),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)))),
//         ),
//       ),
//       Expanded(
//         child: FutureBuilder<NamaWilayah>(
//           future: getWilayah(),
//           builder: (context, snapshot) {
//             for (int i = 0; i < snapshot.data.data.length; i++) {
//               List<Wilayah> wilayahList = snapshot.data.data;
//               return _listWilayah(wilayahList);
//             }
//             return Container();
//           },
//         ),
//       ),
//     ],
//   ),
