import 'package:flutter/material.dart';

class BaseProvider with ChangeNotifier{
  bool needRebuild = false;

  rebuild(){
    needRebuild = true;
    notifyListeners();
  }
}