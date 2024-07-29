import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/models/session.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../states/session_state.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/23

class ChatHistoryScreen extends HookConsumerWidget {
  const ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sessionStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: Center(
        child: state.when(
            data: (state) {
              return ListView(children: [
                for (var session in state.sessionList)
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(session.title),
                        ),

                        IconButton(
                          onPressed: () {
                            _deleteConfirm(context, ref, session);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    onTap: () {
                      ref
                          .read(sessionStateNotifierProvider.notifier)
                          .setActiveSession(session);

                      GoRouter.of(context).pop();
                    },
                    selected: state.activeSession?.id == session.id,
                  ),
              ]);
            },
            error: (err, stack) => Text("$err"),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }

  Future _deleteConfirm(BuildContext context, WidgetRef ref, Session session) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Tips"),
              content: const Text("Are you sure to delete?"),
              actions: [
                TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text("Cancel")),

                TextButton(
                    onPressed: () {
                      ref.read(sessionStateNotifierProvider.notifier)
                          .deleteSession(session);
                      ref.read(sessionStateNotifierProvider.notifier)
                      .setActiveSession(null);

                      // TODO: fix the bug that cannot pop the dialog
                     Navigator.pop(context);
                    },
                    child: const Text("Delete")),
              ]);
        });
  }
}
