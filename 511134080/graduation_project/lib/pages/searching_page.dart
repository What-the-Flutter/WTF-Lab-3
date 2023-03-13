import 'package:flutter/material.dart';
import 'package:graduation_project/models/event_card_model.dart';
import 'package:intl/intl.dart';

import '../widgets/date_card.dart';
import '../widgets/event_card.dart';

class SearchingPage extends StatefulWidget {
  final List<EventCardModel> cards;
  const SearchingPage({required this.cards, Key? key}) : super(key: key);

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  String input = '';

  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  Widget _createListViewItem(index, cards) {
    final current = cards.elementAt(index);

    if (cards.length == 1 || index == cards.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateCard(date: current.time),
          EventCard(cardModel: current, key: current.id),
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
            EventCard(cardModel: current, key: current.id),
          ],
        );
      }
      return EventCard(cardModel: current, key: current.id);
    }
  }

  AppBar _createAppBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Theme.of(context).primaryColor,
      title: TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).primaryColorLight,
        ),
        onChanged: (value) {
          setState(
            () {
              input = value;
            },
          );
        },
      ),
      actions: input != ''
          ? [
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      input = '';
                      _controller.text = '';
                    },
                  );
                },
                icon: const Icon(
                  Icons.cancel,
                ),
              )
            ]
          : null,
    );
  }

  Widget _createHintMessage() {
    if (input == '') {
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
            const Text(
              'Please enter a search query to begin searching',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColorDark.withAlpha(30),
        child: const Column(
          children: [
            Text(
              'No search results available\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'No entries match the given search query. Please try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _createListViewBuilder(List<EventCardModel> cards) {
    return ListView.builder(
      reverse: true,
      itemCount: cards.length,
      itemBuilder: (_, index) => _createListViewItem(index, cards),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<EventCardModel> foundCards = input == ''
        ? []
        : List<EventCardModel>.from(
            widget.cards.reversed.where(
              (EventCardModel card) => card.title.contains(input),
            ),
          );

    return Scaffold(
      appBar: _createAppBar(),
      body: foundCards.isEmpty
          ? _createHintMessage()
          : _createListViewBuilder(foundCards),
    );
  }
}
