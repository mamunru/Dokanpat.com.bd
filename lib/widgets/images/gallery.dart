// import 'package:flutter/material.dart';
// import 'package:galleryimage/galleryimage.dart';

// import '../../model/product_model.dart';

// class GalleryIamge extends StatelessWidget {
//   List<Images> imagelist;
//   GalleryIamge({required this.imagelist, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.red, size: 25),
//       ),
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           child: GalleryImage(
//             imageUrls: imagelist.map((e) => e.src.toString()).toList(),
//             key: Key('image'),

//             // galleryType: 0,
//             // //shortImage: false,
//             // width: MediaQuery.of(context).size.width,
//             // height: MediaQuery.of(context).size.height / 2,
//             // imageDecoration:
//             //     BoxDecoration(border: Border.all(color: Colors.white)),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/model/productimage_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// to view image in full screen
class GalleryImageViewWrapper extends StatefulWidget {
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final int? initialIndex;
  final PageController pageController;
  final List<ProductImageModel> galleryItems;
  final Axis scrollDirection;
  final String? titleGallery;

  GalleryImageViewWrapper({
    Key? key,
    this.loadingBuilder,
    this.titleGallery,
    this.backgroundDecoration,
    this.initialIndex,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  })  : pageController = PageController(initialPage: initialIndex ?? 0),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GalleryImageViewWrapperState();
  }
}

class _GalleryImageViewWrapperState extends State<GalleryImageViewWrapper> {
  final minScale = PhotoViewComputedScale.contained * 0.8;
  final maxScale = PhotoViewComputedScale.covered * 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black, size: 20),
        title: Text(widget.titleGallery ?? "Gallery"),
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: _buildImage,
          itemCount: widget.galleryItems.length,
          loadingBuilder: widget.loadingBuilder,
          backgroundDecoration: widget.backgroundDecoration,
          pageController: widget.pageController,
          scrollDirection: widget.scrollDirection,
        ),
      ),
    );
  }

// build image with zooming
  PhotoViewGalleryPageOptions _buildImage(BuildContext context, int index) {
    final ProductImageModel item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions.customChild(
      child: CachedNetworkImage(
        key: Key(item.name.toString()),
        imageUrl: item.src.toString(),
        placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).focusColor,
        )),
        errorWidget: (context, url, error) => Container(
          // height: height,
          //width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/noimage.jpg'))),
        ),
      ),
      initialScale: PhotoViewComputedScale.contained,
      minScale: minScale,
      maxScale: maxScale,
      heroAttributes: PhotoViewHeroAttributes(tag: item.name.toString()),
    );
  }
}
