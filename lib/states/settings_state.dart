import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/29

part 'settings_state.freezed.dart';

part 'settings_state.g.dart';

@freezed
abstract class Settings with _$Settings {
  const factory Settings({
    String? apiKey,
    String? httpProxy,
    String? baseUrl,
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _Settings;

  static Settings load() {
    final apiKey = localStore.getString(SettingsKey.apiKey.name);
    final httpProxy = localStore.getString(SettingsKey.httpProxy.name);
    final baseUrl = localStore.getString(SettingsKey.baseUrl.name);

    final appTheme =
        localStore.getInt(SettingsKey.theme.name) ?? ThemeMode.system.index;

    return Settings(
      apiKey: apiKey,
      httpProxy: httpProxy,
      baseUrl: baseUrl,
      themeMode: ThemeMode.values[appTheme],
    );
  }
}

enum SettingsKey { apiKey, httpProxy, baseUrl, theme }

@riverpod
class SettingsState extends _$SettingsState {
  @override
  FutureOr<Settings> build() async {
    return Settings.load();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await localStore.setInt(SettingsKey.theme.name, themeMode.index);
      final settings = state.valueOrNull ?? const Settings();
      chatService.loadConfig();
      return settings.copyWith(themeMode: themeMode);
    });
  }

  Future<void> setApiKey(String apiKey) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await localStore.setString(SettingsKey.apiKey.name, apiKey);
      final settings = state.valueOrNull ?? const Settings();
      chatService.loadConfig();
      return settings.copyWith(apiKey: apiKey);
    });
  }

  Future<void> setHttpProxy(String httpProxy) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await localStore.setString(SettingsKey.httpProxy.name, httpProxy);
      final settings = state.valueOrNull ?? const Settings();
      chatService.loadConfig();
      return settings.copyWith(httpProxy: httpProxy);
    });
  }

  Future<void> setBaseUrl(String baseUrl) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await localStore.setString(SettingsKey.baseUrl.name, baseUrl);
      final settings = state.valueOrNull ?? const Settings();
      chatService.loadConfig();
      return settings.copyWith(baseUrl: baseUrl);
    });
  }
}

@freezed
class SettingItem with _$SettingItem {
  const factory SettingItem({
    required SettingsKey key,
    required String title,
    required String hint,
    String? subTitle,
    dynamic value,
  }) = _SettingItem;
}

@riverpod
List<SettingItem> settingList(SettingListRef ref) {
  final settings = ref.watch(settingsStateProvider).valueOrNull;

  return [
    SettingItem(
        key: SettingsKey.apiKey,
        title: 'API Key',
        subTitle: settings?.apiKey,
        hint: 'Please Input API Key'),
    SettingItem(
        key: SettingsKey.httpProxy,
        title: 'HTTP Proxy',
        subTitle: settings?.httpProxy,
        hint: 'Please Input Http Proxy'),
    SettingItem(
        key: SettingsKey.baseUrl,
        title: 'Base URL',
        subTitle: settings?.baseUrl,
        hint: 'Please Input Base URL'),
    SettingItem(
        key: SettingsKey.theme,
        title: 'APP Theme',
        value: settings?.themeMode,
        hint: 'APP Theme'),
  ];
}
