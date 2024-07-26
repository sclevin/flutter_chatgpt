import 'package:flutter/foundation.dart';
import 'package:flutter_chatgpt/db/database.dart';
import 'package:flutter_chatgpt/services/chatgpt_service.dart';
import 'package:flutter_chatgpt/services/record_service.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18

final logger = Logger(level: kDebugMode ? Level.debug : Level.info);

final chatService = ChatgptService();

final recordService = RecordService();

const uuid = Uuid();

late AppDatabase db;

setupDatabase() async {
  db = await initDatabase();
}