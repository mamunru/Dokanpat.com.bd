import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class DetailsNetworkCatchImage extends StatelessWidget {
  var imagekey;
  String image;
  double height;
  DetailsNetworkCatchImage(
      {required this.imagekey,
      required this.image,
      required this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CachedNetworkImage(
        key: Key(imagekey),
        imageUrl: image,
        imageBuilder: (context, imageProvider) => FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            //child: Image(image: imageProvider),
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover
                  //colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                  ),
            ),
          ),
        ),
        placeholder: (context, url) => SizedBox(
          height: height,
          child: Shimmer(
            duration: const Duration(seconds: 3), //Default value
            interval: const Duration(
                seconds: 0), //Default value: Duration(seconds: 0)
            color: const Color.fromARGB(255, 109, 105, 105), //Default value
            colorOpacity: 0, //Default value
            enabled: true, //Default value
            direction: const ShimmerDirection.fromLTRB(), //Default Value
            child: Container(
              color: const Color.fromARGB(255, 248, 248, 250),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/noimage.jpg'))),
        ),
      ),
    );
  }
}
