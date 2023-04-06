import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../settings/settings_cubit.dart';
import 'filter_page_cubit.dart';

class FilterPage extends StatefulWidget {
  final bool isOnlyPagesFiltered;
  const FilterPage({
    this.isOnlyPagesFiltered = false,
    Key? key,
  }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late final TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    context.read<FilterPageCubit>().init();
    context.read<FilterPageCubit>().setInput(_textFieldController);
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _applyFilters(FilterPageState state) =>
      Navigator.pop(context, state.events);

  AppBar _appBar(FilterPageState state) {
    return AppBar(
      centerTitle: true,
      iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          _applyFilters(state);
        },
      ),
      title: Text(
        'Filters',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }

  Widget _search(FilterPageState state) => Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: _textField(state),
        ),
      );

  Widget _textField(FilterPageState state) {
    return TextField(
      controller: _textFieldController,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).secondaryHeaderColor,
          ),
      decoration: InputDecoration(
        isDense: true,
        labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.normal,
            ),
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: state.input != ''
            ? IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.black,
                ),
                onPressed: () {
                  context
                      .read<FilterPageCubit>()
                      .changeInput('', _textFieldController);
                },
              )
            : null,
        hintText: 'Search Query',
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 600 : 300],
            ),
        filled: true,
        fillColor: Colors
            .grey[context.read<SettingsCubit>().state.isLight ? 300 : 800],
      ),
      onChanged: (value) {
        context
            .read<FilterPageCubit>()
            .changeInput(value, _textFieldController);
      },
    );
  }

  Widget _tabBar() {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Container(
          height: 64,
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
        ),
      ),
    );
  }

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

  Widget _tabBarView(FilterPageState state) => Expanded(
        flex: 9,
        child: TabBarView(
          children: [
            _pagesTabView(state),
            _tagsTabView(state),
            _categoriesTabView(state),
            _otherTabView(),
          ],
        ),
      );

  Widget _pagesTabView(FilterPageState state) {
    return Column(
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
          height: 104,
          color: context.read<SettingsCubit>().state.isLight
              ? Colors.grey[300]
              : Colors.deepPurple[300],
          child: state.selectedPages.isEmpty
              ? _pagesHintText()
              : _pagesSelectedText(state),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _ignorePagesTile(state),
        ),
        _allPages(state),
      ],
    );
  }

  Text _pagesHintText() => Text(
        'Tap to select a page you want to include to the '
        'filter. All pages are included by default.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 800 : 300],
            ),
      );

  Text _pagesSelectedText(FilterPageState state) => Text(
        '${state.selectedPages.length} page(s) ${state.isIgnoreSelectedPages ? 'ignored' : 'included'}',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 800 : 300],
            ),
      );

  Widget _ignorePagesTile(FilterPageState state) {
    return Padding(
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
        trailing: _pagesSwitch(state),
      ),
    );
  }

  Switch _pagesSwitch(FilterPageState state) => Switch(
        value: state.isIgnoreSelectedPages,
        onChanged: context.read<FilterPageCubit>().togglePagesSwitch,
        activeColor: Theme.of(context).primaryColorLight,
      );

  Widget _allPages(FilterPageState state) {
    return Wrap(
      spacing: 16,
      runSpacing: 24,
      children: [
        for (final chat in state.chats)
          GestureDetector(
            onTap: () {
              context.read<FilterPageCubit>().toggleSelectedChat(chat.id);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    24,
                  ),
                ),
                border: state.selectedPages.contains(chat.id)
                    ? Border.all(
                        color: Colors.deepPurple,
                        width: 2,
                      )
                    : null,
              ),
              child: Text(
                chat.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.7),
                    ),
              ),
            ),
          )
      ],
    );
  }

  Widget _tagsTabView(FilterPageState state) {
    return Column(
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
          height: 104,
          color: context.read<SettingsCubit>().state.isLight
              ? Colors.grey[300]
              : Colors.deepPurple[300],
          child: state.selectedTags.isEmpty
              ? _tagsHintText()
              : _tagsSelectedText(state),
        ),
        _allTags(state),
      ],
    );
  }

  Text _tagsHintText() => Text(
        'Tap to select a tag you want to include to the '
        'filter. All tags are included by default.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 800 : 300],
            ),
      );

  Text _tagsSelectedText(FilterPageState state) => Text(
        '${state.selectedTags.length} tag(s) selected',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 800 : 300],
            ),
      );

  Widget _allTags(FilterPageState state) {
    return Wrap(
      spacing: 16,
      runSpacing: 24,
      children: [
        for (final tag in state.tags)
          GestureDetector(
            onTap: () {
              context.read<FilterPageCubit>().toggleSelectedTag(tag);
            },
            child: Container(
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
                border: state.selectedTags.contains(tag)
                    ? Border.all(
                        color: Colors.deepPurple,
                        width: 2,
                      )
                    : null,
              ),
              child: Text(
                tag,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.7),
                    ),
              ),
            ),
          )
      ],
    );
  }

  Widget _categoriesTabView(FilterPageState state) {
    return Column(
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
          height: 104,
          color: context.read<SettingsCubit>().state.isLight
              ? Colors.grey[300]
              : Colors.deepPurple[300],
          child: state.selectedCategories.isEmpty
              ? _categoriesHintText()
              : _categorySelectedText(state),
        ),
        _allCategories(state),
      ],
    );
  }

  Text _categoriesHintText() => Text(
        'Tap to select a label you want to include to the '
        'filter. All labels are included by default.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 800 : 300],
            ),
      );

  Text _categorySelectedText(FilterPageState state) => Text(
        '${state.selectedCategories.length} label(s) selected',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.grey[
                  context.read<SettingsCubit>().state.isLight ? 800 : 300],
            ),
      );

  Widget _allCategories(FilterPageState state) {
    return Wrap(
      spacing: 16,
      runSpacing: 24,
      children: [
        for (final categoryTitle in categoryTitles)
          GestureDetector(
            onTap: () {
              context
                  .read<FilterPageCubit>()
                  .toggleSelectedCategory(categoryTitle);
            },
            child: Container(
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
                border: state.selectedCategories.contains(categoryTitle)
                    ? Border.all(
                        color: Colors.deepPurple,
                        width: 2,
                      )
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    categoryIcons.elementAt(
                      categoryTitles.indexOf(
                        categoryTitle,
                      ),
                    ),
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    categoryTitle,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.7),
                        ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }

  Widget _otherTabView() => Column(
        children: [
          _dateTile(),
        ],
      );

  Widget _dateTile() {
    return Padding(
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
  }

  Switch _todoSwitch() => Switch(
        value: false,
        onChanged: (_) {},
        activeColor: Theme.of(context).primaryColorLight,
      );

  Widget _applyButton(FilterPageState state) {
    return SizedBox(
      height: 64,
      width: 64,
      child: FloatingActionButton(
        onPressed: () {
          _applyFilters(state);
        },
        elevation: 16,
        child: const Icon(
          Icons.check,
          size: 32,
        ),
      ),
    );
  }

  Widget _body(FilterPageState state) {
    if (!widget.isOnlyPagesFiltered) {
      return DefaultTabController(
        length: 4,
        child: Column(
          children: [
            _search(state),
            _tabBar(),
            _tabBarView(state),
          ],
        ),
      );
    }
    return Column(
      children: [
        _pagesTabView(state),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterPageCubit, FilterPageState>(
      builder: (_, state) => Scaffold(
        appBar: _appBar(state),
        body: _body(state),
        floatingActionButton: _applyButton(state),
      ),
    );
  }
}
