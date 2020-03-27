import 'package:flutter/material.dart';

Widget centerLoading() {
  return Center(
    child: Container(
      color: Colors.white,
      alignment: Alignment(0.0, 0.0),
      child: CircularProgressIndicator(),
    ),
  );
}

Future<void> loadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // Future.delayed(Duration(seconds: 5), () {
          //   Navigator.of(context).pop(true);
          // });
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mohon Tunggu....",
                          style: TextStyle(color: Colors.green),
                        )
                      ]),
                    )
                  ]));
        });
}
