import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';
import '../controllers/responsive.dart';
import '../widgets/input_fields.dart';
import '../widgets/password_fields.dart';

class AccountCreation extends StatefulWidget {
  AccountCreation({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  late GlobalKey formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<AccountCreation> createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  final constantValues = Get.find<Constants>();
  var userInfo = GetStorage();
  Dio dio = Dio();

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
    return SingleChildScrollView(
      child: Responsive(
          isExtraLargeScreen:
              isExtraLargeScreen(context, size, mainFont, subFont),
          isTablet: isTablet(context, size, mainFont, subFont),
          isMobile: isMobile(context, size, mainFont, subFont)),
    );
  }

  Widget isExtraLargeScreen(
      BuildContext context, Size size, var font1, var font2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.3),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Text(constantValues.signupText, style: font1),
          SizedBox(
            width: size.width * 0.6,
            child: Text(constantValues.signupSubText,
                style: font2, textAlign: TextAlign.center, maxLines: 3),
          ),
          SizedBox(height: size.height * 0.04),
          Card(
            color: constantValues.bgColor2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: size.height * 0.05),
              child: Form(
                key: widget.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Username"),
                        SizedBox(height: size.height * 0.01),
                        InputFieldB(
                          controller: widget.usernameController,
                          width: size.width * 0.4,
                          title: "Enter your desired username",
                          enabled: true,
                          autoFillHint: const [AutofillHints.name],
                          authenticate: () async {
                            await validateUsername();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email address"),
                        SizedBox(height: size.height * 0.01),
                        EmailFieldA(
                          controller: widget.emailController,
                          width: size.width * 0.4,
                          title: "Enter your email",
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Password"),
                        SizedBox(height: size.height * 0.01),
                        PasswordFieldB(
                          controller: widget.passwordController,
                          width: size.width * 0.4,
                          height: size.height * 0.2,
                          title: "Enter your password",
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Password"),
                        SizedBox(height: size.height * 0.01),
                        PasswordFieldB2(
                          controller: widget.confirmPasswordController,
                          controller2: widget.passwordController,
                          width: size.width * 0.4,
                          title: "Retype your password",
                        ),
                      ],
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
                            TextSpan(
                              text: constantValues.alreadyHaveAccount,
                            ),
                            TextSpan(
                                text: constantValues.alreadyHaveAccount2,
                                style: GoogleFonts.archivo(
                                    textStyle: TextStyle(
                                        color: constantValues.primaryColor,
                                        fontWeight: FontWeight.w500)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.goNamed("signin");
                                  }),
                          ]),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Checkbox(
                        value: userInfo.read("agreeToTerms"),
                        onChanged: (value) {
                          setState(() {
                            userInfo.write("agreeToTerms", value);
                          });
                          if (value == true) {
                            userInfo.write(
                                "email", widget.emailController.text.trim());
                            userInfo.write("password",
                                widget.passwordController.text.trim());
                          } else {
                            userInfo.write("email", "");
                            userInfo.write("password", "");
                          }
                        },
                      ),
                      SizedBox(width: size.width * 0.005),
                      TextButton(
                        child: Text(
                          constantValues.termsAndCondition,
                          style: GoogleFonts.archivo(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w300)),
                        ),
                        onPressed: () {},
                      ),
                    ]),
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

  Widget isTablet(BuildContext context, Size size, var font1, var font2) {
    return const Column(
      children: [],
    );
  }

  Widget isMobile(BuildContext context, Size size, var font1, var font2) {
    return const Column(
      children: [],
    );
  }

  validateUsername() async {
    final userN = widget.usernameController.text.trim().toLowerCase();
    if (userN == "david") {
      return true;
    } else {
      return false;
    }
  }
}
