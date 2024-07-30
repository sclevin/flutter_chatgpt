import 'package:share_plus/share_plus.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/30

Future shareFiles(List<String> paths) async {
  // 使用真机测试，模拟器可能会有问题。
  return Share.shareXFiles(paths.map((path) => XFile(path)).toList(),
      text: 'ChatGPT');
}
