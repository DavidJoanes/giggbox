import 'package:flutter/material.dart';

class Responsive extends StatefulWidget {
  const Responsive(
      {super.key, required this.isExtraLargeScreen, required this.isTablet, required this.isMobile});
  final Widget? isExtraLargeScreen;
  final Widget? isTablet;
  final Widget? isMobile;

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1024) {
        return widget.isExtraLargeScreen!;
      } else if (constraints.maxWidth > 700) {
        return widget.isTablet!;
      } else {
        return widget.isMobile!;
      }
    });
  }
}
