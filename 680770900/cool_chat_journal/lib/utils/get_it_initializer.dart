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
    databaseProvider: GetIt.I<DatabaseProvider>(),
  ));
  GetIt.I.registerSingleton<ChatsRepository>(ChatsRepository(
    databaseProvider: GetIt.I<DatabaseProvider>(), 
  ));
  GetIt.I.registerSingleton<TagsRepository>(TagsRepository(
    databaseProvider: GetIt.I<DatabaseProvider>(),
  ));
  GetIt.I.registerSingleton<EventsRepository>(EventsRepository(
    databaseProvider: GetIt.I<DatabaseProvider>(),
    storageProvider: GetIt.I<StorageProvider>(),
    tagsRepository: GetIt.I<TagsRepository>(),
  ));
  GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository(
    settingsProvider: GetIt.I<SettingsProvider>(),
    storageProvider: GetIt.I<StorageProvider>(),
  ));
  

  // Cubits.
  GetIt.I.registerSingleton<SettingsCubit>(SettingsCubit(
    settingsRepository: GetIt.I<SettingsRepository>(),
  ));
  GetIt.I.registerSingleton<HomeCubit>(HomeCubit(
    chatsRepository: GetIt.I<ChatsRepository>(), 
    eventsRepository: GetIt.I<EventsRepository>(),
    settingsCubit: GetIt.I<SettingsCubit>(),
  ));
  GetIt.I.registerSingleton<ChatCubit>(ChatCubit(
    categoriesRepository: GetIt.I<CategoriesRepository>(),
    eventsRepository: GetIt.I<EventsRepository>(),
    tagsRepository: GetIt.I<TagsRepository>(),
    homeCubit: GetIt.I<HomeCubit>(),
  ));
  GetIt.I.registerSingleton<ChatEditorCubit>(ChatEditorCubit(
    homeCubit: GetIt.I<HomeCubit>(),
  ));
  GetIt.I.registerSingleton<FiltersCubit>(FiltersCubit(
    chatsRepository: GetIt.I<ChatsRepository>(), 
    tagsRepository: GetIt.I<TagsRepository>(),
    categoriesRepository: GetIt.I<CategoriesRepository>(),
  ));
}
