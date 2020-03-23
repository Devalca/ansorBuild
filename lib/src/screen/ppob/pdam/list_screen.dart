import 'package:ansor_build/src/model/pdam_model.dart';
import 'package:ansor_build/src/service/pdam_service.dart';
import 'package:flutter/material.dart';

class ListWilayah extends StatefulWidget {
  @override
  _ListWilayahState createState() => _ListWilayahState();
}

class _ListWilayahState extends State<ListWilayah> {
  TextEditingController srcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Searc'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {},
                controller: srcController,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  focusColor: Colors.grey,
                  hoverColor: Colors.grey,
  filled: true,
                    hintText: "Cari Kota atau Kabupaten",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            Expanded(
              child: FutureBuilder<NamaWilayah>(
                future: getWilayah(),
                builder: (context, snapshot) {
                  for (int i = 0; i < snapshot.data.data.length; i++) {
                    List<Wilayah> wilayahList = snapshot.data.data;
                    return _listWilayah(wilayahList);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listWilayah(List<Wilayah> wilayahList) {
    return ListView.builder(
      itemCount: wilayahList == null ? 0 : wilayahList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(wilayahList[index].namaWilayah.toString()),
        );
      },
    );
  }
}
