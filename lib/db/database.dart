import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_chatgpt/db/dao/session_dao.dart';
import 'package:flutter_chatgpt/models/session.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:flutter_chatgpt/db/converter/datetime_converter.dart';
import 'package:flutter_chatgpt/db/dao/message_dao.dart';
import 'package:flutter_chatgpt/models/message.dart';


/// Description:
/// Author:LiaoWen
/// Date:2024/7/23
part 'database.g.dart';

@Database(version: 1, entities: [Message,Session])
@TypeConverters([DateTimeConverter])
abstract class AppDatabase extends FloorDatabase{
  MessageDao get messageDao;
  SessionDao get sessionDao;
}