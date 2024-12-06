import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
// import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';
import 'input_field_containers.dart';

final constantValues = Get.find<Constants>();
var userInfo = GetStorage();

class PasswordFieldA extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final String title;
  const PasswordFieldA({
    Key? key,
    required this.controller,
    required this.width,
    required this.title,
  }) : super(key: key);

  @override
  State<PasswordFieldA> createState() => _PasswordFieldAState();
}

class _PasswordFieldAState extends State<PasswordFieldA> {
  bool isObscurePassword = true;
  late var isObscurePasswordIcon1 = const Icon(Icons.visibility_off_rounded);
  late var isObscurePasswordIcon2 = const Icon(Icons.remove_red_eye_rounded);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: widget.width,
      child: TextFormField(
        textInputAction: TextInputAction.go,
        obscureText: isObscurePassword,
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        style: GoogleFonts.lato(textStyle: const TextStyle()),
        validator: (value) => value == '' ? 'Password cannot be blank!' : null,
        decoration: InputDecoration(
          suffix: IconButton(
            iconSize: 12,
            tooltip: isObscurePassword ? "Show" : "Hide",
            icon: isObscurePassword
                ? isObscurePasswordIcon2
                : isObscurePasswordIcon1,
            onPressed: () {
              setState(() {
                isObscurePassword = !isObscurePassword;
              });
            },
          ),
          hintText: widget.title,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class PasswordFieldB extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final double height;
  final String title;
  const PasswordFieldB({
    Key? key,
    required this.controller,
    required this.width,
    required this.height,
    required this.title,
  }) : super(key: key);

  @override
  State<PasswordFieldB> createState() => _PasswordFieldBState();
}

class _PasswordFieldBState extends State<PasswordFieldB> {
  bool isObscurePassword = true;
  late var isObscurePasswordIcon1 = const Icon(Icons.visibility_off_rounded);
  late var isObscurePasswordIcon2 = const Icon(Icons.remove_red_eye_rounded);
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: widget.width,
      child: Column(
        children: [
          TextFormField(
            obscureText: isObscurePassword,
            controller: widget.controller,
            keyboardType: TextInputType.visiblePassword,
            style: GoogleFonts.poppins(textStyle: const TextStyle()),
            validator: (value) => value == ""
                ? "Enter a valid password!"
                : !status
                    ? "Weak password!"
                    : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: widget.title,
              labelStyle: GoogleFonts.poppins(textStyle: const TextStyle()),
              suffixIcon: IconButton(
                tooltip: isObscurePassword ? "Show" : "Hide",
                icon: isObscurePassword
                    ? isObscurePasswordIcon2
                    : isObscurePasswordIcon1,
                onPressed: () {
                  setState(() {
                    isObscurePassword = !isObscurePassword;
                  });
                },
              ),
              border: InputBorder.none,
            ),
          ),
          FlutterPwValidator(
            controller: widget.controller,
            minLength: 8,
            numericCharCount: 2,
            specialCharCount: 2,
            width: widget.width,
            height: widget.height,
            onSuccess: () => success(widget.controller),
            onFail: () => failure(widget.controller),
          ),
        ],
      ),
    );
  }

  success(value) {
    status = true;
    // setState(() {
    //   status = true;
    // });
  }

  failure(value) {
    value == null ? 'Weak password!' : null;
    status = false;
    // setState(() {
    //   status = false;
    // });
  }
}

class PasswordFieldB2 extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  final double width;
  final String title;
  const PasswordFieldB2({
    Key? key,
    required this.controller,
    required this.controller2,
    required this.width,
    required this.title,
  }) : super(key: key);

  @override
  State<PasswordFieldB2> createState() => _PasswordFieldB2State();
}

class _PasswordFieldB2State extends State<PasswordFieldB2> {
  bool isObscurePassword = true;
  late var isObscurePasswordIcon1 = const Icon(Icons.visibility_off_rounded);
  late var isObscurePasswordIcon2 = const Icon(Icons.remove_red_eye_rounded);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: widget.width,
      child: TextFormField(
        textInputAction: TextInputAction.go,
        obscureText: isObscurePassword,
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        style: GoogleFonts.lato(textStyle: const TextStyle()),
        validator: (value) => value!.isEmpty
            ? 'Password cannot be blank!'
            : value.trim() != widget.controller2.text
                ? "Passwords mismatch!"
                : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          suffix: IconButton(
            iconSize: 12,
            tooltip: isObscurePassword ? "Show" : "Hide",
            icon: isObscurePassword
                ? isObscurePasswordIcon2
                : isObscurePasswordIcon1,
            onPressed: () {
              setState(() {
                isObscurePassword = !isObscurePassword;
              });
            },
          ),
          hintText: widget.title,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
