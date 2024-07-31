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
  const factory Settings(
      {String? apiKey,
      String? httpProxy,
      String? baseUrl,
      @Default(ThemeMode.system) ThemeMode themeMode,
      Locale? locale}) = _Settings;

  static Settings load() {
    final apiKey = localStore.getString(SettingsKey.apiKey.name);
    final httpProxy = localStore.getString(SettingsKey.httpProxy.name);
    final baseUrl = localStore.getString(SettingsKey.baseUrl.name);

    final appTheme =
        localStore.getInt(SettingsKey.theme.name) ?? ThemeMode.system.index;

    final locale = localStore.getString(SettingsKey.locale.name);

    return Settings(
        apiKey: apiKey,
        httpProxy: httpProxy,
        baseUrl: baseUrl,
        themeMode: ThemeMode.values[appTheme],
        locale: locale == null ? null : Locale(locale));
  }
}

enum SettingsKey { apiKey, httpProxy, baseUrl, theme, locale }

@riverpod
class SettingsState extends _$SettingsState {
  @override
  FutureOr<Settings> build() async {
    return Settings.load();
  }

  Future<void> setLocale(Locale? locale) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await localStore.setString(
          SettingsKey.locale.name, locale?.languageCode ?? "en");
      final settings = state.valueOrNull ?? const Settings();
      chatService.loadConfig();
      return settings.copyWith(locale: locale);
    });
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

