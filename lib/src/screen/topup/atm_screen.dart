import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class AtmPage extends StatefulWidget {
  @override
  _AtmPageState createState() => _AtmPageState();
}

class _AtmPageState extends State<AtmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ATM'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  height: 150.0,
                  width: 250.0,
                  color: Colors.grey,
                ),
              ),
              Container(
               child: Center(
                 child: Text('Under Maintence'),
               ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpan() {
    return ExpandablePanel(
       header: Text("article"),
      collapsed: Text("article", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
      expanded: Text("article", softWrap: true, ),
      
      tapHeaderToExpand: true,
      hasIcon: true,
    );
  }
}
