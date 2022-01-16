import 'package:flutter/material.dart';

const int acceleration = 4;
const int totalFrames = 314;

class AnimationIndex extends StatefulWidget {
  AnimationIndex({Key? key}) : super(key: key);
  final frames =
      List<String>.generate(totalFrames, (i) => 'assets/animation/${(i + 1).toString().padLeft(4, '0')}.jpg');

  @override
  State createState() => _AnimationIndexState();
}

class _AnimationIndexState extends State<AnimationIndex> {
  int _currentFrame = 0;
  List<Image> images = [];
  List<String> titles = [];
  List<String> subtitles = [];

  @override
  void initState() {
    titles = widget.frames.map((_) => "").toList();
    subtitles = widget.frames.map((_) => "").toList();

    for (int i in List<int>.generate(40, (i) => i + 20)) {
      titles[i] = "Telewizor, 32 cale, full HD";
      subtitles[i] = "1290 zł";
    }

    for (int i in List<int>.generate(40, (i) => i + 80)) {
      titles[i] = "Szafka nad telewizor";
      subtitles[i] = "250 zł";
    }

    for (int i in List<int>.generate(20, (i) => i + 160)) {
      titles[i] = "Regał";
      subtitles[i] = "350 zł";
    }

    for (var frame in widget.frames) {
      images.add(Image.asset(frame));
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    for (var image in images) {
      precacheImage(image.image, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0 && _currentFrame < (totalFrames - 1) * acceleration) {
                  setState(() {
                    _currentFrame++;
                  });
                } else if (details.delta.dx < 0 && _currentFrame > 0) {
                  setState(() {
                    _currentFrame--;
                  });
                }
              },
                child: Hero(
                  tag: _currentFrame,
                  child: FittedBox(fit:BoxFit.fill, child: images[_currentFrame ~/ acceleration]),
                ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                    titles[_currentFrame ~/ acceleration],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
              ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                subtitles[_currentFrame ~/ acceleration],
                style: const TextStyle(fontSize: 18),
              )
            )
          ],
        ),
      ),
    );
  }
}
