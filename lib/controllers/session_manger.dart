import 'dart:async';

import 'package:flutter/material.dart';

class SessionManager extends StatefulWidget {
  SessionManager(
      {super.key,
      required this.child,
      required this.onSessionExpired,
      required this.duration,
      required this.streamController});
  Widget child;
  VoidCallback onSessionExpired;
  Duration duration;
  StreamController streamController;

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  Timer? rootTimer;
  StreamController? streamController;

  void startSession() {
    closeTimer();
    startTimer();
  }

  void startTimer() {
    rootTimer = Timer.periodic(widget.duration, (timer) {
      widget.onSessionExpired();
      closeTimer();
    });
  }

  void closeTimer() {
    if (rootTimer != null) {
      rootTimer!.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
    streamController = widget.streamController;
    if (streamController != null) {
      streamController!.stream.listen((event) {
        if (event != null && event["timer"] as bool) {
          startSession();
        } else {
          closeTimer();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        startSession();
      },
      child: widget.child,
    );
  }
}
