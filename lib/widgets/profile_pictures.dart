// ignore_for_file: must_be_immutable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/constants.dart';

final constantValues = Get.find<Constants>();
var userInfo = GetStorage();

class UserProfilePicture extends StatelessWidget {
  UserProfilePicture({
    Key? key,
    required this.image,
    required this.radius,
    required this.onClicked,
  }) : super(key: key);
  final String image;
  final double radius;
  final VoidCallback onClicked;

  final constantValues = Get.find<Constants>();

  @override
  Widget build(BuildContext context) {
    return buildImage();
  }

  Widget buildImage() {
    return CircleAvatar(
      radius: radius,
      backgroundColor: userInfo.read("isDarkTheme")
          ? constantValues.darkColor2
          : Colors.white,
      backgroundImage: !image.startsWith('a')
          ? NetworkImage(image)
          : AssetImage(image) as ImageProvider,
      child: InkWell(
        onTap: onClicked,
      ),
    );
  }
}

class AdminProfilePicture extends StatelessWidget {
  AdminProfilePicture({
    Key? key,
    required this.radius,
  }) : super(key: key);
  final double radius;

  final constantValues = Get.find<Constants>();

  @override
  Widget build(BuildContext context) {
    return buildImage();
  }

  Widget buildImage() {
    return CircleAvatar(
      radius: radius,
      backgroundColor: userInfo.read("isDarkTheme")
          ? constantValues.darkColor2
          : Colors.white,
      backgroundImage: userInfo.read("isDarkTheme")
          ? const AssetImage('assets/icons/admin_white.png')
          : const AssetImage('assets/icons/admin_black.png'),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  ProfilePicture({
    Key? key,
    required this.imagePath,
    required this.radius,
    required this.onClicked,
    required this.pressChangePicture,
  }) : super(key: key);

  final String imagePath;
  final double radius;
  final VoidCallback onClicked;
  late Function pressChangePicture;

  @override
  Widget build(BuildContext context) {
    final constantValues = Get.find<Constants>();
    return DottedBorder(
      borderType: BorderType.Circle,
      dashPattern: const [8, 6],
      color: constantValues.whiteColor,
      radius: const Radius.circular(30),
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: constantValues.transparentColor),
        child: buildImage(),
      ),
    );
  }

  Widget buildImage() {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : const AssetImage("assets/icons/admin_white.png");

    return CircleAvatar(
      radius: radius,
      backgroundColor: constantValues.transparentColor,
      backgroundImage: image as ImageProvider,
      child: InkWell(
        onTap: onClicked,
      ),
    );
  }

  Widget buildEditIcon(BuildContext context, Color color) => CircleAvatar(
        backgroundColor: constantValues.whiteColor,
        radius: 20,
        child: CircleAvatar(
          backgroundColor: color,
          radius: 15,
          child: IconButton(
            tooltip: "Edit",
            icon: const Icon(
              Icons.edit,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () {
              pressChangePicture();
            },
          ),
        ),
      );
}
