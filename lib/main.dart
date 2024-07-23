import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/db/database.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:flutter_chatgpt/router.dart';
import 'package:flutter_chatgpt/widgets/chat_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db =
      await $FloorAppDatabase.databaseBuilder('app_database.db').addMigrations([
    Migration(1, 2, (database) async {
      await database
          .execute('CREATE TABLE IF NOT EXISTS `Session` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL)');
      await database
          .execute('ALTER TABLE Message ADD COLUMN session_id INTEGER');
      await database
          .execute("insert into Session (id, title) values (1, 'Default')");
      await database.execute("UPDATE Message SET session_id = 1 WHERE 1=1");
    })
  ]).build();
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
