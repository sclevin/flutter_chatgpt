import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/states/settings_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/29

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),

      body: const SettingWindow(),
    );
  }
}


class SettingWindow extends HookConsumerWidget {
  const SettingWindow({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final items = ref.watch(settingListProvider);

    final controller = useTextEditingController();

    return ListView.separated(
        itemBuilder: (context,index){
          final item = items[index];
          return ListTile(
              title: Text(item.title),
          subtitle: Text(item.subTitle ?? 'Unknown'),
          trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final text = await showEditor(controller, item, ref);
              if (text == null) return;
              switch (item.key) {
                case SettingsKey.apiKey:
                  ref.read(settingsStateProvider.notifier).setApiKey(text);
                  break;
                case SettingsKey.httpProxy:
                  ref.read(settingsStateProvider.notifier).setHttpProxy(text);
                  break;
                case SettingsKey.baseUrl:
                  ref.read(settingsStateProvider.notifier).setBaseUrl(text);
                  break;
                default:
                  break;
              }
            },
          );
        },
        separatorBuilder: (context,index) => const Divider(),
        itemCount: items.length);
  }



  Future<String?> showEditor(TextEditingController controller,SettingItem item,WidgetRef ref) async{
    controller.text = item.subTitle ?? '';
    return await showDialog(context: ref.context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),

            TextButton(
                child: const Text('OK'),
                onPressed: () {
                  final text = controller.text;
                  controller.clear();
                  Navigator.of(context).pop(text);
                }
            ),
          ],
          title: Text(item.title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: item.hint),
          )
        ));
  }

}
