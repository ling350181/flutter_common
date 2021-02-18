import 'package:flutter/material.dart';

class CommonLocalizations{

  final Locale locale;

  CommonLocalizations(this.locale);

  static CommonLocalizations of(BuildContext context){
    return Localizations.of<CommonLocalizations>(context, CommonLocalizations);
  }

  static Map<String,Map<String,dynamic>> _localizedValues ={
    "zh":{
      "confirm_text":"确认",
      "cancel_text":"取消",
      "authenticate_message":"该设备没有个人特征验证功能。",
    },
    "ja":{
      "confirm_text":"確認",
      "cancel_text":"キャンセル",
      "authenticate_message":"デバイスには生体認証機能がありません。",
    },
    "en":{
      "confirm_text":"Confirm",
      "cancel_text":"Cancel",
      "authenticate_message":"The device does not have biometrics.",
    }
  };

  Map<String,dynamic> get _stringMap{
    return _localizedValues[locale.languageCode];
  }

  String get confirmText{
    return _stringMap["confirm_text"];
  }

  String get cancelText{
    return _stringMap["cancel_text"];
  }

  String get authenticateMessage{
    return _stringMap["authenticate_message"];
  }
}