import 'package:flutter/material.dart';
import 'package:flutter_common/locale/common_localizations.dart';

void showBottomModal(
  BuildContext context, {
  String message,
  String confirm,
  String cancel,
  double height,
  String path,
  bool showCancel,
  bool isDismissible = true,
  @required Locale locale,
  @required VoidCallback confirmClick,
  VoidCallback cancelClick,
}) {
  showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      builder: (context) {
        return Container(
          color: Color(0xff737373),
          height: height ?? 250,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.all(const Radius.circular(10))),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      path ?? "images/warnning.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20,left: 30,right: 30),
                    child: Center(
                      child: Text(message ?? "message",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )),
                FlatButton(
                    minWidth: MediaQuery.of(context).size.width - 50,
                    color: Theme.of(context).primaryColor,
                    onPressed: confirmClick,
                    child: Text(
                      confirm ?? CommonLocalizations(locale).confirmText,
                      style: TextStyle(color: Colors.white),
                    )),
                if(showCancel ?? false)
                FlatButton(
                    minWidth: MediaQuery.of(context).size.width - 50,
                    onPressed: cancelClick,
                    child: Text(
                      cancel ?? CommonLocalizations(locale).cancelText,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
              ],
            ),
          ),
        );
      });
}

void showCustomizeSelectModal(
  BuildContext context, {
  String title,
  String subtitle,
  bool isDismissible = true,
  @required Locale locale,
  @required Widget widget
  }) {
    showModalBottomSheet(
        context: context,
        isDismissible: isDismissible,
        builder: (context) {
          return Container(
              color: Color(0xff737373),
              child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(const Radius.circular(10))),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      if(subtitle != null)
                      Container(
                        padding: EdgeInsets.only(right:55,left:55),
                        child: Text(subtitle, 
                          textAlign:TextAlign.center,
                          style: TextStyle(fontSize: 15,color: Colors.grey)),
                      ),
                      Divider(),
                      Expanded(
                        child: widget
                      )
                    ],
                  )));
        });
  }