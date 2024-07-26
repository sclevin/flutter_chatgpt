import 'dart:io';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/26
bool isDesktop() {
  return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
}

bool isApplePlatform() {
  return Platform.isIOS || Platform.isMacOS;
}