part of 'searching_page_cubit.dart';

class SearchingPageState {
  final String input;

  const SearchingPageState({
    this.input = '',
  });

  SearchingPageState copyWith({String? newInput}) {
    return SearchingPageState(input: newInput ?? input);
  }
}
