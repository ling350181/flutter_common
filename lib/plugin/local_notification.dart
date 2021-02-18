import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_common/model/notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';


class LocalNotification{

  FlutterLocalNotificationsPlugin notificationsPlugin;
  final BehaviorSubject didReceivedLocalNotificationSubject
    = BehaviorSubject<NotificationModel>();
  var initializationSettings;

  final MethodChannel platform =
  MethodChannel('dexterx.dev/flutter_local_notifications');

  LocalNotification._(){
    init();
  }

  init()async{
    notificationsPlugin = FlutterLocalNotificationsPlugin();
    if(Platform.isIOS){
      // 请求许可
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  _requestIOSPermission(){
    notificationsPlugin.resolvePlatformSpecificImplementation
      <IOSFlutterLocalNotificationsPlugin>().requestPermissions(
      alert: false,
      badge: true,
      sound: true
    );
  }

  initializePlatformSpecifics(){
    // 安卓设置
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // iOS设置
    var initializeSettingIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id,title,body,payload)async{
        NotificationModel notificationModel = NotificationModel(
            id: id, title: title, body: body, payload: payload
        );
        didReceivedLocalNotificationSubject.add(notificationModel);
      }
    );
    initializationSettings = InitializationSettings(
        iOS: initializeSettingIOS,
        android: initializationSettingsAndroid);
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await notificationsPlugin.initialize(initializationSettings, onSelectNotification:
      (String payload) async{
        onNotificationClick();
      }
    );
  }

  Future<void> showDailyAtTime(DateTime dateTime,NotificationModel notificationModel) async {
    Time time = Time(dateTime.hour,dateTime.minute);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 4',
      'CHANNEL_NAME 4',
      "CHANNEL_DESCRIPTION 4",
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics,iOS: iOSChannelSpecifics);
    // ignore: deprecated_member_use
    await notificationsPlugin.showDailyAtTime(
      notificationModel.id,
      notificationModel.title,
      notificationModel.body,
      time,
      platformChannelSpecifics,
      payload: notificationModel.payload,
    );
  }

  Future<void> schedule(DateTime time,NotificationModel notificationModel)async{
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 4',
      'CHANNEL_NAME 4',
      "CHANNEL_DESCRIPTION 4",
      importance: Importance.max,
      icon: "@mipmap/ic_launcher",
      priority: Priority.high,
    );
    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics,iOS: iOSChannelSpecifics);
    // ignore: deprecated_member_use
    await notificationsPlugin.schedule(
      notificationModel.id, 
      notificationModel.title, 
      notificationModel.body,
      time, 
      platformChannelSpecifics,
      payload: notificationModel.payload,
    );
  }

  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }
}

LocalNotification localNotification = LocalNotification._();