import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/constants.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/profile_pictures.dart';
import '../../widgets/title_case.dart';
import 'performer_bookings.dart';
import 'performer_insights.dart';
import 'performer_messages.dart';
import 'performer_profile_edit.dart';

class PerformerFrame extends StatefulWidget {
  const PerformerFrame({
    super.key,
    // required this.navigationShell,
  });
  // final StatefulNavigationShell navigationShell;

  @override
  State<PerformerFrame> createState() => _PerformerFrameState();
}

class _PerformerFrameState extends State<PerformerFrame> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  late int currentIndex = 0;

  late List pages = <Widget>[
    userInfo.read("performerData")["stageName"] != null
        ? const PerformerProfileEdit()
        : const PerformerProfileEdit(),
    const PerformerInsights(),
    const PerformerBookings(),
    const PerformerMessages(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                currentIndex = value;
                userInfo.write("currentIndex", value);
              });
            },
            tab0: userInfo.read("currentIndex") == 0 ? true : false,
            tab1: userInfo.read("currentIndex") == 1 ? true : false,
            tab2: userInfo.read("currentIndex") == 2 ? true : false,
            tab3: userInfo.read("currentIndex") == 3 ? true : false,
          ),
        ),
        body: pages[userInfo.read("currentIndex")]);
  }

  Widget isExtraLargeScreen() {
    return pages[userInfo.read("currentIndex")];
  }

  Widget isTablet() {
    return pages[userInfo.read("currentIndex")];
  }

  Widget isMobile() {
    return pages[userInfo.read("currentIndex")];
  }
}

class LeftChild extends StatefulWidget {
  LeftChild({
    super.key,
    required this.fullName,
    required this.emailAddress,
    required this.currentTab,
    required this.tab0,
    required this.tab1,
    required this.tab2,
    required this.tab3,
  });
  final String fullName;
  final String emailAddress;
  late Function currentTab;
  late bool tab0;
  late bool tab1;
  late bool tab2;
  late bool tab3;

  @override
  State<LeftChild> createState() => _LeftChildState();
}

class _LeftChildState extends State<LeftChild> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  final fontStyle1a =
      GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.white));
  late Function currentTab = (value) {
    value = userInfo.read("currentIndex");
  };
  late bool tab0 = widget.tab0;
  late bool tab1 = widget.tab1;
  late bool tab2 = widget.tab2;
  late bool tab3 = widget.tab3;

  // void _onTap(index) {
  //   widget.navigationShell.goBranch(
  //     index,
  //     initialLocation: index == widget.navigationShell.currentIndex,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final fontStyle1e = GoogleFonts.lato(textStyle: const TextStyle());
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 40,
      child: Container(
        width: size.width,
        color: userInfo.read("isDarkTheme")
            ? constantValues.darkColor2
            : constantValues.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              customHeader(
                  context,
                  size,
                  "${userInfo.read("performerData")["stageName"] ?? ''}"
                      .toTitleCase2(),
                  "@${userInfo.read("performerData")["userName"] ?? ''}",
                  tab0, () {
                setState(() {
                  tab0 = true;
                  tab1 = false;
                  tab2 = false;
                  tab3 = false;
                  widget.currentTab(0);
                });
                context.goNamed("performer_profile");
                // _onTap(userInfo.read("currentIndex"));
              }),
              SizedBox(height: size.height * 0.02),
              const Divider(),
              SizedBox(
                height: size.height * 0.6,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.005),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.02),
                        customNavBar(
                            context, size, Icons.dashboard, "Insights", tab1,
                            () {
                          setState(() {
                            tab0 = false;
                            tab1 = true;
                            tab2 = false;
                            tab3 = false;
                            widget.currentTab(1);
                          });
                          context.goNamed("performer_insights");
                          // _onTap(userInfo.read("currentIndex"));
                        }),
                        SizedBox(height: size.height * 0.02),
                        customNavBar(
                            context,
                            size,
                            Icons.calendar_month_outlined,
                            "Bookings",
                            tab2, () {
                          setState(() {
                            tab0 = false;
                            tab1 = false;
                            tab2 = true;
                            tab3 = false;
                            widget.currentTab(2);
                          });
                          context.goNamed("performer_bookings");
                          // _onTap(userInfo.read("currentIndex"));
                        }),
                        SizedBox(height: size.height * 0.02),
                        customNavBar(context, size, Icons.message_rounded,
                            "Messages", tab3, () {
                          setState(() {
                            tab0 = false;
                            tab1 = false;
                            tab2 = false;
                            tab3 = true;
                            widget.currentTab(3);
                          });
                          context.goNamed("performer_messages");
                          // _onTap(userInfo.read("currentIndex"));
                        }),
                        SizedBox(height: size.height * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                width: size.width * 0.21,
                child: ListTile(
                  trailing: GestureDetector(
                      child: const Text("Logout"),
                      onTap: () async {
                        return showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Confirm Logout?",
                                  style: fontStyle1e,
                                  textAlign: TextAlign.center,
                                ),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ButtonA2(
                                        width: 100,
                                        bgColor: constantValues.errorColor,
                                        textColor: constantValues.whiteColor,
                                        text: "No",
                                        authenticate: () =>
                                            Navigator.of(context).pop()),
                                    ButtonA(
                                        width: 100,
                                        bgColor: constantValues.secondaryColor,
                                        textColor: constantValues.whiteColor,
                                        text: "Yes",
                                        authenticate: () async {
                                          await signout();
                                        }),
                                  ],
                                ),
                              );
                            });
                      }),
                ),
              ),
              SizedBox(height: size.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  Widget customHeader(
    BuildContext context,
    var size,
    String name,
    String username,
    bool selectedTab,
    VoidCallback onClicked,
  ) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: 5, horizontal: size.width * 0.01),
          decoration: BoxDecoration(
            color: selectedTab
                ? constantValues.secondaryColor2
                : constantValues.transparentColor,
            borderRadius: BorderRadius.circular(size.width * 0.01),
            border: Border.all(
              width: 1,
              color: selectedTab
                  ? constantValues.secondaryColor2
                  : constantValues.transparentColor,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: UserProfilePicture(
              radius: 20,
              image: "assets/icons/admin_white.png",
              onClicked: () {},
            ),
            title: Text(name,
                style: TextStyle(
                  color: selectedTab
                      ? constantValues.primaryColor
                      : constantValues.whiteColor,
                )),
            subtitle: Text(
              username,
            ),
          ),
        ),
      );

  Widget customNavBar(BuildContext context, var size, IconData icon,
      String title, bool selectedTab, Function onClicked) {
    return SizedBox(
      height: size.height * 0.08,
      child: ListTile(
        horizontalTitleGap: size.width * 0.01,
        minVerticalPadding: size.height * 0.02,
        leading: Icon(icon,
            color: selectedTab
                ? constantValues.primaryColor
                : constantValues.whiteColor,
            size: 20),
        title: Text(title,
            style: GoogleFonts.archivo(
                textStyle: TextStyle(
              color: selectedTab
                  ? constantValues.primaryColor
                  : constantValues.whiteColor,
            ))),
        tileColor: selectedTab
            ? constantValues.secondaryColor2
            : constantValues.transparentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          onClicked();
          context.pop();
        },
      ),
    );
  }

  signout() async {
    context.pop();
    context.pop();
    userInfo.write("performerData", {});
    context.goNamed("signin");
  }
}
