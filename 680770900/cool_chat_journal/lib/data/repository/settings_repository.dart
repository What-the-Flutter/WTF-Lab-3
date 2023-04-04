import 'dart:typed_data';

import '../models/models.dart';
import '../provider/settings_provider.dart';
import '../provider/storage_provider.dart';

class SettingsRepository {
  final SettingsProvider _settingsProvider;
  final StorageProvider _storageProvider;

  const SettingsRepository(
    this._settingsProvider,
    this._storageProvider,
  );

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
