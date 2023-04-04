import 'package:flutter/material.dart';

import '../configs/themes/custome_text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TitleBar extends StatelessWidget {
  String title;
  bool up = false;
  VoidCallback? callback;
  TitleBar(
      {required this.title,
      required this.up,
      required this.callback,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration:
            const BoxDecoration(color: Color.fromARGB(31, 131, 113, 113)),
        child: InkWell(
            child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: Text(
              title.toUpperCase(),
              style: detailText16,
            )),
            up
                ? const FaIcon(FontAwesomeIcons.angleUp)
                : const FaIcon(FontAwesomeIcons.angleDown),
            const SizedBox(
              width: 10,
            )
          ],
        )),
      ),
    );
  }
}
