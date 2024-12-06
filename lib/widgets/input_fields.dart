import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';
import 'input_field_containers.dart';

final constantValues = Get.find<Constants>();
var userInfo = GetStorage();

class EmailFieldA extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final String title;
  const EmailFieldA({
    Key? key,
    required this.controller,
    required this.width,
    required this.title,
  }) : super(key: key);

  @override
  State<EmailFieldA> createState() => _EmailFieldAState();
}

class _EmailFieldAState extends State<EmailFieldA> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        validator: (value) => value != null && !EmailValidator.validate(value)
            ? 'Invalid email address!'
            : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: constantValues.primaryColor,
        style: GoogleFonts.archivo(
            textStyle: TextStyle(
                color: userInfo.read("isDarkTheme")
                    ? constantValues.whiteColor
                    : constantValues.darkColor)),
        decoration: InputDecoration(
          hintText: widget.title,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class EmailFieldB extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final String title;
  late Function authenticate;
  EmailFieldB({
    Key? key,
    required this.controller,
    required this.width,
    required this.title,
    required this.authenticate,
  }) : super(key: key);

  @override
  State<EmailFieldB> createState() => _EmailFieldBState();
}

class _EmailFieldBState extends State<EmailFieldB> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        validator: (value) => value != null && !EmailValidator.validate(value)
            ? "Enter a valid email address!"
            : null,
        onEditingComplete: () async => await widget.authenticate() == true
            ? "Email address exist!"
            : "Valid email address",
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: constantValues.primaryColor,
        style: GoogleFonts.archivo(
            textStyle: TextStyle(
                color: userInfo.read("isDarkTheme")
                    ? constantValues.whiteColor
                    : constantValues.darkColor)),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          labelText: widget.title,
          labelStyle: GoogleFonts.poppins(textStyle: const TextStyle()),
        ),
      ),
    );
  }
}

class InputFieldA extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final String title;
  final bool enabled;
  final Widget hintIcon;
  final Iterable<String> autoFillHint;
  const InputFieldA({
    Key? key,
    required this.controller,
    required this.width,
    required this.title,
    required this.enabled,
    required this.hintIcon,
    required this.autoFillHint,
  }) : super(key: key);

  @override
  State<InputFieldA> createState() => _InputFieldAState();
}

class _InputFieldAState extends State<InputFieldA> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer2(
      width: widget.width,
      child: TextFormField(
        textInputAction: TextInputAction.go,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        autofillHints: widget.autoFillHint,
        enabled: widget.enabled,
        validator: (value) => value!.isEmpty ? "required!" : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: constantValues.primaryColor,
        style: GoogleFonts.archivo(
            textStyle: TextStyle(
                color: userInfo.read("isDarkTheme")
                    ? constantValues.whiteColor2
                    : constantValues.darkColor2)),
        decoration: InputDecoration(
          prefixIcon: widget.hintIcon,
          hintText: widget.title,
          hintStyle: GoogleFonts.archivo(textStyle: const TextStyle()),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class InputFieldB extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final String title;
  final bool enabled;
  final Iterable<String> autoFillHint;
  late Function authenticate;
  InputFieldB({
    Key? key,
    required this.controller,
    required this.width,
    required this.title,
    required this.enabled,
    required this.autoFillHint,
    required this.authenticate,
  }) : super(key: key);

  @override
  State<InputFieldB> createState() => _InputFieldBState();
}

class _InputFieldBState extends State<InputFieldB> {
  late bool usernameTaken = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: widget.width,
      child: TextFormField(
        textInputAction: TextInputAction.go,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        autofillHints: widget.autoFillHint,
        enabled: widget.enabled,
        onEditingComplete: () async {
          await widget.authenticate()
              ? setState(() {
                  usernameTaken = true;
                })
              : setState(() {
                  usernameTaken = false;
                });
        },
        validator: (value) => value!.isEmpty
            ? "required!"
            : value.contains(RegExp(r'["~!@#$%^&*()+`{}|<>?;:./,=\-\[\]]'))
                ? "Special characters except '_' are not valid!"
                : usernameTaken
                    ? "${widget.controller.text} is taken"
                    : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: constantValues.primaryColor,
        style: GoogleFonts.archivo(
            textStyle: TextStyle(
                color: userInfo.read("isDarkTheme")
                    ? constantValues.whiteColor
                    : constantValues.darkColor)),
        decoration: InputDecoration(
          hintText: widget.title,
          hintStyle: GoogleFonts.archivo(textStyle: const TextStyle()),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
