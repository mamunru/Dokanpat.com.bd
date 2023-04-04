import 'package:dokanpat/controllers/mydrawer_controller.dart';
import 'package:dokanpat/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<MyDrawerController>(builder: (cc) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(child: Text(cc.data.value.toString())));
      }),
    );
  }
}
