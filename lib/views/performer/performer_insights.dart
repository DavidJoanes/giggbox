import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:giggbox/widgets/title_case.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/constants.dart';
import '../../controllers/responsive.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_charts.dart';
import 'performer_frame.dart';

class PerformerInsights extends StatefulWidget {
  const PerformerInsights({super.key});

  @override
  State<PerformerInsights> createState() => _PerformerInsightsState();
}

class _PerformerInsightsState extends State<PerformerInsights> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var mainFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            fontSize: size.width * 0.02,
            color: constantValues.whiteColor,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal));
    var subFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            fontSize: size.width * 0.015,
            color: constantValues.whiteColor,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal));
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
        body: SafeArea(
            child: SingleChildScrollView(
          child: Responsive(
              isExtraLargeScreen:
                  isExtraLargeScreen(context, size, mainFont, subFont),
              isTablet: isTablet(context, size, mainFont, subFont),
              isMobile: isMobile(context, size, mainFont, subFont)),
        )));
  }

  Widget isExtraLargeScreen(
      BuildContext context, Size size, var font1, var font2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Column(
        children: [
          //Insights
          SizedBox(
            width: size.width,
            child: ListTile(
              title: Row(
                children: [
                  Text(constantValues.insightText1, style: font1),
                  SizedBox(width: size.width * 0.01),
                  performerStatus(
                    size.width * 0.08,
                  ),
                ],
              ),
              trailing: ButtonA3(
                width: size.width * 0.05,
                bgColor: constantValues.primaryColor,
                textColor: constantValues.whiteColor,
                text: "Share",
                authenticate: () {},
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          const Divider(),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            height: size.height * 0.5,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(constantValues.insightText2, style: font2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLineChart(size: size),
                    const SizedBox(),
                    CustomBarChart(size: size),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget isTablet(BuildContext context, Size size, var font1, var font2) {
    return const Column();
  }

  Widget isMobile(BuildContext context, Size size, var font1, var font2) {
    return const Column();
  }

  performerStatus(double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: constantValues.whiteColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.circle,
            size: 10,
            color: constantValues.performerStatus == "Active"
                ? constantValues.primaryColor
                : constantValues.errorColor,
          ),
          const SizedBox(width: 4),
          Text(constantValues.performerStatus)
        ],
      ),
    );
  }
}
