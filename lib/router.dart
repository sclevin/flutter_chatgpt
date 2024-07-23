import 'package:flutter_chatgpt/widgets/chat_history.dart';
import 'package:flutter_chatgpt/widgets/chat_page.dart';
import 'package:go_router/go_router.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/23

final router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => ChatPage(),
  ),
  GoRoute(
    path: '/history',
    builder: (context, state) => ChatHistory(),
  )
]);
