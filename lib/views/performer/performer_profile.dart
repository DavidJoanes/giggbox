import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:giggbox/main.dart';
import 'package:giggbox/widgets/title_case.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/constants.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_appbar.dart';
import 'performer_frame.dart';

class PerformerProfile extends StatefulWidget {
  const PerformerProfile({super.key});

  @override
  State<PerformerProfile> createState() => _PerformerProfileState();
}

class _PerformerProfileState extends State<PerformerProfile> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  // late int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: constantValues.darkColor,
        appBar: performerAppBar(
          context,
          size,
        ),
        drawer: Drawer(
          backgroundColor: constantValues.darkColor,
          width: size.width * 0.2,
          child: LeftChild(
            fullName: "${userInfo.read("performerData")["stageName"] ?? ''}"
                .toTitleCase2(),
            emailAddress: userInfo.read("performerData")["userName"] ?? '',
            currentTab: (value) {
              setState(() {
                // currentIndex = value;
                userInfo.write("currentIndex", value);
              });
            },
            tab0: userInfo.read("currentIndex") == 0 ? true : false,
            tab1: userInfo.read("currentIndex") == 1 ? true : false,
            tab2: userInfo.read("currentIndex") == 2 ? true : false,
            tab3: userInfo.read("currentIndex") == 3 ? true : false,
          ),
        ),
        body: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Performer Profile"),
            ButtonA3(
              width: 100,
              bgColor: constantValues.primaryColor,
              textColor: constantValues.whiteColor,
              text: "Edit",
              authenticate: () => context.goNamed("performer_profile_edit"),
            )
          ],
        )));
  }
}
