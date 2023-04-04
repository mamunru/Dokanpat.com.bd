import 'package:dokanpat/configs/themes/custome_text_style.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  String title;
  EmptyPage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/empty_search.png',
                    ),
                    fit: BoxFit.fitHeight)),
          ),
          Positioned(
              top: 300,
              left: 0,
              child: Visibility(
                  visible: true,
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        title.toString(),
                        maxLines: 2,
                        style: headerText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
