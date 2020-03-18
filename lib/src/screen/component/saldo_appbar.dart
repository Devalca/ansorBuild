import 'package:flutter/material.dart';

class SaldoAppBar extends AppBar {
  SaldoAppBar()
      : super(
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: _buildSaldoAppBar());

  static Widget _buildSaldoAppBar() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Lapak Sahabat",
          style: TextStyle(
            fontSize: 20.0
          ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 28.0,
                  width: 28.0,
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(100.0)),
                      color: Colors.orangeAccent),
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}