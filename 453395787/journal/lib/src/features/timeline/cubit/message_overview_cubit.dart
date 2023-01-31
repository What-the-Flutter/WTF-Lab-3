import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/repository/message_overview_repository_api.dart';
import '../../../common/models/ui/message.dart';
import '../../../common/utils/filter.dart';
import '../../../common/utils/typedefs.dart';

part 'message_overview_state.dart';

part 'message_overview_cubit.freezed.dart';

class MessageOverviewCubit extends Cubit<MessageOverviewState> {
  MessageOverviewCubit({
    required MessageOverviewRepositoryApi messageOverviewRepository,
  })  : _messageOverviewRepository = messageOverviewRepository,
        super(
          MessageOverviewState(
            messages: messageOverviewRepository.messages.value,
          ),
        ) {
    _messageOverviewRepository.messages.listen(
      (event) {
        emit(
          state.copyWith(
            messages: event,
          ),
        );
      },
    );
  }

  final MessageOverviewRepositoryApi _messageOverviewRepository;

  Filter _filter = const Filter();

  Filter get filter => _filter;

  void setFilter(Filter filter) {
    _filter = filter;
    _messageOverviewRepository.filter(filter);
  }

  void setSearchQuery(String text) {
    _filter = _filter.copyWith(query: text);
    _messageOverviewRepository.filter(_filter);
  }

  void setIsFavorite(bool isFavorite) {
    _filter = _filter.copyWith(onlyFavorites: isFavorite);
    _messageOverviewRepository.filter(_filter);
  }

  void reset() {
    _messageOverviewRepository.filter(const Filter());
  }
}
