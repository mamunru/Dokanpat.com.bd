// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/model/productimage_model.dart';
import 'package:dokanpat/widgets/images/details.dart';
import 'package:dokanpat/widgets/images/gallery.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

class ProductImage extends StatefulWidget {
  double height;
  List<ProductImageModel> imageList;
  ProductImage(this.height, {required this.imageList, Key? key})
      : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImage();
}

class _ProductImage extends State<ProductImage> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryImageViewWrapper(
                        titleGallery: 'Product Image',
                        galleryItems: widget.imageList,
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        initialIndex: _current,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  );
                  // Navigator.of(context).push(new MaterialPageRoute<Null>(
                  //     builder: (BuildContext context) {
                  //       return new GalleryIamge(
                  //         imagelist: widget.imageList,
                  //       );
                  //     },
                  //     fullscreenDialog: true));
                },
                child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                        height: widget.height - 100,
                        viewportFraction: 1.0,
                        initialPage: _current,
                        enableInfiniteScroll: true,

                        //reverse: true,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    items: widget.imageList
                        .map((item) => Container(
                              //margin: EdgeInsets.all(5.0),
                              child: DetailsNetworkCatchImage(
                                  imagekey: item.name,
                                  image: item.src.toString(),
                                  height: widget.height - 100),
                            ))
                        .toList()),
              ),
              Positioned(
                //top: 5,
                top: widget.height - 140,
                left: MediaQuery.of(context).size.width / 2.2,
                child: Center(
                  child: Container(
                    width: 60,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      (_current + 1).toString() +
                          '/' +
                          widget.imageList.length.toString(),
                      style: detailText16.copyWith(color: Colors.white),
                    ),
                  ),

                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: widget.imageList.asMap().entries.map((entry) {
                  //     return GestureDetector(
                  //       onTap: () => _controller.animateToPage(entry.key),
                  //       child: Container(
                  //         width: _current == entry.key ? 25 : 11.0,
                  //         height: 11.0,
                  //         margin: const EdgeInsets.symmetric(
                  //             vertical: 8.0, horizontal: 4.0),
                  //         decoration: BoxDecoration(
                  //             // shape: BoxShape.circle,
                  //             borderRadius: BorderRadius.circular(50),
                  //             color: (Theme.of(context).brightness ==
                  //                         Brightness.light
                  //                     ? Colors.white
                  //                     : const Color.fromARGB(255, 54, 41, 233))
                  //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                ),
              ),
            ],
          ),
          Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: widget.imageList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    var item = widget.imageList[index];
                    return GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(index);
                        setState(() {
                          _current = index;
                        });
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                        // decoration: BoxDecoration(
                        //     border: Border.all(
                        //         width: 4,
                        //         color: _current == index
                        //             ? Colors.red
                        //             : Colors.transparent)),
                        child: NetworkCatchImage(
                          imagekey: item.name,
                          image: item.src.toString(),
                          height: 80,
                          width: 80,
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
