import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/db/database.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:flutter_chatgpt/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDatabase();
  await setupLocalStore();
  await chatService.loadConfig();

  print(await sqfliteDatabaseFactory.getDatabasePath("flutter_chatgpt.db"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child:MaterialApp.router(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          routerConfig: router,
        ),
    );
  }
}
