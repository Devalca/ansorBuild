import 'package:flutter/material.dart';

class SaldoAppBar extends AppBar {
  SaldoAppBar()
      : super(
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: _buildSaldoAppBar());

  static Widget _buildSaldoAppBar() {
    return Container(
      padding: EdgeInsets.only(left: 9.0, right: 16.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset('lib/src/assets/lapak_sahabat.png', fit: BoxFit.cover, width: 140,),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 28.0,
                  width: 28.0,
                  padding: EdgeInsets.all(6.0),
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.notifications,
                    color: Colors.green,
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