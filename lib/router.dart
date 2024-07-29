

import 'package:flutter_chatgpt/screen/chat_history_screen.dart';
import 'package:flutter_chatgpt/screen/chat_screen.dart';
import 'package:flutter_chatgpt/screen/home_screen.dart';
import 'package:flutter_chatgpt/screen/setting_screen.dart';
import 'package:go_router/go_router.dart';

import 'utils/platform_utils.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/23

final router = isDesktop() ? desktopRouter : mobileRouter;

final mobileRouter = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/history',
    builder: (context, state) => const ChatHistoryScreen(),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingScreen(),
  ),
]);

final desktopRouter = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const DeskTopHomeScreen(),
  ),
]);
