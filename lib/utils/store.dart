import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_manager/models/history.dart';
import 'package:social_manager/models/user.dart';

class Store {
  static late final Box<String> _defaultBox;
  static late final Box<String> _linksBox;
  const Store._();

  static Future<void> init() async {
    await Hive.initFlutter();
    _defaultBox = await _getBox<String>('app_storage');
    _linksBox = await _getBox<String>('preview_links');
  }

  static Future<void> _saveValue(String name, String? value,
      [Box<String?>? box]) async {
    box = box ?? _defaultBox;
    await box.delete(name);
    await box.put(name, value);
  }

  static ValueListenable listenToSettings() =>
      _defaultBox.listenable(keys: ['locale', 'theme_mode']);
  static String? _readValue(String name, [Box<String>? box]) {
    box = box ?? _defaultBox;
    String? results = box.get(name);
    return results;
  }

  static Future<Box<T>> _getBox<T>(String boxName) async {
    Box<T> box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.box<T>(boxName);
    } else {
      box = await Hive.openBox<T>(boxName);
    }

    if (!box.isOpen) {
      await Hive.openBox(box.name);
    }
    return box;
  }

  static void addLinkPreviewData(History url, PreviewData data) async {
    await _saveValue(url.id.toString(), json.encode(data.toJson()), _linksBox);
  }

  static PreviewData? previewOf(History url) {
    final value = _readValue(url.id.toString(), _linksBox);
    if (value == null) return null;
    return PreviewData.fromJson(json.decode(value));
  }

  static ValueListenable<Box<String>> listenToLink(String url) =>
      _linksBox.listenable(
        keys: [url],
      );

  static Locale get locale {
    Locale data = Locale(_readValue('locale') ?? window.locale.languageCode);
    return data;
  }

  static set locale(Locale? data) {
    _saveValue('locale', data?.toLanguageTag());
  }

  static User? get user {
    if (_readValue('user') != null) {
      return User.fromRawJson(_readValue('user')!);
    }
    return null;
  }

  static set user(User? user) {
    _saveValue('user', user?.toRawJson());
  }

  static ThemeMode get theme {
    return ThemeMode.values[int.tryParse(_readValue('theme_mode').toString()) ??
        ThemeMode.light.index];
  }

  static set theme(ThemeMode theme) {
    _saveValue('theme_mode', theme.index.toString());
  }
}
