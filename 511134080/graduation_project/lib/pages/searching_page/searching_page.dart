import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/event.dart';
import '../../widgets/date_card.dart';
import '../../widgets/event_card.dart';
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
    Key? key,
  })  : _cards = cards,
        super(key: key);

  Widget _createListViewItem(index, cards) {
    final current = cards.elementAt(index);

    if (cards.length == 1 || index == cards.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateCard(date: current.time),
          EventCard(cardModel: current, key: UniqueKey()),
        ],
      );
    } else {
      final next = cards.elementAt(index + 1);
      if (DateFormat('dd-MM-yyyy').format(current.time) !=
          DateFormat('dd-MM-yyyy').format(next.time)) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateCard(date: current.time),
            EventCard(cardModel: current, key: UniqueKey()),
          ],
        );
      }
      return EventCard(cardModel: current, key: UniqueKey());
    }
  }

  Widget _createTextField(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: 'Search in \'$chatTitle\'',
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
            ),
        filled: true,
        fillColor: Theme.of(context).primaryColorLight,
      ),
      onChanged: (value) {
        context.read<SearchingPageCubit>().updateInput(value);
      },
    );
  }

  AppBar _createAppBar(BuildContext context, SearchingPageState state) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Theme.of(context).primaryColor,
      title: _createTextField(context),
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

  Widget _createHintMessage(BuildContext context, SearchingPageState state) {
    if (state.input == '') {
      return Container(
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
    } else {
      return Container(
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
    }
  }

  Widget _createListViewBuilder(List<Event> cards) {
    return ListView.builder(
      reverse: true,
      itemCount: cards.length,
      itemBuilder: (_, index) => _createListViewItem(index, cards),
    );
  }

  Widget _createBody(BuildContext context, SearchingPageState state) {
    final foundCards = state.input == ''
        ? <Event>[]
        : List<Event>.from(
            _cards.reversed.where(
              (Event event) => event.title.contains(state.input),
            ),
          );

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tags.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    Text(
                      '${tags.elementAt(index)}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        foundCards.isEmpty
            ? Expanded(flex: 10, child: _createHintMessage(context, state))
            : Expanded(
                flex: 10,
                child: _createListViewBuilder(foundCards),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();
    return BlocBuilder<SearchingPageCubit, SearchingPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _createAppBar(context, state),
          body: _createBody(context, state),
        );
      },
    );
  }
}
