import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/config/theme.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:flutter_chatgpt/config/router.dart';
import 'package:flutter_chatgpt/states/settings_state.dart';
import 'package:flutter_chatgpt/utils/platform_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDatabase();
  await setupLocalStore();
  await chatService.loadConfig();

  print(await sqfliteDatabaseFactory.getDatabasePath("flutter_chatgpt.db"));

  initWindow();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final setttings = ref.watch(settingsStateProvider).valueOrNull;
    
    return MaterialApp.router(
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: setttings?.themeMode,
      localizationsDelegates: appIntl.localizationsDelegates,
      supportedLocales: appIntl.supportedLocales,
      locale: setttings?.locale,
      routerConfig: router,
    );
  }
}
