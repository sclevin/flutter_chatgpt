import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:flutter_chatgpt/states/session_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/29
class NewChatWidget extends HookConsumerWidget {
  const NewChatWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ListTile(
      title: SizedBox(
        height: 40,
        child: OutlinedButton.icon(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(Theme.of(context).textTheme.titleMedium),
            iconSize: WidgetStateProperty.all(Theme.of(context).iconTheme.size),
            iconColor: WidgetStateProperty.all(Theme.of(context).textTheme.titleMedium?.color),
            foregroundColor: WidgetStateProperty.all(Theme.of(context).textTheme.titleMedium?.color),
            alignment: Alignment.centerLeft,
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              )
            ),
          ),
            onPressed: (){
              ref.read(sessionStateNotifierProvider.notifier).setActiveSession(null);
            },
            icon: const Icon(Icons.add),
            label: Text(appIntl.of(context)!.newChatTitle)),
      )
    );
  }
}
