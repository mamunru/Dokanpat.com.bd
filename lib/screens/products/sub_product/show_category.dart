import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/token_controller.dart';
import 'package:dokanpat/model/category_model.dart';
import 'package:dokanpat/model/product_model.dart';
import 'package:dokanpat/widgets/images/network_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowCategory extends StatelessWidget {
  var category;
  ShowCategory({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // body: GridView.builder(
      //     scrollDirection: Axis.horizontal,
      //     itemCount: category.length,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2,
      //       childAspectRatio: MediaQuery.of(context).size.width / (250),
      //     ),
      //     itemBuilder: (context, index) {
      //       Option category[index] = category[index];
      //       return;
      //     }),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                for (int index = 0; index < 6; index++)
                  Container(
                    width: MediaQuery.of(context).size.width / 6 - 4,
                    height: 115,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color.fromARGB(60, 114, 112, 112))),
                    child: InkWell(
                      onTap: () {
                        print(MediaQuery.of(context).size.width);
                        Get.toNamed(
                            '/product/category/${category[index].cid}/${category[index].pid}/',
                            arguments: category[index]);
                      },
                      child: SizedBox(
                        //color: Colors.amber,
                        width: 115,
                        //height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5.0)),
                                // padding:const EdgeInsets.only(top: 5,left: 5,right: 5.0),
                                child: NetworkCatchImage(
                                  imagekey: category[index].name,
                                  image: category[index].src.toString().length >
                                          5
                                      ? category[index].src.toString()
                                      : 'https://st3.depositphotos.com/23594922/31822/v/1600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                                  height: 80,
                                  //width: 100,
                                )),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Center(
                                  child: Text(
                                category[index].name.toString(),
                                maxLines: 2,
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                for (int index = 6; index < 12; index++)
                  Container(
                    width: MediaQuery.of(context).size.width / 6 - 4,
                    margin: const EdgeInsets.all(2),
                    height: 115,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color.fromARGB(60, 114, 112, 112))),
                    child: InkWell(
                      onTap: () {
                        print(MediaQuery.of(context).size.width);
                        Get.toNamed(
                            '/product/category/${category[index].cid}/${category[index].pid}',
                            arguments: category[index]);
                      },
                      child: SizedBox(
                        //color: Colors.amber,
                        width: MediaQuery.of(context).size.width / 6 - 4,
                        //height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5.0)),
                                // padding:const EdgeInsets.only(top: 5,left: 5,right: 5.0),
                                child: NetworkCatchImage(
                                  imagekey: category[index].name,
                                  image: category[index].src.toString().length >
                                          5
                                      ? category[index].src.toString()
                                      : 'https://st3.depositphotos.com/23594922/31822/v/1600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                                  height: 80,
                                  width:
                                      MediaQuery.of(context).size.width / 6 - 4,
                                )),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Center(
                                  child: Text(
                                category[index].name.toString(),
                                maxLines: 2,
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
