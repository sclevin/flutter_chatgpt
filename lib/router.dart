import 'package:flutter_chatgpt/view/chat_history.dart';
import 'package:flutter_chatgpt/view/chat_view.dart';
import 'package:flutter_chatgpt/view/setting_view.dart';

import 'package:go_router/go_router.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/23

final router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => ChatView(),
  ),
  GoRoute(
    path: '/history',
    builder: (context, state) => ChatHistory(),
  ),

  GoRoute(
      path: '/settings',
      builder: (context, state) => SettingView())
]);
