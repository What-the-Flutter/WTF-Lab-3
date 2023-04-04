import 'package:diary_application/domain/models/event.dart';
import 'package:diary_application/domain/utils/icons.dart';
import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/filter/filter_cubit.dart';
import 'package:diary_application/presentation/pages/filter/filter_state.dart';
import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:diary_application/presentation/widgets/filter/select_info_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterPage extends StatelessWidget {
  final List<Event> events;

  FilterPage({Key? key, required this.events}) : super(key: key);

  final controller = TextEditingController();

  static bool isThisFirstOpen = true;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (!isThisFirstOpen) {
          context.read<FilterCubit>().initChats();
        } else {
          isThisFirstOpen = false;
        }

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)?.filter ?? '',
                style: textTheme(context).headline2,
              ),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(text: local?.pages ?? ''),
                  Tab(text: local?.tags ?? ''),
                  Tab(text: local?.labels ?? ''),
                  Tab(text: local?.other ?? ''),
                ],
              ),
            ),
            body: TabBarView(
              children: [_pages(state, context), _tags(), _labels(), _other()],
            ),
            floatingActionButton: _applyFilterFAB(context),
          ),
        );
      },
    );
  }

  Widget _pages(FilterState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _lookForField(state, context),
          SelectInfoBox(text: _setTapHintText(state, context)),
          _ignoreSwitch(state, context),
          _chatScrollView(state, context),
        ],
      ),
    );
  }

  String _setTapHintText(FilterState state, BuildContext context) {
    final l = AppLocalizations.of(context);
    final count = state.chatTitles.length;
    final text = l?.includingText ?? '';
    final status = state.isIgnore ? l?.ignored ?? '' : l?.included ?? '';
    return state.chatTitles.isEmpty
        ? l?.tapToSelect ?? ''
        : '$count $text $status';
  }

  Widget _lookForField(FilterState state, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: textTheme(context).bodyText2!,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: AppLocalizations.of(context)?.searchQuery ?? '',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: BlocProvider.of<SettingsCubit>(context).isDark
                      ? Colors.grey
                      : Colors.white,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ignoreSwitch(FilterState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.ignoreSelect ?? '',
                  style: textTheme(context).bodyText1,
                ),
                const SizedBox(height: 5),
                Text(
                  AppLocalizations.of(context)?.ifIgnoreEnabled ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: context.watch<FilterCubit>().state.isIgnore,
            onChanged: context.read<FilterCubit>().changeIgnoreStatus,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _chatScrollView(FilterState state, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 5,
          runSpacing: 10,
          children: [
            for (final chat in state.chats)
              GestureDetector(
                onTap: () => context
                    .read<FilterCubit>()
                    .addOrDeleteFilterSettings(chat.id),
                child: UnconstrainedBox(
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: state.chatTitles.contains(chat.id)
                          ? const Color.fromRGBO(77, 157, 206, 0.7)
                          : const Color.fromRGBO(37, 47, 57, 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOutQuint,
                    child: Row(
                      children: [
                        if (state.chatTitles.contains(chat.id)) ...[
                          const Icon(Icons.done),
                          const SizedBox(width: 5),
                        ],
                        Icon(IconMap.data[chat.iconNumber]),
                        const SizedBox(width: 3),
                        Text(
                          chat.title,
                          style: textTheme(context).bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _tags() {
    return const Center(child: Text(':-)'));
  }

  Widget _labels() {
    return const Center(child: Text(':-)'));
  }

  Widget _other() {
    return const Center(child: Text(':-)'));
  }

  Widget _applyFilterFAB(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.done, size: 30),
      onPressed: () async {
        Navigator.of(context).pop(
          context.read<FilterCubit>().filterChats(lookFor: controller.text),
        );
      },
    );
  }
}
