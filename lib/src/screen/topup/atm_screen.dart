import 'package:flutter/foundation.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AtmPage()));
}

class AtmPage extends StatelessWidget {
  final List<String> namaBank = [
    'BCA',
    'MANDIRI',
    'BRI',
    'BNI',
    'DKI',
    'CIMB NIAGA',
    'MAYBANK',
    'LAINNYA'
  ];

  final List<String> iconBank = [
    'lib/src/assets/bank/bca.png',
    'lib/src/assets/bank/mandiri.png',
    'lib/src/assets/bank/bri.png',
    'lib/src/assets/bank/bni.png',
    'lib/src/assets/bank/dki.png',
    'lib/src/assets/bank/niaga.png',
    'lib/src/assets/bank/mybank.png',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
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
          'ATM',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    height: 150.0,
                    width: 250.0,
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 230.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTopupPage(
                  title: namaBank[index],
                  iconBank: iconBank[index],
                );
              },
              itemCount: namaBank.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ListTopupPage extends StatefulWidget {
  final String title;
  final String iconBank;

  const ListTopupPage({Key key, this.title, this.iconBank}) : super(key: key);

  @override
  _ListTopupPageState createState() => _ListTopupPageState();
}

class _ListTopupPageState extends State<ListTopupPage> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 1.0),
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          icon: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            height: 50.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.0, color: Colors.green),
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Icon(
                                expandFlag ? Icons.remove : Icons.add,
                                color: Colors.green,
                                size: 30.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (expandFlag == false) {
                              setState(() {
                                expandFlag = !expandFlag;
                              });
                            } else {
                              setState(() {
                                expandFlag = !expandFlag;
                              });
                            }
                          }),
                      widget.iconBank == ''
                          ? Container()
                          : Container(
                              height: 30.0,
                              width: 50.0,
                              child: Image.asset(widget.iconBank),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ExpandableContainer(
              expanded: expandFlag,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                },
              ))
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 400.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 5),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: Container(
        padding: EdgeInsets.only(left: 45.0, top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text('Tata Cara'),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Masukan Kartu ATM dan PIN ATM Kamu')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Pilih menu transaksi lainya')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Pilih menu transfer')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Pilih Menu ke rek Bank Virtual Account')
                ],
              ),
            ),
            Container(
              height: 35.0,
              child: Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: _boxDot(),
                      ),
                    ),
                    Flexible(
                        child: Text(
                            'Masukan 12345+ Nomor ponsel kamu : 12345 08xx-xxx-xxx'))
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Masukan Nominal Topup')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Ikuti tatacara menyelesaikan transaksi')
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('Catatan'),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Minimum Top Up Rp 100.000')
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: _boxDot(),
                    ),
                  ),
                  Text('Biaya Top-Up Rp 2.500')
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey[200]))),
      ),
    );
  }

  Widget _boxDot() {
    return Container(
      margin: EdgeInsets.only(right: 10, bottom: 10, top: 10),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.grey),
    );
  }
}

// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class AtmPage extends StatefulWidget {
//   @override
//   State createState() {
//     return AtmPageState();
//   }
// }

// class AtmPageState extends State<AtmPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Expandable Demo"),
//       ),
//       body: ExpandableTheme(
//         data:
//             const ExpandableThemeData(
//                 iconColor: Colors.blue,
//                 useInkWell: true,
//             ),
//         child: ListView(
//           physics: const BouncingScrollPhysics(),
//           children: <Widget>[
//             Card1(),
//             Card2(),
//             Card3(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// const loremIpsum =
//     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

// class Card1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ExpandableNotifier(
//         child: Padding(
//       padding: const EdgeInsets.all(10),
//       child: Card(
//         clipBehavior: Clip.antiAlias,
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 150,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.orange,
//                   shape: BoxShape.rectangle,
//                 ),
//               ),
//             ),
//             ScrollOnExpand(
//               scrollOnExpand: true,
//               scrollOnCollapse: false,
//               child: ExpandablePanel(
//                 theme: const ExpandableThemeData(
//                   headerAlignment: ExpandablePanelHeaderAlignment.center,
//                   tapBodyToCollapse: true,
//                 ),
//                 header: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       "ExpandablePanel",
//                       style: Theme.of(context).textTheme.body2,
//                     )),
//                 collapsed: Text(
//                   loremIpsum,
//                   softWrap: true,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 expanded: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     for (var _ in Iterable.generate(5))
//                       Padding(
//                           padding: EdgeInsets.only(bottom: 10),
//                           child: Text(
//                             loremIpsum,
//                             softWrap: true,
//                             overflow: TextOverflow.fade,
//                           )),
//                   ],
//                 ),
//                 builder: (_, collapsed, expanded) {
//                   return Padding(
//                     padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                     child: Expandable(
//                       collapsed: collapsed,
//                       expanded: expanded,
//                       theme: const ExpandableThemeData(crossFadePoint: 0),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

