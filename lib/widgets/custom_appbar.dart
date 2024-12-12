import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/constants.dart';

final constantValues = Get.find<Constants>();
var userInfo = GetStorage();

AppBar performerAppBar(BuildContext context, Size size) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icons/giggbox2.png", scale: 25),
        RichText(
          text: TextSpan(
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                      fontSize: size.width * 0.018,
                      color: userInfo.read("isDarkTheme")
                          ? constantValues.whiteColor
                          : constantValues.darkColor,
                      fontWeight: FontWeight.w700)),
              children: [
                const TextSpan(
                  text: "Gigg",
                ),
                TextSpan(
                  text: "Box",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: size.width * 0.018,
                      textStyle: TextStyle(
                          color: constantValues.primaryColor,
                          fontWeight: FontWeight.w700)),
                ),
              ]),
        ),
        SizedBox(width: size.width * 0.04),
      ],
    ),
  );
}
