import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import '../../repositories/event_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final EventRepository eventsRepository;
  late final StreamSubscription<List<Event>> eventsSubscription;

  ChatCubit({required this.eventsRepository}) : super(ChatState()) {
    initSubscription();
  }

  void initSubscription() {
    eventsSubscription = eventsRepository.eventsStream.listen((events) async {
      if (state.chat.id.isNotEmpty) {
        final chatEvents = List<Event>.from(
            events.where((event) => event.chatId == state.chat.id))
          ..sort((a, b) => a.time.compareTo(b.time));
        emit(
          state.copyWith(
            newChat: state.chat.copyWith(
              newEvents: chatEvents,
            ),
          ),
        );
      }
    });
  }

  Future<void> init(Chat chat) async {
    emit(state.copyWith(newChat: chat));
  }

  void toggleShowingImageOptions() {
    final isChoosing = state.isChoosingImageOptions;
    emit(
      state.copyWith(
        choosingImageOptions: !state.isChoosingImageOptions,
        choosingCategory:
            isChoosing == false ? false : state.isChoosingCategory,
      ),
    );
  }

  Future<void> pickImage(bool isFromGallery) async {
    final PermissionStatus status;
    if (isFromGallery) {
      status = await Permission.mediaLibrary.request();
    } else {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
          source: isFromGallery ? ImageSource.gallery : ImageSource.camera);

      if (pickedFile != null) {
        final event = Event(
          title: '',
          time: DateTime.now(),
          id: '',
          chatId: state.chat.id,
          imagePath: pickedFile.path,
        );
        addEvent(event);
        toggleShowingImageOptions();
      }
    }
  }

  void inputChanged(String value) {
    emit(
      state.copyWith(
        inputEmpty: value.isEmpty,
      ),
    );
  }

  void changeCategoryIcon(int index) {
    if (index == 1) {
      index = 0;
    }
    emit(
      state.copyWith(
        newCategoryIconIndex: index,
      ),
    );
  }

  void toggleChoosingCategory({bool choosingCategory = false}) {
    emit(
      state.copyWith(
        choosingCategory: choosingCategory,
        choosingImageOptions:
            choosingCategory == true ? false : state.isChoosingImageOptions,
      ),
    );
  }

  Future<void> toggleFavourites() async {
    final updatedChat = state.chat.copyWith(
      showingFavourites: !state.chat.isShowingFavourites,
    );
    emit(
      state.copyWith(
        newChat: updatedChat,
      ),
    );
  }

  void toggleEditingMode({bool editingMode = false}) {
    emit(
      state.copyWith(
        editingMode: editingMode,
      ),
    );
  }

  void onEnterSubmitted(String title) {
    if (!state.isEditingMode) {
      if (title.isNotEmpty || state.categoryIconIndex != 0) {
        final event = Event(
          chatId: state.chat.id,
          title: title,
          time: DateTime.now(),
          id: '',
          categoryIndex: state.categoryIconIndex,
        );

        if (state.isSelectionMode) {
          cancelSelectionMode();
        }
        addEvent(event);
      }
    } else {
      editSelectedEvent(title, state.categoryIconIndex);
      emit(
        state.copyWith(
          editingMode: false,
        ),
      );
    }
    inputChanged('');
    changeCategoryIcon(0);
  }

  Future<void> addEvent(Event event) async {
    await eventsRepository.insertEvent(event);
  }

  Null Function()? onEditButtonPressed(
      TextEditingController textFieldController, FocusNode focusNode) {
    final selectedEvents = List<Event>.from(
        state.chat.events.where((Event cardModel) => cardModel.isSelected));
    if (selectedEvents.length == 1 &&
        selectedEvents.where((element) => element.imagePath != null).isEmpty) {
      return () {
        toggleEditingMode(
          editingMode: true,
        );
        final event = state.chat.events.where((Event e) => e.isSelected).first;
        textFieldController.text = event.title;

        changeCategoryIcon(event.categoryIndex);
        focusNode.requestFocus();
      };
    } else {
      return null;
    }
  }

  Future<void> editSelectedEvent(String newTitle, int newCategory) async {
    final selectedEvent =
        state.chat.events.where((Event event) => event.isSelected).first;

    await eventsRepository.updateEvent(
      selectedEvent.copyWith(
        newTitle: newTitle,
        newCategory: newCategory,
      ),
    );
    cancelSelectionMode();
  }

  Future<void> cancelSelectionMode() async {
    for (final event in state.chat.events) {
      await eventsRepository.updateEvent(
        event.copyWith(
          isSelected: false,
        ),
      );
    }
    emit(
      state.copyWith(
        selectionMode: false,
      ),
    );
  }

  Future<void> copySelectedEvents() async {
    var text = '';

    final events = state.chat.events.where((Event event) => event.isSelected);

    for (final e in events) {
      if (e.imagePath == null) {
        text += '${e.title}\n';
      }
    }

    cancelSelectionMode();

    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  }

  Future<void> deleteSelectedEvents() async {
    final selectedEvents =
        state.chat.events.where((Event event) => event.isSelected);

    for (final event in selectedEvents) {
      await eventsRepository.deleteEventById(event.id);
    }

    cancelSelectionMode();
  }

  void manageTapEvent(Event event) {
    if (!state.isSelectionMode) {
      manageFavouriteEvent(event);
    } else {
      manageSelectedEvent(event);
    }
  }

  Future<void> manageFavouriteEvent(Event event) async {
    final index = state.chat.events.indexOf(event);
    await eventsRepository.updateEvent(
      state.chat.events[index].copyWith(
        isFavourite: !event.isFavourite,
      ),
    );
  }

  Future<void> manageSelectedEvent(Event event) async {
    final selectedLength =
        state.chat.events.where((Event e) => e.isSelected).length;

    if (selectedLength == 1 && event.isSelected) {
      cancelSelectionMode();
    } else {
      await eventsRepository.updateEvent(
        event.copyWith(
          isSelected: !event.isSelected,
        ),
      );
    }
  }

  Future<void> manageFavouritesFromSelectionMode() async {
    for (final event in state.chat.events) {
      if (event.isSelected) {
        await eventsRepository.updateEvent(
          event.copyWith(
            isFavourite: !event.isFavourite,
            isSelected: false,
          ),
        );
      } else {
        await eventsRepository.updateEvent(
          event.copyWith(
            isSelected: false,
          ),
        );
      }
    }
    emit(
      state.copyWith(
        selectionMode: false,
      ),
    );
  }

  void manageLongPress(Event event) {
    if (!state.isSelectionMode) {
      turnOnSelectionMode(event);
    }
  }

  Future<void> turnOnSelectionMode(Event selectedEvent) async {
    await eventsRepository.updateEvent(
      selectedEvent.copyWith(
        isSelected: true,
      ),
    );

    emit(
      state.copyWith(
        selectionMode: true,
      ),
    );
  }

  Future<void> moveSelectedEvents(Chat destinationChat) async {
    final selectedEvents = state.chat.events.where((Event e) => e.isSelected);

    for (final event in selectedEvents) {
      await eventsRepository.updateEvent(
        event.copyWith(
          newChatId: destinationChat.id,
          isSelected: false,
        ),
      );
    }

    final events = await eventsRepository.receiveAllChatEvents(state.chat.id);

    emit(
      state.copyWith(
        newChat: state.chat.copyWith(
          newEvents: events,
        ),
        selectionMode: false,
      ),
    );
  }
}
