import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../settings/settings_cubit.dart';
import 'timeline_page_cubit.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  AppBar _appBar(BuildContext context) => AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Filters',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Colors.white,
              ),
        ),
      );

  Widget _search(BuildContext context) => Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: _textField(context),
        ),
      );

  TextField _textField(BuildContext context) => TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          hintText: 'Search Query',
          hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.grey[
                    context.read<SettingsCubit>().state.isLight ? 600 : 300],
              ),
          filled: true,
          fillColor: Colors
              .grey[context.read<SettingsCubit>().state.isLight ? 300 : 800],
        ),
      );

  Widget _tabBar(BuildContext context) => Expanded(
        flex: 1,
        child: TabBar(
          indicatorColor: Colors.deepPurple,
          labelColor: Colors.deepPurple,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w400,
              ),
          padding: const EdgeInsets.all(8),
          tabs: [
            _pagesTab(),
            _tagsTab(),
            _labelsTag(),
            _othersTag(),
          ],
        ),
      );

  Widget _pagesTab() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Tab(
          text: 'Pages',
        ),
      );

  Widget _tagsTab() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Tab(
          text: 'Tags',
        ),
      );

  Widget _labelsTag() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Tab(
          text: 'Labels',
        ),
      );

  Widget _othersTag() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Tab(
          text: 'Others',
        ),
      );

  Widget _tabBarView(BuildContext context) => Expanded(
        flex: 9,
        child: TabBarView(
          children: [
            _pagesTabView(context),
            _tagsTabView(context),
            _labelsTabView(context),
            _otherTabView(context),
          ],
        ),
      );

  Widget _pagesTabView(BuildContext context) => Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 40,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
            color: Colors
                .grey[context.read<SettingsCubit>().state.isLight ? 300 : 800],
            child: _pagesHintText(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _ignorePagesTile(context),
          ),
          _allPages(context),
        ],
      );

  Text _pagesHintText(BuildContext context) => Text(
        'Tap to select a page you want to include to the '
        'filter. All pages are included by default.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 800 : 300],
            ),
      );

  Widget _ignorePagesTile(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: ListTile(
          title: Text(
            'Ignore selected pages',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.grey[
                      context.read<SettingsCubit>().state.isLight ? 800 : 400],
                ),
          ),
          subtitle: Text(
            'If enabled, the selected page(s) won\'t be displayed',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          trailing: _pagesSwitch(context),
        ),
      );

  Switch _pagesSwitch(BuildContext context) => Switch(
        value: true,
        onChanged: (_) {},
        activeColor: Theme.of(context).primaryColorLight,
      );

  Widget _allPages(BuildContext context) =>
      BlocBuilder<TimelinePageCubit, TimelinePageState>(
        builder: (context, state) {
          return Wrap(
            spacing: 16,
            runSpacing: 24,
            children: [
              for (final chat in state.allChats)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        16,
                      ),
                    ),
                  ),
                  child: Text(
                    chat.title,
                  ),
                )
            ],
          );
        },
      );

  Widget _tagsTabView(BuildContext context) => Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 40,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
            color: Colors
                .grey[context.read<SettingsCubit>().state.isLight ? 300 : 800],
            child: _tagsHintText(context),
          ),
          _allTags(context),
        ],
      );

  Text _tagsHintText(BuildContext context) => Text(
        'Tap to select a tag you want to include to the '
        'filter. All tags are included by default.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 800 : 300],
            ),
      );

  Widget _allTags(BuildContext context) =>
      BlocBuilder<TimelinePageCubit, TimelinePageState>(
        builder: (context, state) {
          return Wrap(
            spacing: 16,
            runSpacing: 24,
            children: [
              for (final tag in state.tags)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        16,
                      ),
                    ),
                  ),
                  child: Text(
                    tag,
                  ),
                )
            ],
          );
        },
      );

  Widget _labelsTabView(BuildContext context) => Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 40,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
            color: Colors
                .grey[context.read<SettingsCubit>().state.isLight ? 300 : 800],
            child: _labelsHintText(context),
          ),
          _allLabels(context),
        ],
      );

  Text _labelsHintText(BuildContext context) => Text(
        'Tap to select a label you want to include to the '
        'filter. All labels are included by default.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 800 : 300],
            ),
      );

  Widget _allLabels(BuildContext context) =>
      BlocBuilder<TimelinePageCubit, TimelinePageState>(
        builder: (context, state) {
          return Wrap(
            spacing: 16,
            runSpacing: 24,
            children: [
              for (final categoryIcon in categoryIcons)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        16,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        categoryIcon,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        categoryTitles.elementAt(
                          categoryIcons.indexOf(
                            categoryIcon,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          );
        },
      );

  Widget _otherTabView(BuildContext context) => Column(
        children: [
          _dateTile(context),
          _todoTile(context),
        ],
      );

  Widget _dateTile(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListTile(
          iconColor: Colors
              .grey[context.read<SettingsCubit>().state.isLight ? 600 : 300],
          leading: const Icon(
            Icons.event,
          ),
          title: Text(
            'Jump to date',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.grey[
                      context.read<SettingsCubit>().state.isLight ? 800 : 400],
                ),
          ),
          subtitle: Text(
            'None(Experimental)',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ),
      );

  Widget _todoTile(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListTile(
          iconColor: Colors
              .grey[context.read<SettingsCubit>().state.isLight ? 600 : 300],
          leading: const Icon(
            Icons.check,
          ),
          title: Text(
            'Show Todo items only',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.grey[
                      context.read<SettingsCubit>().state.isLight ? 800 : 400],
                ),
          ),
          subtitle: Text(
            'If enabled, displays events that are only checked',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          trailing: _todoSwitch(context),
        ),
      );

  Switch _todoSwitch(BuildContext context) => Switch(
        value: false,
        onChanged: (_) {},
        activeColor: Theme.of(context).primaryColorLight,
      );

  Widget _appplyButton(BuildContext context) => SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          elevation: 16,
          child: const Icon(
            Icons.check,
            size: 32,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(context),
        body: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              _search(context),
              _tabBar(context),
              _tabBarView(context),
            ],
          ),
        ),
        floatingActionButton: _appplyButton(context),
      );
}
