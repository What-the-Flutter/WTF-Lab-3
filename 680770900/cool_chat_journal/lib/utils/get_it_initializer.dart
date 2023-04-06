import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../data/data.dart';
import '../presentation/filters_page/filters_cubit.dart';
import '../presentation/presentation.dart';
import 'default_categories.dart';

void initGetIt({required User user}) {
  // Providers.
  GetIt.I.registerSingleton<DatabaseProvider>(DatabaseProvider(
    user: user,
    defaultJsonCategories: DefaultCategories.jsonList,
  ));
  GetIt.I.registerSingleton<StorageProvider>(StorageProvider(
    user: user,
  ));
  GetIt.I.registerSingleton<SettingsProvider>(SettingsProvider());

  // Repositories.
  GetIt.I.registerSingleton<CategoriesRepository>(CategoriesRepository(
    GetIt.I<DatabaseProvider>(),
  ));
  GetIt.I.registerSingleton<ChatsRepository>(ChatsRepository(
    GetIt.I<DatabaseProvider>(),
  ));
  GetIt.I.registerSingleton<TagsRepository>(TagsRepository(
    GetIt.I<DatabaseProvider>(),
  ));
  GetIt.I.registerSingleton<EventsRepository>(EventsRepository(
    GetIt.I<DatabaseProvider>(),
    GetIt.I<StorageProvider>(),
    GetIt.I<TagsRepository>(),
  ));
  GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository(
    GetIt.I<SettingsProvider>(),
    GetIt.I<StorageProvider>(),
  ));

  // Cubits.
  GetIt.I.registerSingleton<SettingsCubit>(SettingsCubit(
    GetIt.I<SettingsRepository>(),
  ));
  GetIt.I.registerSingleton<HomeCubit>(HomeCubit(
    GetIt.I<ChatsRepository>(),
    GetIt.I<EventsRepository>(),
  ));
  GetIt.I.registerSingleton<ChatCubit>(ChatCubit(
    GetIt.I<EventsRepository>(),
    GetIt.I<CategoriesRepository>(),
    GetIt.I<TagsRepository>(),
  ));
  GetIt.I.registerSingleton<ChatEditorCubit>(ChatEditorCubit());
  GetIt.I.registerSingleton<FiltersCubit>(FiltersCubit(
    GetIt.I<ChatsRepository>(),
    GetIt.I<TagsRepository>(),
    GetIt.I<CategoriesRepository>(),
  ));
  GetIt.I.registerSingleton<StatisticsCubit>(StatisticsCubit(
    GetIt.I<EventsRepository>(),
  ));
}
