
import 'package:flutter/material.dart';
import 'package:flutter_common/plugin/database/sql_manger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

abstract class BaseDbProvider with ChangeNotifier {

  bool needRebuild = false;
  bool isTableExits = false;

  createTableString();

  tableName();

  rebuild(){
    needRebuild = true;
    notifyListeners();
  }

  ///创建表sql语句
  tableBaseString(String sql) {
    return sql;
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  ///super 函数对父类进行初始化
  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await SqlManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), createTableString());
    }
    return await SqlManager.getCurrentDatabase();
  }

}