import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();
  String oldtext = '';

  @override
  Widget build(BuildContext context) {
    ProductController product = Get.find();
    if (product.searchproducts.value.length != 0) {
      _searchController = TextEditingController(text: product.oldsearch);
    }
    _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length));
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) async {
                  await Future.delayed(const Duration(seconds: 3));
                  ProductController productController = Get.find();
                  if (oldtext != _searchController.text) {
                    setState(() {
                      oldtext = _searchController.text;
                    });
                    productController.searchProduct(_searchController.text,
                        sortBy: 'popularity');
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 2.0,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                // _filterItems(_searchController.text);
                ProductController productController = Get.find();
                if (oldtext != _searchController.text) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  productController.searchProduct(_searchController.text,
                      sortBy: 'popularity');
                }
              },
              icon: Icon(
                Icons.search,
                size: 22,
              ),
            ),
          ],
        ),
      ),
      // child: Container(
      //   //  height: 80,
      //   width: MediaQuery.of(context).size.width,
      //   //color: Colors.white,
      //   child: Column(
      //     children: [
      //       // const SizedBox(
      //       //   height: 30,
      //       // ),
      //       Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           // const BackButton(),
      //           // const SizedBox(
      //           //   width: 10,
      //           // ),
      //           // Container(
      //           //   width: MediaQuery.of(context).size.width * .60,
      //           //   height: 32,
      //           //   margin: EdgeInsets.only(top: 5),
      //           //   decoration: BoxDecoration(
      //           //       borderRadius: BorderRadius.circular(50),
      //           //       border: Border.all(color: Colors.red)),
      //           //   child: Row(
      //           //     crossAxisAlignment: CrossAxisAlignment.start,
      //           //     children: [
      //           //       const SizedBox(
      //           //         width: 10,
      //           //       ),
      //           //       Container(
      //           //         margin: EdgeInsets.only(top: 10),
      //           //         height: 30,
      //           //         width: MediaQuery.of(context).size.width * .48,
      //           //         child: TextField(
      //           //           style: detailText16,
      //           //           controller: _searchController,
      //           //           decoration: InputDecoration(
      //           //             focusColor: Colors.black,
      //           //             border: InputBorder.none,
      //           //             hintText: "Search...",
      //           //             hintStyle: const TextStyle(
      //           //               color: Colors.black,
      //           //             ),
      //           //           ),
      //           //         ),
      //           //       ),
      //           //       Container(
      //           //         width: 10,
      //           //         child: IconButton(
      //           //             onPressed: () {
      //           //               _searchController.clear();
      //           //             },
      //           //             icon: Icon(Icons.clear)),
      //           //       ),
      //           //       SizedBox(
      //           //         width: 10,
      //           //       )
      //           //     ],
      //           //   ),
      //           // ),
      //           Card(
      //             child: Container(
      //               width: MediaQuery.of(context).size.width * .45,
      //               height: 40,
      //               padding: const EdgeInsets.only(
      //                 top: 15,
      //               ),
      //               // decoration: BoxDecoration(
      //               //     border: Border.all(color: Colors.redAccent)),
      //               child: TextFormField(
      //                 controller: _searchController,
      //                 style: const TextStyle(fontSize: 16),
      //                 onChanged: (value) async {
      //                   await Future.delayed(const Duration(seconds: 3));
      //                   ProductController productController = Get.find();
      //                   if (oldtext != _searchController.text) {
      //                     setState(() {
      //                       oldtext = _searchController.text;
      //                     });
      //                     productController.searchProduct(
      //                         _searchController.text,
      //                         sortBy: 'popularity');
      //                   }
      //                 },
      //                 decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     hintText: "Search Here",
      //                     hintStyle: TextStyle(color: Colors.grey[400])),
      //               ),
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: () {

      //               //print(_searchController.text);
      //             },
      //             child: const Card(
      //               color: Color.fromARGB(0, 253, 30, 30),
      //               child: SizedBox(
      //                 width: 63,
      //                 height: 40,
      //                 // margin: EdgeInsets.only(top: 5),
      //                 // decoration: BoxDecoration(
      //                 //     borderRadius: BorderRadius.circular(5),
      //                 //     border: Border.all(color: Colors.red)),
      //                 child: Center(
      //                   child: Text(
      //                     'Search',
      //                     style: headerText4,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
