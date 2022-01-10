import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final List<String> assets;

  const CustomCarousel({Key? key, required this.assets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 1.0,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items: assets
            .map((asset) => Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child:
                          Image.asset(asset, fit: BoxFit.cover, width: 1000.0)),
                ))
            .toList());
  }
}
