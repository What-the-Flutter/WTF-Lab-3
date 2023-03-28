import 'dart:typed_data';

import 'package:get_it/get_it.dart';

import '../models/models.dart';
import '../provider/settings_provider.dart';
import '../provider/storage_provider.dart';

class SettingsRepository {
  const SettingsRepository();

  Future<void> saveThemeInfo(ThemeInfo themeInfo) async =>
      await GetIt.I<SettingsProvider>().save(themeInfo);

  Future<ThemeInfo> updateThemeInfo() async =>
      await GetIt.I<SettingsProvider>().read();

  Future<void> saveBackgroundImage(Uint8List image) async =>
      await GetIt.I<StorageProvider>().upload(
        filename: 'background_image',
        data: image,
      );

  Future<Uint8List> downloadBackgroundImage() async =>
      await GetIt.I<StorageProvider>().download(filename: 'background_image');

  Future<void> deleteBackgroundImage() async =>
      await GetIt.I<StorageProvider>().delete(filename: 'background_image');
}
