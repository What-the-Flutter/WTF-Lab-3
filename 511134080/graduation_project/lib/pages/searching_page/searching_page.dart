import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/event.dart';
import '../../widgets/date_card.dart';
import '../../widgets/event_card.dart';
import '../../widgets/search_animation.dart';
import '../settings/settings_cubit.dart';
import 'searching_page_cubit.dart';

class SearchingPage extends StatefulWidget {
  final List<Event> _cards;
  final String _chatTitle;
  final Set<String> _tags;

  SearchingPage({
    required cards,
    required String chatTitle,
    required Set<String> tags,
    required BuildContext context,
    Key? key,
  })  : _tags = tags,
        _chatTitle = chatTitle,
        _cards = cards,
        super(key: key);

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  late final FocusNode _focusNode;

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    _controller = TextEditingController();
    context.read<SearchingPageCubit>().init(widget._tags, widget._cards);
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
              shouldShowChatTitle: true,
              event: current,
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
                shouldShowChatTitle: true,
                event: current,
                key: UniqueKey(),
              ),
            ],
          ),
        );
      }
      return EventCard(
        shouldShowChatTitle: true,
        event: current,
        key: UniqueKey(),
      );
    }
  }

  Widget _textField() {
    return TextField(
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: 'Search in ${widget._chatTitle}',
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
            ),
        filled: true,
        fillColor: context.read<SettingsCubit>().state.isLight
            ? Theme.of(context).primaryColorLight
            : Colors.grey[850],
      ),
      onChanged: context.read<SearchingPageCubit>().updateInput,
      onSubmitted: (_) {
        context.read<SearchingPageCubit>().startLoading();
      },
    );
  }

  AppBar _appBar(SearchingPageState state) {
    return AppBar(
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
      title: _textField(),
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
  }

  Widget _addingSearchQueryHintMessage() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColorLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
  }

  Widget _noFoundHintMessage() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColorLight,
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
  }

  Widget _hintMessage(SearchingPageState state) =>
      state.input == '' && !state.selectedTags.contains(true)
          ? _addingSearchQueryHintMessage()
          : _noFoundHintMessage();

  Widget _listViewBuilder(List<Event> cards) => ListView.builder(
        reverse: true,
        itemCount: cards.length,
        itemBuilder: (_, index) => _listViewItem(index, cards),
      );

  Widget _tagCard(int index, SearchingPageState state) {
    return SingleChildScrollView(
      child: Container(
        height: 32,
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
                  '${widget._tags.elementAt(index)}',
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
      ),
    );
  }

  Widget _body(SearchingPageState state) {
    final foundCards = state.foundedEvents;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 54,
          child: ListView.builder(
            itemCount: widget._tags.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _tagCard(index, state),
          ),
        ),
        foundCards.isEmpty
            ? _hintMessage(state)
            : Expanded(
                child: _listViewBuilder(foundCards),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchingPageCubit, SearchingPageState>(
      builder: (_, state) => Scaffold(
        appBar: _appBar(state),
        body: state.isLoaded ? searchingAnimation : _body(state),
      ),
    );
  }
}
