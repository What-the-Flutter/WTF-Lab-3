import 'package:flutter/material.dart';

class AppBarBuilder {

  final String title;

  final VoidCallback handleBackButton;
  final VoidCallback handleResetSelection;
  final VoidCallback handleShowFavorite;
  final VoidCallback handleRemoval;
  final VoidCallback handleMarkFavorites;

  const AppBarBuilder({
    required this.title,
    required this.handleBackButton,
    required this.handleResetSelection,
    required this.handleShowFavorite,
    required this.handleRemoval,
    required this.handleMarkFavorites,
  });

  Widget buildFavoriteAction(bool showFavorites) {
    Icon bookmarkIcon;
    if (showFavorites) {
      bookmarkIcon = const Icon(Icons.bookmark, color: Colors.deepOrange);
    } else {
      bookmarkIcon = const Icon(Icons.bookmark_border);
    }

    return IconButton(
      icon: bookmarkIcon,
      onPressed: handleShowFavorite,
    );
  }

  Widget buildSearchAction() {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => {},
    );
  }

  Widget buildDeleteAction() {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: handleRemoval,
    );
  }

  Widget buildCopyAction() {
    return IconButton(
      icon: const Icon(Icons.copy),
      onPressed: handleResetSelection,
    );
  }

  Widget buildMarkFavoriteAction() {
    return IconButton(
      icon: const Icon(Icons.bookmark_border),
      onPressed: handleMarkFavorites,
    );
  }

  Widget buildEditAction() {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: handleResetSelection,
    );
  }

  Widget buildAppBarLeading(int countSelected) {
    if (countSelected == 0) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: handleBackButton,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: handleResetSelection,
      );
    }
  }

  Widget buildAppBarTitle(int countSelected) {
    if (countSelected == 0) {
      return Text(title);
    } else {
      var count = countSelected;
      return Text(count.toString());
    }
  }

  List<Widget> buildActions(int countSelected, bool showFavorites) {
    var actions = <Widget>[];

    if (countSelected == 0) {
      actions.add(buildSearchAction());
      actions.add(buildFavoriteAction(showFavorites));
    } else {
      if (countSelected == 1) {
        actions.add(buildEditAction());
      }
      actions.add(buildCopyAction());
      actions.add(buildMarkFavoriteAction());
      actions.add(buildDeleteAction());
    }

    return actions;
  }

  AppBar build(int countSelected, bool showFavorites,) {
    return AppBar(
      leading: buildAppBarLeading(countSelected),
      title: buildAppBarTitle(countSelected),
      actions: buildActions(countSelected, showFavorites),
    );
}

}