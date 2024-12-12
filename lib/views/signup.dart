import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:giggbox/views/signup01.dart';
import 'package:giggbox/views/signup02.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';
import '../controllers/responsive.dart';
import '../widgets/buttons.dart';
import '../widgets/custom_app_bars.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  Dio dio = Dio();
  final PageController pageController = PageController();
  int currentPage = 0;
  bool isLastPage = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var mainFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            fontSize: size.width * 0.02,
            color: constantValues.whiteColor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal));
    var subFont = GoogleFonts.archivo(
        textStyle: TextStyle(
            color: constantValues.whiteColor,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal));
    return Scaffold(
      backgroundColor: constantValues.bgColor,
      appBar: CustomAppBar(userInfo: userInfo, constantValues: constantValues),
      body: SafeArea(
          child: Responsive(
              isExtraLargeScreen:
                  isExtraLargeScreen(context, size, mainFont, subFont),
              isTablet: isTablet(context, size, mainFont, subFont),
              isMobile: isMobile(context, size, mainFont, subFont))),
    );
  }

  Widget isExtraLargeScreen(
      BuildContext context, Size size, var font1, var font2) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
              isLastPage = (index == 1);
            });
          },
          children: [
            AccountCreation(
              formKey: _formKey,
              usernameController: usernameController,
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
            ),
            const WhoAreYou(),
          ],
        ),
        !isLastPage
            ? Column(
                children: [
                  SizedBox(height: size.height * 0.82),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonA2(
                          width: size.width * 0.1,
                          bgColor: constantValues.primaryColor,
                          textColor: constantValues.whiteColor,
                          text: "Continue",
                          authenticate: () async {
                            final checkForm = _formKey.currentState!;
                            if (currentPage == 0) {
                              if (checkForm.validate()) {
                                if (userInfo.read("agreeToTerms") == true) {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackBar(
                                          "You must agree to T&C to proceed!"));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar(
                                        "Credentials cannot be blank!"));
                              }
                            }
                          }),
                      SizedBox(width: size.width * 0.04),
                    ],
                  ),
                ],
              )
            : Column(
                children: [
                  SizedBox(height: size.height * 0.82),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonA2(
                          width: size.width * 0.1,
                          bgColor: constantValues.transparentColor,
                          textColor: constantValues.whiteColor,
                          text: "Previous",
                          authenticate: () async {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutBack);
                          }),
                      SizedBox(width: size.width * 0.01),
                      ButtonA(
                        width: size.width * 0.1,
                        bgColor: constantValues.primaryColor,
                        textColor: constantValues.whiteColor,
                        text: "Sign Up",
                        authenticate: () async {
                          await signup();
                        },
                      ),
                      SizedBox(width: size.width * 0.04),
                    ],
                  ),
                ],
              ),
      ],
    );
  }

  Widget isTablet(BuildContext context, Size size, var font1, var font2) {
    return const Text("");
  }

  Widget isMobile(BuildContext context, Size size, var font1, var font2) {
    return const Text("");
  }

  customSnackBar(String message) => SnackBar(
        content: Row(
          children: [
            Icon(Icons.info, color: constantValues.whiteColor),
            const SizedBox(width: 10),
            Text(message,
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

  signup() async {
    if (userInfo.read("accountType") != "") {
      userInfo.read("performerData")["stageName"] != null
          ? context.goNamed("performer_profile")
          : context.goNamed("performer_profile_edit");
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar("Pick a category!"));
    }
  }
}
