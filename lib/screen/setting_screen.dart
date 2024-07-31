import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/injection.dart';
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
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(settingsStateProvider);
    final appTheme = ref.watch(settingsStateProvider).valueOrNull?.themeMode ??
        ThemeMode.system;

    final controller = useTextEditingController();

    return ListView(
      children: const [
        SettingItemApiKey(),
        Divider(),
        SettingItemHttpProxy(),
        Divider(),
        SettingItemOpenAiBase(),
        Divider(),
        SettingItemAppTheme(),
        Divider(),
        SettingItemLanguage(),
      ],
    );
  }

}




class SettingItemApiKey extends HookConsumerWidget {
  const SettingItemApiKey({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = appIntl.of(context)!.settingsApiKeyLabel;
    final settings = ref.watch(settingsStateProvider).valueOrNull;
    final controller = useTextEditingController();
    return ListTile(
      title: Text(title),
      subtitle: Text(settings?.apiKey ?? ""),
      onTap: () async {
        final text = await showEditor(
          controller,
          ref,
          title,
          text: settings?.apiKey,
        );
        if (text == null) return;
        ref.read(settingsStateProvider.notifier).setApiKey(text);
      },
    );
  }
}


class SettingItemHttpProxy extends HookConsumerWidget {
  const SettingItemHttpProxy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = appIntl.of(context)!.settingsHttpProxyTitle;
    final settings = ref.watch(settingsStateProvider).valueOrNull;
    final controller = useTextEditingController();
    return ListTile(
      title: Text(title),
      subtitle: Text(settings?.httpProxy ?? ""),
      onTap: () async {
        final text = await showEditor(
          controller,
          ref,
          title,
          text: settings?.httpProxy,
        );
        if (text == null) return;
        ref.read(settingsStateProvider.notifier).setHttpProxy(text);
      },
    );
  }
}

class SettingItemOpenAiBase extends HookConsumerWidget {
  const SettingItemOpenAiBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = appIntl.of(context)!.settingsOpenaiApiBase;
    final settings = ref.watch(settingsStateProvider).valueOrNull;
    final controller = useTextEditingController();
    return ListTile(
      title: Text(title),
      subtitle: Text(settings?.baseUrl ?? ""),
      onTap: () async {
        final text = await showEditor(
          controller,
          ref,
          title,
          text: settings?.baseUrl,
        );
        if (text == null) return;
        ref.read(settingsStateProvider.notifier).setBaseUrl(text);
      },
    );
  }
}

class SettingItemAppTheme extends HookConsumerWidget {
  const SettingItemAppTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apptheme = ref.watch(settingsStateProvider).valueOrNull?.themeMode ??
        ThemeMode.system;
    return ListTile(
      title: Text(appIntl.of(context)!.settingThemeLabel),
      subtitle: Row(
        children: [
          RadioMenuButton(
            value: ThemeMode.system,
            groupValue: apptheme,
            onChanged: (v) {
              ref
                  .read(settingsStateProvider.notifier)
                  .setThemeMode(ThemeMode.system);
            },
            child: Text(appIntl.of(context)!.themeSystem),
          ),
          RadioMenuButton(
            value: ThemeMode.light,
            groupValue: apptheme,
            onChanged: (v) {
              ref
                  .read(settingsStateProvider.notifier)
                  .setThemeMode(ThemeMode.light);
            },
            child: Text(appIntl.of(context)!.themeLight),
          ),
          RadioMenuButton(
            value: ThemeMode.dark,
            groupValue: apptheme,
            onChanged: (v) {
              ref
                  .read(settingsStateProvider.notifier)
                  .setThemeMode(ThemeMode.dark);
            },
            child: Text(appIntl.of(context)!.themeDark),
          ),
        ],
      ),
    );
  }
}

class SettingItemLanguage extends HookConsumerWidget {
  const SettingItemLanguage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(settingsStateProvider).valueOrNull?.locale;
    return ListTile(
      title: Text(appIntl.of(context)!.settingsLanguageLabel),
      subtitle: Row(
          children: [
            (null, appIntl.of(context)!.lanSystem),
           (const Locale("en"), appIntl.of(context)!.lanEn),
            (const Locale("zh"), appIntl.of(context)!.lanZh),
          ]
              .map((e) => RadioMenuButton(
            value: e.$1,
            groupValue: locale,
            onChanged: (v) {
              ref.read(settingsStateProvider.notifier).setLocale(v);
            },
            child: Text(e.$2),
          ))
              .toList()),
    );
  }
}




Future<String?> showEditor(
    TextEditingController controller,
    WidgetRef ref,
    String title, {
      String? text,
      String? hint,
    }) async {
  controller.text = text ?? '';
  return await showDialog<String?>(
    context: ref.context,
    builder: (context) => AlertDialog(
      actions: [
        // negative button
        TextButton(
          child: Text(appIntl.of(context)!.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(appIntl.of(context)!.ok),
          onPressed: () {
            final text = controller.text;
            controller.clear();
            Navigator.of(context).pop(text);
          },
        ),
      ],
      title: Text(title),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hint),
      ),
    ),
  );
}

