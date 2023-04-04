import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:dokanpat/controllers/token_controller.dart';
import 'package:dokanpat/widgets/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(76, 223, 220, 220),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Message'),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<TokenController>(builder: (controller) {
          return Container(
            //height: MediaQuery.of(context).size.height,
            child: controller.onnotification
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  )
                : controller.sms.value.isEmpty
                    ? EmptyPage(title: 'Empty Notification !!')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: controller.sms.value.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                Get.bottomSheet(Container(
                                  height:
                                      MediaQuery.of(context).size.height * .50,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          e.title.toString(),
                                          style: headerText3,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            e.message.toString(),
                                            style: detailText16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        e.image.toString().length > 8
                                            ? Image.network(
                                                e.image.toString(),
                                                height: 200,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ));
                              },
                              child: Card(
                                color: e.id!.isEven
                                    ? Colors.white60
                                    : Color.fromARGB(255, 188, 184, 235),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        e.title.toString(),
                                        style: headerText2,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        e.message.toString(),
                                        style: detailText16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
          );
        }),
      ),
    );
  }
}