// class Card2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     buildImg(Color color, double height) {
//       return SizedBox(
//           height: height,
//           child: Container(
//             decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.rectangle,
//             ),
//           ));
//     }

//     buildCollapsed1() {
//       return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Expandable",
//                     style: Theme.of(context).textTheme.body1,
//                   ),
//                 ],
//               ),
//             ),
//           ]);
//     }

//     buildCollapsed2() {
//       return buildImg(Colors.lightGreenAccent, 150);
//     }

//     buildCollapsed3() {
//       return Container();
//     }

//     buildExpanded1() {
//       return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Expandable",
//                     style: Theme.of(context).textTheme.body1,
//                   ),
//                   Text(
//                     "3 Expandable widgets",
//                     style: Theme.of(context).textTheme.caption,
//                   ),
//                 ],
//               ),
//             ),
//           ]);
//     }

//     buildExpanded2() {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
//               Expanded(child: buildImg(Colors.orange, 100)),
//             ],
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(child: buildImg(Colors.lightBlue, 100)),
//               Expanded(child: buildImg(Colors.cyan, 100)),
//             ],
//           ),
//         ],
//       );
//     }

//     buildExpanded3() {
//       return Padding(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               loremIpsum,
//               softWrap: true,
//             ),
//           ],
//         ),
//       );
//     }

//     return ExpandableNotifier(
//         child: Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//       child: ScrollOnExpand(
//         child: Card(
//           clipBehavior: Clip.antiAlias,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Expandable(
//                 collapsed: buildCollapsed1(),
//                 expanded: buildExpanded1(),
//               ),
//               Expandable(
//                 collapsed: buildCollapsed2(),
//                 expanded: buildExpanded2(),
//               ),
//               Expandable(
//                 collapsed: buildCollapsed3(),
//                 expanded: buildExpanded3(),
//               ),
//               Divider(
//                 height: 1,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Builder(
//                     builder: (context) {
//                       var controller = ExpandableController.of(context);
//                       return FlatButton(
//                         child: Text(
//                           controller.expanded ? "COLLAPSE" : "EXPAND",
//                           style: Theme.of(context)
//                               .textTheme
//                               .button
//                               .copyWith(color: Colors.deepPurple),
//                         ),
//                         onPressed: () {
//                           controller.toggle();
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

// class Card3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     buildItem(String label) {
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Text(label),
//       );
//     }

//     buildList() {
//       return Column(
//         children: <Widget>[
//           for (var i in [1, 2, 3, 4]) buildItem("Item ${i}"),
//         ],
//       );
//     }

//     return ExpandableNotifier(
//         child: Padding(
//       padding: const EdgeInsets.all(10),
//       child: ScrollOnExpand(
//         child: Card(
//           clipBehavior: Clip.antiAlias,
//           child: Column(
//             children: <Widget>[
//               ExpandablePanel(
//                 theme: const ExpandableThemeData(
//                   headerAlignment: ExpandablePanelHeaderAlignment.center,
//                   tapBodyToExpand: true,
//                   tapBodyToCollapse: true,
//                   hasIcon: false,
//                 ),
//                 header: Container(
//                   color: Colors.indigoAccent,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Row(
//                       children: [
//                         ExpandableIcon(
//                           theme: const ExpandableThemeData(
//                             expandIcon: Icons.arrow_right,
//                             collapseIcon: Icons.arrow_drop_down,
//                             iconColor: Colors.white,
//                             iconSize: 28.0,
//                             iconRotationAngle: math.pi / 2,
//                             iconPadding: EdgeInsets.only(right: 5),
//                             hasIcon: false,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             "Items",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .body2
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 expanded: buildList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
