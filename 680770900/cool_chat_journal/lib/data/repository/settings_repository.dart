import 'dart:typed_data';

import '../models/models.dart';
import '../provider/settings_provider.dart';
import '../provider/storage_provider.dart';

class SettingsRepository {
  final SettingsProvider settingsProvider;
  final StorageProvider storageProvider;

  const SettingsRepository({
    required this.settingsProvider,
    required this.storageProvider,
  });

  Future<void> saveThemeInfo(ThemeInfo themeInfo) async =>
      await settingsProvider.save(themeInfo);

  Future<ThemeInfo> updateThemeInfo() async =>
      await settingsProvider.read();

  Future<void> saveBackgroundImage(Uint8List image) async =>
      await storageProvider.upload(
        filename: 'background_image',
        data: image,
      );

  Future<Uint8List> downloadBackgroundImage() async =>
      await storageProvider.download(filename: 'background_image');

  Future<void> deleteBackgroundImage() async =>
      await storageProvider.delete(filename: 'background_image');
}
