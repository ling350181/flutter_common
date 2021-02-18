import 'package:flutter/material.dart';
import 'package:flutter_common/locale/common_localizations.dart';
import 'package:flutter_common/widget/bottom_modal_widget.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class BioMetricUtil{

  static final BioMetricUtil _util = BioMetricUtil._internal();

  BioMetricUtil._internal();

  factory BioMetricUtil(){
    return _util;
  }

  LocalAuthentication _localAuth = LocalAuthentication();

  Future<List<BiometricType>> _getAvailableBiometricTypes() async {
    List<BiometricType> availableBiometricTypes;
    try {
      availableBiometricTypes = await _localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    return availableBiometricTypes;
  }

  Future<bool> authenticate(BuildContext context,Locale locale) async {
    bool result = false;

    List<BiometricType> availableBiometricTypes = await _getAvailableBiometricTypes();

    try {
      if (availableBiometricTypes.contains(BiometricType.face)
        || availableBiometricTypes.contains(BiometricType.fingerprint)) {
        result = await _localAuth.authenticateWithBiometrics(
          localizedReason: "Please authenticate to complete the accessing",
        );
      }else{
        showBottomModal(
          context, 
          height: 220,
          message: CommonLocalizations(locale).authenticateMessage,
          locale: locale,
          confirmClick: (){
            Navigator.of(context).pop();
          }
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }

    return result;
  }

  Future<bool> callAuthenticate()async{
    bool result;
    try{
      result = await _localAuth.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete the accessing",
      );
    } on PlatformException catch(e){
      print(e);
    }
    return result;
  }

  Future<bool> cancelAuthentication() {
    return _localAuth.stopAuthentication();
  }

  Future<bool> checkBiometrics() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await _localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    return canCheckBiometrics;
  }
}