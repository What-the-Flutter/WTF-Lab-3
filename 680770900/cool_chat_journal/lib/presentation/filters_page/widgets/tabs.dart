import 'package:flutter/material.dart';

import '../../../data/models/category.dart';
import '../../../data/models/chat.dart';
import '../../../data/models/tag.dart';

class PagesTab extends StatelessWidget {
  final List<Chat> chats;
  final List<Chat> selectedChats;
  final bool ignoreSelected;

  final Function(bool) changeIgnoreSelected;
  final Function(Chat) changeChatSelection;

  const PagesTab({
    super.key,
    required this.chats,
    required this.selectedChats,
    required this.ignoreSelected,
    required this.changeIgnoreSelected,
    required this.changeChatSelection,
  });

  String _welcomeMessage() {
    if (selectedChats.isNotEmpty) {
      return '${selectedChats.length} page(s) '
          '${ignoreSelected ? 'Ignored' : 'Included'}';
    } else {
      return 'Tap to select a page you want to include to the filter. '
          'All pages are included by default';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTab(
      welcomeMessage: _welcomeMessage(),
      switchWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text('Ignore selected pages'),
          ),
          Switch(
            value: ignoreSelected,
            onChanged: changeIgnoreSelected,
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (_, index) {
          final chat = chats[index];
          return ElevatedButton(
            child: Row(
              children: [
                if (selectedChats.contains(chat)) const Icon(Icons.done),
                Icon(
                  IconData(
                    chat.iconCode,
                    fontFamily: 'MaterialIcons',
                  ),
                ),
                Expanded(
                  child: Text(chat.name),
                ),
              ],
            ),
            onPressed: () => changeChatSelection(chat),
          );
        },
      ),
    );
  }
}

class TagsTab extends StatelessWidget {
  final List<Tag> tags;
  final List<Tag> selectedTags;
  
  final Function(Tag) changeTagSelection;

  const TagsTab({
    super.key,
    required this.tags,
    required this.selectedTags,
    required this.changeTagSelection,
  });

  String _welcomeMessage() {
    if (selectedTags.isNotEmpty) {
      return '${selectedTags.length} tags(s) selected';
    } else {
      return 'Tap to select a tag you want to include to the filter.'
          'All tags are included by default';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTab(
      welcomeMessage: _welcomeMessage(),
      child: ListView.builder(
        itemCount: tags.length,
        itemBuilder: (_, index) {
          final tag = tags[index];
          return ElevatedButton(
            child: Row(
              children: [
                if (selectedTags.contains(tag)) const Icon(Icons.done),
                Expanded(
                  child: Text('#${tag.id}'),
                ),
              ],
            ),
            onPressed: () => changeTagSelection(tag),
          );
        },
      ),
    );
  }
}

class CategoriesTab extends StatelessWidget {
  final List<Category> categories;
  final List<Category> selectedCategories;
  final Function(Category) changeCategorySelection;

  const CategoriesTab({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.changeCategorySelection,
  });

  String _welcomeMessage() {
    if (selectedCategories.isNotEmpty) {
      return '${selectedCategories.length} label(s) selected';
    } else {
      return 'Tap to select a label you want to include to the filter.'
          'All labels are included by default';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTab(
      welcomeMessage: _welcomeMessage(),
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (_, index) {
          final category = categories[index];
          return ElevatedButton(
            child: Row(
              children: [
                if (selectedCategories.contains(category))
                  const Icon(Icons.done),
                Icon(
                  IconData(
                    category.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                ),
                Expanded(
                  child: Text(category.title),
                ),
              ],
            ),
            onPressed: () => changeCategorySelection(category),
          );
        },
      ),
    );
  }
}

class _CustomTab extends StatelessWidget {
  final String? welcomeMessage;
  final Widget? switchWidget;
  final Widget child;

  const _CustomTab({
    super.key,
    this.welcomeMessage,
    this.switchWidget,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (welcomeMessage != null)
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                title: Text(
                  welcomeMessage!,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        if (switchWidget != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: switchWidget,
          ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
