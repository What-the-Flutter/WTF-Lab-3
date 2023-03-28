import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/event.dart';
import '../../widgets/date_card.dart';
import '../../widgets/event_card.dart';
import '../settings/settings_cubit.dart';
import 'searching_page_cubit.dart';

class SearchingPage extends StatelessWidget {
  final List<Event> _cards;
  final String chatTitle;
  final Set<String> tags;
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  SearchingPage({
    required cards,
    required this.chatTitle,
    required this.tags,
    required BuildContext context,
    Key? key,
  })  : _cards = cards,
        super(key: key) {
    context.read<SearchingPageCubit>().init(tags, cards);
  }

  Widget _listViewItem(index, cards) {
    final current = cards.elementAt(index);

    if (cards.length == 1 || index == cards.length - 1) {
      return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DateCard(date: current.time),
            EventCard(
              cardModel: current,
              key: UniqueKey(),
            )
          ],
        ),
      );
    } else {
      final next = cards.elementAt(index + 1);
      if (DateFormat('dd-MM-yyyy').format(current.time) !=
          DateFormat('dd-MM-yyyy').format(next.time)) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DateCard(date: current.time),
              EventCard(
                cardModel: current,
                key: UniqueKey(),
              ),
            ],
          ),
        );
      }
      return EventCard(
        cardModel: current,
        key: UniqueKey(),
      );
    }
  }

  Widget _textField(BuildContext context) => TextField(
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: 'Search in $chatTitle',
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
              ),
          filled: true,
          fillColor: context.read<SettingsCubit>().state.isLight
              ? Theme.of(context).primaryColorLight
              : Colors.grey[850],
        ),
        onChanged: context.read<SearchingPageCubit>().updateInput,
      );

  AppBar _appBar(BuildContext context, SearchingPageState state) => AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            context.read<SearchingPageCubit>().clearFoundedEvents();
            Navigator.pop(context);
          },
        ),
        title: _textField(context),
        actions: state.input != ''
            ? [
                IconButton(
                  onPressed: () {
                    context.read<SearchingPageCubit>().updateInput('');
                    _controller.text = '';
                  },
                  icon: const Icon(
                    Icons.cancel,
                  ),
                )
              ]
            : null,
      );

  Widget _addingSearchQueryHintMessage(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColorDark.withAlpha(30),
        child: Column(
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Theme.of(context).dividerColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Please enter a search query to begin searching',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                  ),
            ),
          ],
        ),
      );

  Widget _noFoundHintMessage(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColorDark.withAlpha(30),
        child: Column(
          children: [
            Text(
              'No search results available\n',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                  ),
            ),
            Text(
              'No entries match the given search query. Please try again.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                  ),
            )
          ],
        ),
      );

  Widget _hintMessage(BuildContext context, SearchingPageState state) =>
      state.input == '' && !state.selectedTags.contains(true)
          ? _addingSearchQueryHintMessage(context)
          : _noFoundHintMessage(context);

  Widget _listViewBuilder(List<Event> cards) => ListView.builder(
        reverse: true,
        itemCount: cards.length,
        itemBuilder: (_, index) => _listViewItem(index, cards),
      );

  Widget _tagCard(BuildContext context, int index, SearchingPageState state) =>
      Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: GestureDetector(
          child: Row(
            children: [
              Container(
                child: state.selectedTags.elementAt(index)
                    ? const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.black,
                          size: 16,
                        ),
                      )
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${tags.elementAt(index)}',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ],
          ),
          onTap: () {
            context.read<SearchingPageCubit>().toggleTag(index);
          },
        ),
      );

  Widget _body(BuildContext context, SearchingPageState state) {
    final foundCards = state.foundedEvents;
    print(foundCards.length);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tags.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _tagCard(context, index, state),
          ),
        ),
        foundCards.isEmpty
            ? Expanded(
                flex: 10,
                child: _hintMessage(context, state),
              )
            : Expanded(
                flex: 10,
                child: _listViewBuilder(foundCards),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();
    return BlocBuilder<SearchingPageCubit, SearchingPageState>(
      builder: (context, state) => Scaffold(
        appBar: _appBar(context, state),
        body: _body(context, state),
      ),
    );
  }
}
