import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:giggbox/widgets/title_case.dart';

import '../../controllers/constants.dart';
import '../../widgets/custom_appbar.dart';
import 'performer_frame.dart';

class PerformerBookings extends StatefulWidget {
  const PerformerBookings({super.key});

  @override
  State<PerformerBookings> createState() => _PerformerBookingsState();
}

class _PerformerBookingsState extends State<PerformerBookings> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
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
                userInfo.write("currentIndex", value);
              });
            },
            tab0: userInfo.read("currentIndex") == 0 ? true : false,
            tab1: userInfo.read("currentIndex") == 1 ? true : false,
            tab2: userInfo.read("currentIndex") == 2 ? true : false,
            tab3: userInfo.read("currentIndex") == 3 ? true : false,
          ),
        ),
        body: const Center(child: Text("Performer Bookings")));
  }
}
