import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetDailogPage extends StatelessWidget {
  String? title;
  String? details;
  GetDailogPage({required this.title, required this.details, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Get.defaultDialog(
              title: title.toString(),
              middleText: details.toString(),
              backgroundColor: Colors.teal,
              titleStyle: TextStyle(color: Colors.white),
              middleTextStyle: TextStyle(color: Colors.white),
              radius: 30);
        },
      ),
    );
  }
}
