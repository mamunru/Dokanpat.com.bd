import 'package:dokanpat/configs/themes/app_colors.dart';
import 'package:dokanpat/configs/themes/ui_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextStyle CartTitle(context) => TextStyle(
    color: UIparamenters.isDarkMode()
        ? Theme.of(context).textTheme.bodyText1!.color
        : Theme.of(context).primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold);

TextStyle CartTitleSmall(context) => TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

const detailText = TextStyle(fontSize: 12);

const detailText14 = TextStyle(fontSize: 14);
const detailText15 = TextStyle(fontSize: 15);
const detailText16 = TextStyle(fontSize: 16, color: Colors.black);
const detailText18 = TextStyle(fontSize: 18, color: Colors.black);

const titleText = TextStyle(fontSize: 15, color: Colors.black54);

const profileTitle = TextStyle(fontSize: 18, color: Colors.black54);

const priceText =
    TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500);

const headerText = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: onSurfaceTextColor);

const headerText2 = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w600, color: onSurfaceTextColor);

const headerText3 = TextStyle(
    fontSize: 18, fontWeight: FontWeight.w400, color: onSurfaceTextColor);

const headerText4 = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w300, color: onSurfaceTextColor);

const smallText = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, color: onSurfaceTextColor);
const verysmallText = TextStyle(fontSize: 13, color: onSurfaceTextColor);
