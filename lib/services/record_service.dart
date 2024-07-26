import 'dart:io';

import 'package:flutter_chatgpt/injection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../utils/platform_utils.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/26

class RecordService {
  final r = Record();

  Future start({String? fileName}) async {
    if (!await r.hasPermission()) {
      logger.e("permission denied");
      return;
    }

    if (await isRecording) {
      logger.e("recording...");
      return;
    }

    final path = await getTemporaryDirectory();
    final dir = Directory("${path.absolute.path}/audios/");
    await dir.create(recursive: true);

    final file = File(
        "${dir.path}/${fileName ?? DateTime.now().microsecondsSinceEpoch}.m4a");
    logger.i('start path: ${file.path}');

    //iOS 和 macOS应用需要Uri格式
    //如果是Windows 和Android 直接使用文件路径
    await r.start(
      path: isApplePlatform() ? Uri.file(file.path).toString() : file.path,
    );
  }

  Future<String?> stop() async {
    final path = await r.stop();
    if(path == null) return null;

    return isApplePlatform() ? Uri.parse(path).toFilePath() : path;
  }

  Future<bool> get isRecording async => false;
}
