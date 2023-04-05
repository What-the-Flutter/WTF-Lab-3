import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'filters_cubit.dart';
import 'widgets/tabs.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  final _cubit = GetIt.I<FiltersCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersCubit, FiltersState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Filters'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_alt_off_outlined),
                  onPressed: _cubit.resetFilter,
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(child: Text('Pages')),
                  Tab(
                    child: Text('Tags'),
                  ),
                  Tab(
                    child: Text('Labels'),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                PagesTab(
                  chats: state.chats,
                  selectedChats: state.selectedChats,
                  ignoreSelected: state.ignoreSelected,
                  changeChatSelection: _cubit.changeChatSelection,
                  changeIgnoreSelected: _cubit.changeIgnoreSelected,
                ),
                TagsTab(
                  tags: state.tags,
                  selectedTags: state.selectedTags,
                  changeTagSelection: _cubit.changeTagSelection,
                ),
                CategoriesTab(
                  categories: state.categories,
                  selectedCategories: state.selectedCategories,
                  changeCategorySelection: _cubit.changeCategorySelection,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
