import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CustomStateModel extends ChangeNotifier {
  var userInfo = GetStorage();
  get user => userInfo;

  void updateAState(key, newValue) {
    user.write(key, newValue);
    notifyListeners();
  }
}
