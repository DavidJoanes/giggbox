import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/constants.dart';

final constantValues = Get.find<Constants>();
var userInfo = GetStorage();

class TextFieldContainer extends StatelessWidget {
  final double width;
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.width,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: width,
      decoration: BoxDecoration(
        color: userInfo.read("isDarkTheme")
            ? constantValues.darkColor2
            : constantValues.whiteColor2,
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}

class TextFieldContainer2 extends StatelessWidget {
  final double width;
  final Widget child;
  const TextFieldContainer2({
    Key? key,
    required this.width,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: width,
      decoration: BoxDecoration(
        color: constantValues.transparentColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
