import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/orderhistory_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ReviewPage extends StatefulWidget {
  int productid;
  ReviewPage({required this.productid, super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  String frating = '5';
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: GetBuilder<OrderHistoryContriller>(builder: (orderhistory) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const SizedBox(height: 10,),
              SizedBox(
                height: 30,
                child: Stack(
                  children: [
                    Positioned(
                        right: 10,
                        top: 2,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: FaIcon(
                            FontAwesomeIcons.xmark,
                            size: 22,
                            color: Colors.red,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                child: RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 22,
                  ),
                  onRatingUpdate: (rating) {
                    //print(rating);
                    setState(() {
                      frating = rating.toString();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  minLines: 1,
                  //maxLines: null,
                  controller: message,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    labelText: 'Enter Your Message',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              orderhistory.reviewloading
                  ? Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.red,
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                    )
                  : GestureDetector(
                      onTap: () {
                        orderhistory.setreview(
                            id: widget.productid,
                            rating: frating,
                            text: message.text);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            'Submit',
                            style: detailText16.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
            ],
          );
        }),
      ),
    );
  }
}
