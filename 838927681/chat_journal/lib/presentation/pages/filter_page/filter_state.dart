import 'package:equatable/equatable.dart';

import '../../../domain/entities/chat.dart';

class FilterState extends Equatable {
  final bool ignoreSelected;
  final List<Chat> chats;
  final List<String> filterChats;

  const FilterState({
    required this.ignoreSelected,
    required this.chats,
    required this.filterChats,
  });

  FilterState copyWith({
    bool? ignoreSelected,
    List<Chat>? chats,
    List<String>? filterChats,
  }) {
    return FilterState(
      ignoreSelected: ignoreSelected ?? this.ignoreSelected,
      chats: chats ?? this.chats,
      filterChats: filterChats ?? this.filterChats,
    );
  }

  @override
  List<Object?> get props => [ignoreSelected, chats, filterChats];
}
