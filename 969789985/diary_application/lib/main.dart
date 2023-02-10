import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/common/bloc/diary_observer.dart';
import 'src/common/themes/repo/theme_repository.dart';
import 'src/diary_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = DiaryObserver();
  await ThemeRepository.initialize();

  runApp(const DiaryApp());
}
