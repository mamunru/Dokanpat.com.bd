import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../configs/themes/custome_text_style.dart';


class ProfileTitle extends StatelessWidget {
  final  tittle;
  final Widget  icon;
  final VoidCallback? onTap;
  //bool option = false;

  ProfileTitle( {required this.tittle,required this.icon,required this.onTap  ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: icon
                            ),
                            Expanded(child: Text(tittle,
                            style: profileTitle)),
                            FaIcon(FontAwesomeIcons.angleRight, size: 20,),
                          ],
                        ),
                      ),
      ),
    );
  }
}