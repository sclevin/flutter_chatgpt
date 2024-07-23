import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../states/session_state.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/23

class ChatHistory extends HookConsumerWidget {
  const ChatHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sessionStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: Center(
        child: state.when(
            data: (state) {
              return ListView(children: [
                for (var i in state.sessionList)
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(i.title),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    onTap: () {
                      ref.read(sessionStateNotifierProvider.notifier)
                          .setActiveSession(i);

                      GoRouter.of(context).pop();
                    },
                    selected: state.activeSession?.id == i.id,
                  ),
              ]);
            },
            error: (err, stack) => Text("$err"),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
