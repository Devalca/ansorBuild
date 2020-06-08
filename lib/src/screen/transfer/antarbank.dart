import 'package:ansor_build/src/model/transfer_model.dart';
import 'package:ansor_build/src/model/wallet_model.dart';
import 'package:ansor_build/src/screen/transfer/bank.dart';
import 'package:ansor_build/src/screen/transfer/detailTransfer.dart';
import 'package:ansor_build/src/screen/transfer/transfer.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:ansor_build/src/service/transfer_service.dart';
import 'package:ansor_build/src/service/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AntarBank extends StatefulWidget {
  final String bank;
  AntarBank({this.bank});

  @override
  _AntarBankState createState() => _AntarBankState();
}

class _AntarBankState extends State<AntarBank> {
  bool error = true;
  int saldo = 0;
  String url = "";
  String errorTextrek = "";
  String errorTextnominal = "";
  TextEditingController _noRekeningController = TextEditingController();
  TextEditingController _nominalController = TextEditingController();

  WalletService _walletService = WalletService();
  TransferServices _transferServices = TransferServices();
  LocalService _localServices = LocalService();

  @override
  Widget build(BuildContext context) {
    bank() async {
      if (_noRekeningController.text.isEmpty) {
        setState(() => {error = false, errorTextrek = "Wajib diisi"});
      } else if (_nominalController.text.isEmpty) {
        setState(() => {error = false, errorTextnominal = "Wajib diisi"});
      } else if (widget.bank == null) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Transaksi Gagal",
                    style: TextStyle(color: Colors.green)),
                content: Text("Silahkan pilih bank pembayaran"),
                actions: <Widget>[
                  MaterialButton(
                    elevation: 5.0,
                    child: Text("OK", style: TextStyle(color: Colors.green)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      } else {
        String no_penerima = _noRekeningController.text;
        int nominal_trf = int.parse(_nominalController.text);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String walletId = prefs.getString("walletId");
        String userId = prefs.getString("userId");

        print("walletId: " + walletId);
        print("userId: " + userId);
        print("no_penerima: " + no_penerima.toString());
        print("nominal_trf: " + nominal_trf.toString());

        PostBank bank = PostBank(
            userId: userId,
            walletId: walletId,
            nominal_trf: nominal_trf,
            no_penerima: no_penerima,
            label: widget.bank);

        _transferServices.postBank(bank).then((response) async {
          if (response.statusCode == 302) {
            print("berhasil body: " + response.body);
            print(response.statusCode);

            url = response.headers['location'];
            print("url: " + url);

            String id = url.substring(17);
            print("id: " + id);

            _localServices.saveTransferId(id).then((bool committed) {
              print(id);
            });

            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (__) => new DetailTransfer(url: url)));
          } else {
            print("error: " + response.body);
            print(response.statusCode);

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Tranfer Gagal",
                        style: TextStyle(color: Colors.green)),
                    // content: Text(
                    //     "Anda Belum melakukan aktivasi. Lakukan verifikasi email"),
                    actions: <Widget>[
                      MaterialButton(
                        elevation: 5.0,
                        child:
                            Text("OK", style: TextStyle(color: Colors.green)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          }
        });
      }
    }

    Widget middleSection = Expanded(
      child: new Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    child: Text("Nama Bank",
                        style: new TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.left)),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (__) => new Bank()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    width: double.infinity,
                    height: 40.0,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: widget.bank == null
                                    ? new Text("Pilih Bank",
                                        style: new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54))
                                    : new Text(widget.bank,
                                        style: new TextStyle(fontSize: 14.0)),
                              ),
                              Container(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(height: 10),
                Container(
                    child: Text("Nomor Rekening",
                        style: new TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.left)),
                TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(13),
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: _noRekeningController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nomor Rekening',
                    errorText: error ? null : errorTextrek,
                  ),
                  style: new TextStyle(fontSize: 14.0),
                  onChanged: (value) {
                    if (value.length == 0) {
                      return setState(
                          () => {error = false, errorTextrek = "Wajib diisi"});
                    } else {
                      return setState(() => error = true);
                    }
                  },
                  onSubmitted: (value) {
                    bank();
                  },
                ),
                Container(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.grey[300], width: 1)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    " Saldo Un1ty",
                                    style: new TextStyle(
                                      color: Colors.green,
                                      fontSize: 12.0,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                child: FutureBuilder<Wallet>(
                              future: _walletService.getSaldo(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  saldo = snapshot.data.data[0].saldoAkhir;
                                  return Text(NumberFormat.simpleCurrency(
                                          locale: 'id', decimalDigits: 0)
                                      .format(
                                          snapshot.data.data[0].saldoAkhir));
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return CircularProgressIndicator();
                              },
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.grey[300], width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Masukkan Nominal",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(13),
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _nominalController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Rp 16.000',
                          errorText: error ? null : errorTextnominal,
                        ),
                        style: new TextStyle(fontSize: 14.0),
                        onChanged: (value) {
                          if (value.length == 0) {
                            return setState(() => {
                                  error = false,
                                  errorTextnominal = "Wajib diisi"
                                });
                          } else {
                            return setState(() => error = true);
                          }
                        },
                        onSubmitted: (value) {
                          // ket();
                        },
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
      Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: SizedBox(
          width: double.infinity,
          height: 35,
          child: RaisedButton(
            child: Text('LANJUT', style: TextStyle(color: Colors.white)),
            color: Colors.green,
            onPressed: () async {
              bank();
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
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (__) => new Transfer()));
              }),
          title: Text(
            "Ke Rekening Bank",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }
}
