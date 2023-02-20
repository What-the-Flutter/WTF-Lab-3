import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/icons.dart';
import '../../../cubit/chat/message_search/message_search_cubit.dart';

class MessageSearchField extends StatefulWidget {
  MessageSearchField({super.key});

  @override
  State<MessageSearchField> createState() => _MessageSearchFieldState();
}

class _MessageSearchFieldState extends State<MessageSearchField> {
  late final TextEditingController _searchFieldController;

  double _width = 60.0;

  @override
  void initState() {
    _searchFieldController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageSearchCubit, MessageSearchState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _width,
          curve: state.when(
            defaultMode: (defaultMode) => Curves.decelerate,
            searchActive: (messages, query) => Curves.fastOutSlowIn,
          ),
          child: Row(
            children: [
              _animatedSearchButton(context, state),
              _searchTextField(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _animatedSearchButton(
    BuildContext context,
    MessageSearchState state,
  ) =>
      AnimatedIconButton(
        duration: const Duration(milliseconds: 500),
        onPressed: () {
          state.when(
            defaultMode: (defaultMode) =>
                _width = MediaQuery.of(context).size.width * 0.8,
            searchActive: (messages, query) => _width = 60.0,
          );
          context.read<MessageSearchCubit>().updateSearchMode();
          _searchFieldController.clear();
        },
        icons: [
          AnimatedIconItem(
            icon: Icon(
              Icons.search,
              size: IconsSize.standard,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          AnimatedIconItem(
            icon: Icon(
              Icons.close,
              size: IconsSize.standard,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ],
      );

  Widget _searchTextField(BuildContext context, MessageSearchState state) {
    return Visibility(
      visible: state.maybeWhen(
        defaultMode: (defaultMode) => false,
        searchActive: (messages, query) => true,
        orElse: () => false,
      ),
      child: Expanded(
        child: TextField(
          controller: _searchFieldController,
          autofocus: true,
          onChanged: (value) {
            context.read<MessageSearchCubit>().onQueryChanged(value);
          },
          decoration: const InputDecoration(
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search),
              hintText: 'Search here...'),
        ),
      ),
    );
  }
}
