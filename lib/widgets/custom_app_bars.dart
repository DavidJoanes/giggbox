import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.userInfo,
    required this.constantValues,
  });
  final GetStorage userInfo;
  final Constants constantValues;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 700) {
        return AppBar(
          backgroundColor: constantValues.transparentColor,
          foregroundColor: constantValues.transparentColor,
          elevation: 0,
          centerTitle: true,
          leadingWidth: size.width * 0.2,
          leading: Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
                onTap: () => context.goNamed("client_home"),
                child: SizedBox(
                  width: size.width * 0.05,
                  child: Row(
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
                    ],
                  ),
                )),
          ),
          actions: const [],
        );
      } else {
        return AppBar(
          backgroundColor: constantValues.transparentColor,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset("assets/icons/giggbox.png", scale: 3),
          ),
        );
      }
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
