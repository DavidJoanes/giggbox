import 'dart:async';

import 'package:flutter/material.dart';

class SessionController {
  BuildContext? context;
  StreamController? streamController;
  bool enableSigninPage = false;

  void startListener(
      {required BuildContext context,
      required StreamController streamController}) {
    this.context = context;
    this.streamController = streamController;
    Map<String, dynamic> map = {"context": context, "timer": true};
    streamController.add(map);
  }

  void stopListener(
      {required BuildContext context,
      required StreamController streamController}) {
    this.context = context;
    this.streamController = streamController;
    Map<String, dynamic> map = {"context": context, "timer": false};
    streamController.add(map);
  }
}
