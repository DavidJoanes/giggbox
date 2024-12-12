// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/constants.dart';

final constantValues = Get.find<Constants>();
var userInfo = GetStorage();

class ButtonA extends StatefulWidget {
  ButtonA(
      {Key? key,
      required this.width,
      required this.bgColor,
      required this.textColor,
      required this.text,
      required this.authenticate})
      : super(key: key);
  final double width;
  var bgColor;
  var textColor;
  final String text;
  final Function authenticate;
  late bool isLoading = false;
  late bool isDisabled = false;

  @override
  State<ButtonA> createState() => _ButtonAState();
}

class _ButtonAState extends State<ButtonA> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: newElevatedButton(context),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          backgroundColor: WidgetStateProperty.all(widget.bgColor),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
        ),
        onPressed: !widget.isDisabled
            ? () async {
                if (!widget.isDisabled) {
                  setState(() => widget.isLoading = true);
                  setState(() => widget.isDisabled = true);
                  // await Future.delayed(const Duration(seconds: 3));
                  await widget.authenticate();
                  setState(() => widget.isLoading = false);
                  setState(() => widget.isDisabled = false);
                }
              }
            : null,
        child: widget.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    color: widget.textColor,
                  ),
                ),
              )
            : Text(
                widget.text,
                style: GoogleFonts.archivo(
                    textStyle: TextStyle(
                  color: widget.textColor,
                  fontWeight: FontWeight.w600,
                )),
              ));
  }
}

class ButtonA2 extends StatefulWidget {
  ButtonA2(
      {Key? key,
      required this.width,
      required this.bgColor,
      required this.textColor,
      required this.text,
      required this.authenticate})
      : super(key: key);
  final double width;
  var bgColor;
  var textColor;
  final String text;
  final Function authenticate;
  late bool isDisabled = false;

  @override
  State<ButtonA2> createState() => _ButtonA2State();
}

class _ButtonA2State extends State<ButtonA2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: newElevatedButton(context),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          backgroundColor: WidgetStateProperty.all(widget.bgColor),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
        ),
        onPressed: !widget.isDisabled
            ? () async {
                if (!widget.isDisabled) {
                  setState(() => widget.isDisabled = true);
                  await widget.authenticate();
                  setState(() => widget.isDisabled = false);
                }
              }
            : null,
        child: Text(
          widget.text,
          style: GoogleFonts.archivo(
              textStyle: TextStyle(
            color: widget.textColor,
            fontWeight: FontWeight.w600,
          )),
        ));
  }
}

class ButtonA3 extends StatefulWidget {
  ButtonA3(
      {Key? key,
      required this.width,
      required this.bgColor,
      required this.textColor,
      required this.text,
      required this.authenticate})
      : super(key: key);
  final double width;
  var bgColor;
  var textColor;
  final String text;
  final Function authenticate;
  late bool isDisabled = false;

  @override
  State<ButtonA3> createState() => _ButtonA3State();
}

class _ButtonA3State extends State<ButtonA3> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: newElevatedButton(context),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          backgroundColor: WidgetStateProperty.all(widget.bgColor),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 5, vertical: 5)),
        ),
        onPressed: !widget.isDisabled
            ? () async {
                if (!widget.isDisabled) {
                  setState(() => widget.isDisabled = true);
                  await widget.authenticate();
                  setState(() => widget.isDisabled = false);
                }
              }
            : null,
        child: Text(
          widget.text,
          style: GoogleFonts.archivo(
              textStyle: TextStyle(
            color: widget.textColor,
            fontWeight: FontWeight.w600,
          )),
        ));
  }
}

class ButtonB extends StatefulWidget {
  ButtonB(
      {Key? key,
      required this.width,
      required this.bgColor,
      required this.textColor,
      required this.text,
      required this.authenticate})
      : super(key: key);
  final double width;
  var bgColor;
  var textColor;
  final String text;
  final Function authenticate;
  late bool isDisabled = false;

  @override
  State<ButtonB> createState() => _ButtonBState();
}

class _ButtonBState extends State<ButtonB> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: newElevatedButton(context),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          backgroundColor: WidgetStateProperty.all(widget.bgColor),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        ),
        onPressed: !widget.isDisabled
            ? () async {
                if (!widget.isDisabled) {
                  setState(() => widget.isDisabled = true);
                  await widget.authenticate();
                  setState(() => widget.isDisabled = false);
                }
              }
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset(
                "assets/icons/google.png",
                scale: 28,
              ),
              onPressed: null,
            ),
            Text(
              widget.text,
              style: GoogleFonts.archivo(
                  textStyle: TextStyle(
                color: widget.textColor,
                fontWeight: FontWeight.w600,
              )),
            ),
          ],
        ));
  }
}

class ButtonB2 extends StatefulWidget {
  ButtonB2(
      {Key? key,
      required this.width,
      required this.bgColor,
      required this.borderColor,
      required this.textColor,
      required this.text,
      required this.authenticate})
      : super(key: key);
  final double width;
  var bgColor;
  var borderColor;
  var textColor;
  final String text;
  final Function authenticate;
  late bool isDisabled = false;

  @override
  State<ButtonB2> createState() => _ButtonB2State();
}

class _ButtonB2State extends State<ButtonB2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: newElevatedButton(context),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: widget.bgColor,
          side: BorderSide(color: widget.borderColor, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: !widget.isDisabled
            ? () async {
                if (!widget.isDisabled) {
                  setState(() => widget.isDisabled = true);
                  await widget.authenticate();
                  setState(() => widget.isDisabled = false);
                }
              }
            : null,
        child: Text(
          widget.text,
          style: GoogleFonts.archivo(
              textStyle: TextStyle(
            color: widget.textColor,
            fontWeight: FontWeight.w600,
          )),
        ));
  }
}
