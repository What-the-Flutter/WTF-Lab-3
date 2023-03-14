part of 'searching_page_cubit.dart';

class SearchingPageState {
  final String _input;

  const SearchingPageState({
    String input = '',
  }) : _input = input;

  String get input => _input;

  SearchingPageState copyWith({String? newInput}) {
    return SearchingPageState(input: newInput ?? _input);
  }
}
