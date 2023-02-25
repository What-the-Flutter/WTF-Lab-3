import 'package:flutter/material.dart';

// formater

class AppBarBuilder {
  final String title;
  final VoidCallback onBackButton;
  final VoidCallback onResetSelection;
  final VoidCallback onShowFavorite;
  final VoidCallback onRemoval;
  final VoidCallback onMarkFavorites;
  final VoidCallback onEditAction;
  final VoidCallback onCloseEditMode;
  final VoidCallback onCopyAction;

  const AppBarBuilder({
    required this.title,
    required this.onBackButton,
    required this.onResetSelection,
    required this.onShowFavorite,
    required this.onRemoval,
    required this.onMarkFavorites,
    required this.onEditAction,
    required this.onCloseEditMode,
    required this.onCopyAction,
  });

  Widget _createFavoriteAction(bool showFavorites) {
    final Icon bookmarkIcon;
    if (showFavorites) {
      bookmarkIcon = const Icon(Icons.bookmark, color: Colors.deepOrange);
    } else {
      bookmarkIcon = const Icon(Icons.bookmark_border);
    }

    return IconButton(
      icon: bookmarkIcon,
      onPressed: onShowFavorite,
    );
  }

  Widget _createSearchAction() {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => {},
    );
  }

  Widget _createCloseEditModeAction() {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: onCloseEditMode,
    );
  }

  Widget _createDeleteAction() {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: onRemoval,
    );
  }

  Widget _createCopyAction() {
    return IconButton(
      icon: const Icon(Icons.copy),
      onPressed: onCopyAction,
    );
  }

  Widget _createMarkFavoriteAction() {
    return IconButton(
      icon: const Icon(Icons.bookmark_border),
      onPressed: onMarkFavorites,
    );
  }

  Widget _createEditAction() {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: onEditAction,
    );
  }

  Widget _createAppBarLeading(int countSelected, bool isEditMode) {
    if (countSelected == 0) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackButton,
      );
    } else if (isEditMode) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onCloseEditMode,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: onResetSelection,
      );
    }
  }

  Widget _createAppBarTitle(int countSelected, bool isEditMode) {
    if (countSelected == 0) {
      return Text(title);
    } else if (isEditMode) {
      return const Text('Edit mode');
    } else {
      final count = countSelected;
      return Text(count.toString());
    }
  }

  List<Widget> _createActions({
    int countSelected = 0,
    bool showFavorites = false,
    bool isEditMode = false,
    bool isHasImage = false,
  }) {
    final actions = <Widget>[];

    if (countSelected == 0) {
      actions.add(_createSearchAction());
      actions.add(_createFavoriteAction(showFavorites));
    } else if (isEditMode) {
      actions.add(_createCloseEditModeAction());
    } else {
      if (!isHasImage) {
        if (countSelected == 1) {
          actions.add(_createEditAction());
        }

        actions.add(_createCopyAction());
      }

      actions.add(_createMarkFavoriteAction());
      actions.add(_createDeleteAction());
    }

    return actions;
  }

  AppBar build({
    int countSelected = 0,
    bool showFavorites = false,
    bool isEditMode = false,
    bool isHasImage = false,
  }) {
    return AppBar(
      leading: _createAppBarLeading(countSelected, isEditMode),
      title: _createAppBarTitle(countSelected, isEditMode),
      actions: _createActions(
        countSelected: countSelected,
        showFavorites: showFavorites,
        isEditMode: isEditMode,
        isHasImage: isHasImage,
      ),
    );
  }
}
