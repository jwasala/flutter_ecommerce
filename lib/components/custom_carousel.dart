import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> assets;

  const CustomCarousel({Key? key, required this.assets}) : super(key: key);

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: widget.assets
            .map((item) => GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return DetailScreen(tag: item, assetName: item);
                    }));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color.fromARGB(50, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              ),
                            ),
                          ],
                        )),
                  ),
                ))
            .toList(),
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.assets.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

class DetailScreen extends StatefulWidget {
  final String tag;
  final String assetName;

  const DetailScreen({Key? key, required this.tag, required this.assetName}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: widget.tag,
            child: Image.asset(
              widget.assetName,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
