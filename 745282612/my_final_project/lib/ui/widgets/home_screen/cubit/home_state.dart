import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:my_final_project/entities/chat.dart';

class HomeState extends Equatable {
  final List<Chat> listChat;
  final bool isEdit;
  final Icon? iconSeleted;
  final bool isStatus;

  HomeState({
    required this.listChat,
    this.isEdit = false,
    this.isStatus = false,
    this.iconSeleted,
  });

  HomeState copyWith({
    List<Chat>? listChat,
    bool? isEdit,
    Icon? iconSeleted,
    bool? isStatus,
    int? indexEdit,
  }) {
    return HomeState(
      listChat: listChat ?? this.listChat,
      isEdit: isEdit ?? this.isEdit,
      iconSeleted: iconSeleted,
      isStatus: isStatus ?? this.isStatus,
    );
  }

  @override
  List<Object?> get props => [
        listChat,
        isEdit,
        iconSeleted,
        isStatus,
      ];
}
