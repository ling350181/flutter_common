import 'package:flutter/material.dart';

void showBottomModal(
  BuildContext context, {
  String message,
  String confirm,
  String cancel,
  double height,
  String path,
  bool showCancel,
  bool isDismissible,
  @required VoidCallback confirmClick,
  @required VoidCallback cancelClick,
}) {
  showModalBottomSheet(
      context: context,
      isDismissible: isDismissible ?? true,
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
                      confirm ?? "确认",
                      style: TextStyle(color: Colors.white),
                    )),
                if(showCancel ?? false)
                FlatButton(
                    minWidth: MediaQuery.of(context).size.width - 50,
                    onPressed: cancelClick,
                    child: Text(
                      cancel ?? "取消",
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
  bool isDismissible,
  Widget widget
  }) {
    showModalBottomSheet(
        context: context,
        isDismissible: isDismissible ?? true,
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