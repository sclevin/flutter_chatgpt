import 'package:flutter_chatgpt/db/database.dart';
import 'package:flutter_chatgpt/services/chatgpt_service.dart';
import 'package:uuid/uuid.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18

final chatService = ChatgptService();

const uuid = Uuid();

late AppDatabase db;