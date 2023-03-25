import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';
import '../provider/settings_provider.dart';
import '../provider/storage_provider.dart';

class SettingsRepository {
  final _settingsProvider = SettingsProvider();
  final StorageProvider _storageProvider;

  SettingsRepository(User? user) 
    : _storageProvider = StorageProvider(user: user);

  Future<void> saveThemeInfo(ThemeInfo themeInfo) async =>
      await _settingsProvider.save(themeInfo);

  Future<ThemeInfo> updateThemeInfo() async => await _settingsProvider.read();

  Future<void> saveBackgroundImage(Uint8List image) async =>
      await _storageProvider.upload(
        filename: 'background_image',
        data: image,
      );

  Future<Uint8List> downloadBackgroundImage() async => 
      await _storageProvider.download(filename: 'background_image');

  Future<void> deleteBackgroundImage() async =>
      await _storageProvider.delete(filename: 'background_image');
}
