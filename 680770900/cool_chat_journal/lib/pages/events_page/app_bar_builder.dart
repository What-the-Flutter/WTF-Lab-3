import 'package:flutter/material.dart';

class AppBarBuilder {

  final String title;

  final VoidCallback handleBackButton;
  final VoidCallback handleResetSelection;
  final VoidCallback handleShowFavorite;
  final VoidCallback handleRemoval;
  final VoidCallback handleMarkFavorites;
  final VoidCallback handleEditAction;
  final VoidCallback handleCloseEditMode;

  const AppBarBuilder({
    required this.title,
    required this.handleBackButton,
    required this.handleResetSelection,
    required this.handleShowFavorite,
    required this.handleRemoval,
    required this.handleMarkFavorites,
    required this.handleEditAction,
    required this.handleCloseEditMode,
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

  Widget buildCloseEditModeAction() {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: handleCloseEditMode,
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
      onPressed: handleEditAction,
    );
  }

  Widget buildAppBarLeading(int countSelected, bool isEditMode) {
    if (countSelected == 0) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: handleBackButton,
      );
    } else if (isEditMode) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: handleCloseEditMode,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: handleResetSelection,
      );
    }
  }

  Widget buildAppBarTitle(int countSelected, bool isEditMode) {
    if (countSelected == 0) {
      return Text(title);
    } else if (isEditMode) {
      return const Text('Edit mode');
    } else {
      var count = countSelected;
      return Text(count.toString());
    }
  }

  List<Widget> buildActions(
    int countSelected,
    bool showFavorites,
    bool isEditMode
  ) {
    var actions = <Widget>[];

    if (countSelected == 0) {
      actions.add(buildSearchAction());
      actions.add(buildFavoriteAction(showFavorites));
    } else if (isEditMode) {
      actions.add(buildCloseEditModeAction());
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

  AppBar build({
    int countSelected = 0,
    bool showFavorites = false,
    bool isEditMode = false,
  }) {
    return AppBar(
      leading: buildAppBarLeading(countSelected, isEditMode),
      title: buildAppBarTitle(countSelected, isEditMode),
      actions: buildActions(countSelected, showFavorites, isEditMode),
    );
  }
}