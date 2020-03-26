import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> homeIklan = [
  'lib/src/assets/BANNER_BAWAH.jpg',
  'lib/src/assets/BANNER_BAWAH.jpg',
  'lib/src/assets/BANNER_BAWAH.jpg',
  'lib/src/assets/BANNER_BAWAH.jpg',
  'lib/src/assets/BANNER_BAWAH.jpg',
];

final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(
  homeIklan,
  (index, i) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.asset(i, fit: BoxFit.fill, width: 1000.0),
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

class IklanKecil extends StatefulWidget {
  @override
  _IklanKecilState createState() => _IklanKecilState();
}

class _IklanKecilState extends State<IklanKecil> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child,
        enableInfiniteScroll: false,
        autoPlay: false,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        aspectRatio: 6,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: map<Widget>(
                homeIklan,
                (index, url) {
                  return Container(
                    width: 8.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Colors.orange
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                },
              ),
            ),
            Container(
              child: Text(
                'Lihat Semua',
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
