
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class PdamPage extends StatefulWidget {
  @override
  _PdamPageState createState() => _PdamPageState();
}

class _PdamPageState extends State<PdamPage> {
  // ApiService _apiService = ApiService();
  bool _isLoading = false;
  bool _namaWilayahTxt;
  bool _noPelangganTxt;
  TextEditingController _controllerWilayah = TextEditingController();
  TextEditingController _controllerNoPelanggan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldState,
      appBar: AppBar(
        title: Text('Air PDAM'),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldWilayah(),
                _buildTextFieldPelanggan(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_namaWilayahTxt == null ||
                          _noPelangganTxt == null ||
                          !_namaWilayahTxt ||
                          !_noPelangganTxt) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      // String namaWilayah = _controllerWilayah.text.toString();
                      // int noPelanggan = int.parse(_controllerNoPelanggan.text.toString());
                      // ScPdam wilayah = ScPdam(namaWilayah: namaWilayah, noPelanggan: noPelanggan);
                      // _apiService.createPdam(wilayah).then((isSuccess) {
                      //   setState(() => _isLoading = false);
                      //   if (isSuccess) {
                      //     Navigator.pop(_scaffoldState.currentState.context);
                      //   } else {
                      //     _scaffoldState.currentState.showSnackBar(SnackBar(
                      //       content: Text("Submit data failed"),
                      //     ));
                      //   }
                      // });
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
  }
  Widget _buildTextFieldWilayah() {
    return TextField(
      controller: _controllerWilayah,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama Wilayah",
        errorText: _namaWilayahTxt == null || _namaWilayahTxt
            ? null
            : "Nama Wilayah",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _namaWilayahTxt) {
          setState(() => _namaWilayahTxt = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPelanggan() {
    return TextField(
      controller: _controllerNoPelanggan,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "No Pelanggan",
        errorText: _noPelangganTxt == null || _noPelangganTxt
            ? null
            : "No Pelanggan",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _noPelangganTxt) {
          setState(() => _noPelangganTxt = isFieldValid);
        }
      },
    );
  }
}
