import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  Widget child;

  FadeAnimation(this.delay, {required this.child});

  @override
  Widget build(BuildContext context) {
    final tween1 = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 100),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeIn)
          .thenTween('translateY', Tween(begin: 100, end: 200),
              duration: const Duration(milliseconds: 750),
              curve: Curves.easeOut);

    // MultiTrackTween([
    //   Track("opacity")
    //       .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);

    return child;
  }
}
