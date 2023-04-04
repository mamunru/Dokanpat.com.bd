import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerProgress extends StatelessWidget {
  int item;
  ShimmerProgress({this.item = 1, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: item == 1 ? 1 : 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: .60
            //mainAxisExtent: 256,
            ),
        itemCount: item,
        itemBuilder: (_, index) {
          return Shimmerwidget(context);
        });
  }

  Widget Shimmerwidget(BuildContext context) {
    return Container(
      child: Shimmer(
        duration: const Duration(seconds: 3), //Default value
        interval:
            const Duration(seconds: 0), //Default value: Duration(seconds: 0)
        color: const Color.fromARGB(255, 109, 105, 105), //Default value
        colorOpacity: 0, //Default value
        enabled: true, //Default value
        direction: const ShimmerDirection.fromLTRB(), //Default Value
        child: Container(
          color: const Color.fromARGB(255, 248, 248, 250),
        ),
      ),
    );
  }
}
