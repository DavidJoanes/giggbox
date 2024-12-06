import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controllers/constants.dart';
import '../controllers/responsive.dart';
import '../models/theme_model.dart';
import '../widgets/buttons.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/input_fields.dart';
import '../widgets/password_fields.dart';
import '../widgets/custom_snackbar.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (userInfo.read("rememberMe")) {
      setState(() {
        emailController.text = userInfo.read("tempEmail");
        passwordController.text = userInfo.read("tempPassword");
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
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
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //     color: constantValues.secondaryColor,
      //     border: Border.all(
      //       color: constantValues.secondaryColor,
      //     ),
      //     borderRadius: BorderRadius.circular(size.width * 0.022),
      //   ),
      //   child: IconButton(
      //     tooltip: userInfo.read("isDarkTheme") ? "Turn on" : "Turn off",
      //     onPressed: () {
      //       setState(() {
      //         userInfo.write("isDarkTheme", !userInfo.read("isDarkTheme"));
      //       });
      //       themeChanger.setTheme(userInfo.read("isDarkTheme")
      //           ? ThemeData(
      //               primarySwatch:
      //                   MaterialColor(0xFF4CAF50, constantValues.defaultColor),
      //               colorScheme: ColorScheme.fromSeed(
      //                   brightness: userInfo.read("isDarkTheme")
      //                       ? Brightness.dark
      //                       : Brightness.light,
      //                   seedColor: constantValues.primaryColor),
      //               useMaterial3: true,
      //               textTheme: GoogleFonts.archivoTextTheme(
      //                       Theme.of(context).textTheme)
      //                   .apply(
      //                       bodyColor: userInfo.read("isDarkTheme")
      //                           ? constantValues.whiteColor
      //                           : constantValues.darkColor),
      //               brightness: Brightness.dark,
      //             )
      //           : ThemeData(
      //               primarySwatch:
      //                   MaterialColor(0xFF4CAF50, constantValues.defaultColor),
      //               colorScheme: ColorScheme.fromSeed(
      //                   brightness: userInfo.read("isDarkTheme")
      //                       ? Brightness.dark
      //                       : Brightness.light,
      //                   seedColor: constantValues.primaryColor),
      //               useMaterial3: true,
      //               textTheme: GoogleFonts.archivoTextTheme(
      //                       Theme.of(context).textTheme)
      //                   .apply(
      //                       bodyColor: userInfo.read("isDarkTheme")
      //                           ? constantValues.whiteColor
      //                           : constantValues.darkColor),
      //               brightness: Brightness.light,
      //             ));
      //     },
      //     icon: Icon(
      //       userInfo.read("isDarkTheme")
      //           ? Icons.lightbulb_outline_rounded
      //           : Icons.lightbulb_rounded,
      //       color: constantValues.primaryColor,
      //     ),
      //   ),
      // ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Responsive(
            isExtraLargeScreen:
                isExtraLargeScreen(context, size, mainFont, subFont),
            isTablet: isTablet(context, size),
            isMobile: isMobile(context, size)),
      )),
    );
  }

  Widget isExtraLargeScreen(
      BuildContext context, Size size, var font1, var font2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.3),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Text(constantValues.signinText, style: font1),
          Text(constantValues.signinSubText,
              style: font2, textAlign: TextAlign.center),
          SizedBox(height: size.height * 0.04),
          Card(
            color: constantValues.bgColor2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: size.height * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email address"),
                        SizedBox(height: size.height * 0.01),
                        EmailFieldA(
                          controller: emailController,
                          width: size.width * 0.4,
                          title: "E.g: johndoe@gmail.com",
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Password"),
                        SizedBox(height: size.height * 0.01),
                        PasswordFieldA(
                          controller: passwordController,
                          width: size.width * 0.4,
                          title: "Enter your password",
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.04),
                    ButtonA(
                      width: size.width * 0.4,
                      bgColor: constantValues.primaryColor,
                      textColor: constantValues.whiteColor,
                      text: "Sign In",
                      authenticate: () async {
                        await signin();
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Checkbox(
                        value: userInfo.read("rememberMe"),
                        onChanged: (value) {
                          setState(() {
                            userInfo.write("rememberMe", value);
                          });
                          if (value == true) {
                            userInfo.write(
                                "tempEmail", emailController.text.trim());
                            userInfo.write(
                                "tempPassword", passwordController.text.trim());
                          } else {
                            userInfo.write("tempEmail", "");
                            userInfo.write("tempPassword", "");
                          }
                        },
                      ),
                      SizedBox(width: size.width * 0.005),
                      Text(
                        constantValues.remember,
                        style: GoogleFonts.archivo(
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w300)),
                      ),
                    ]),
                    SizedBox(height: size.height * 0.02),
                    RichText(
                      text: TextSpan(
                          style: GoogleFonts.archivo(
                              textStyle: TextStyle(
                            color: userInfo.read("isDarkTheme")
                                ? constantValues.whiteColor2
                                : constantValues.darkColor,
                          )),
                          children: [
                            TextSpan(
                              text: constantValues.dontHaveAccount,
                            ),
                            TextSpan(
                                text: constantValues.dontHaveAccount2,
                                style: GoogleFonts.archivo(
                                    textStyle: TextStyle(
                                        color: constantValues.primaryColor,
                                        fontWeight: FontWeight.w500)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.goNamed("signup");
                                  }),
                          ]),
                    ),
                    SizedBox(height: size.height * 0.02),
                    RichText(
                      text: TextSpan(
                          style: GoogleFonts.archivo(
                              textStyle: TextStyle(
                            color: userInfo.read("isDarkTheme")
                                ? constantValues.whiteColor2
                                : constantValues.darkColor,
                          )),
                          children: [
                            TextSpan(text: constantValues.forgotPassword),
                            TextSpan(
                                text: constantValues.forgotPassword2,
                                style: GoogleFonts.archivo(
                                    textStyle: TextStyle(
                                        color: constantValues.primaryColor,
                                        fontWeight: FontWeight.w500)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {}),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }

  Widget isTablet(BuildContext context, Size size) {
    return const Column(
      children: [],
    );
  }

  Widget isMobile(BuildContext context, Size size) {
    return const Column(
      children: [],
    );
  }

  signin() async {
    final checkForm = _formKey.currentState!;
    if (checkForm.validate()) {
      final email = emailController.text.trim().toLowerCase();
      final password = passwordController.text.trim();
      if (email == "david@gmail.com") {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(inValidCredentials);
      }
    }
  }
}