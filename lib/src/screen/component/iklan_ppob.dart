import 'package:carousel_slider/carousel_slider.dart'; // Harus Update Package
import 'package:flutter/material.dart';

final List<String> ppobIklan = [
  'lib/src/assets/BANNER_PULSA.jpg',
  'lib/src/assets/BANNER_PULSA.jpg',
  'lib/src/assets/BANNER_PULSA.jpg'
];

final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(
  ppobIklan,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.asset(i, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class IklanPpob extends StatefulWidget {
  @override
  _IklanPpobState createState() => _IklanPpobState();
}

class _IklanPpobState extends State<IklanPpob> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child,
        autoPlay: false,
        viewportFraction: 0.9,
        enlargeCenterPage: false,
        aspectRatio: 3.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 26.0),
        child: Row(
          children: map<Widget>(
            ppobIklan,
            (index, url) {
              return Container(
                width: 8.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Colors.orange
                        : Color.fromRGBO(0, 0, 0, 0.4)),
              );
            },
          ),
        ),
      ),
    ]);
  }
}
