import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/screen/chat_history_screen.dart';
import 'package:flutter_chatgpt/screen/chat_screen.dart';
import 'package:flutter_chatgpt/screen/setting_screen.dart';
import 'package:flutter_chatgpt/states/session_state.dart';
import 'package:flutter_chatgpt/widgets/desktop.dart';
import 'package:flutter_chatgpt/widgets/new_chat_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/29

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(sessionStateNotifierProvider.notifier)
                  .setActiveSession(null);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: const Text(
                  'Chat History',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )),
            const Expanded(child: ChatHistoryWindow()),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text("Settings"),
              onTap: () {
                Navigator.of(context).pop();
                GoRouter.of(context).push('/settings');
              },
            ),
          ],
        ),
      ),
      body: ChatScreen(),
    );
  }
}

class DeskTopHomeScreen extends StatelessWidget {
  const DeskTopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesktopWindow(
        child: Row(
          children: [
            SizedBox(
              width: 240,
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const NewChatWidget(),
                  const Divider(
                    height: 5,
                  ),
                  const Expanded(child: ChatHistoryWindow()),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text("Settings"),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Settings"),
                              content: SizedBox(
                                height: 400,
                                width: 400,
                                child: SettingWindow(),
                              ),
                            );
                          });
                    },
                  )
                ],
              ),
            ),
            Expanded(child: ChatScreen())
          ],
        ),
      ),
    );
  }
}
