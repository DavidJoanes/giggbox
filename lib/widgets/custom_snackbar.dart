import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';

final constantValues = Get.find<Constants>();

var sessionExpiry = SnackBar(
  content: Row(
    children: [
      Icon(Icons.info, color: constantValues.whiteColor),
      const SizedBox(width: 10),
      Text("Your session has expired! Please signin.",
          maxLines: 5,
          style: GoogleFonts.archivo(
              textStyle: TextStyle(
                  color: constantValues.whiteColor,
                  fontWeight: FontWeight.w500))),
    ],
  ),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  showCloseIcon: true,
  closeIconColor: constantValues.whiteColor,
  duration: const Duration(seconds: 3),
  backgroundColor: constantValues.darkColor2,
);
