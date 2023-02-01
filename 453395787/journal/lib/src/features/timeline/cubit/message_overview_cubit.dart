import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/repository/message_overview_repository_api.dart';
import '../../../common/extensions/date_time_extensions.dart';
import '../../../common/models/ui/message.dart';
import '../../../common/utils/message_filter.dart';
import '../../../common/utils/typedefs.dart';

part 'message_overview_state.dart';

part 'message_overview_cubit.freezed.dart';

class MessageOverviewCubit extends Cubit<MessageOverviewState> {
  MessageOverviewCubit({
    required MessageOverviewRepositoryApi messageOverviewRepository,
  })  : _repository = messageOverviewRepository,
        super(
          MessageOverviewState(
            messages: messageOverviewRepository.messages.value,
          ),
        ) {
    _repository.messages.listen(
      (event) {
        emit(
          state.copyWith(
            messages: event,
          ),
        );
      },
    );
  }

  final MessageOverviewRepositoryApi _repository;

  MessageFilter _filter = const MessageFilter();

  MessageFilter get filter => _filter;

  void applyFilter(MessageFilter filter) {
    _filter = filter;
    _repository.filter(filter);
  }

  void applySearchQuery(String text) {
    _filter = _filter.copyWith(query: text);
    _repository.filter(_filter);
  }

  void showOnlyFavorites(bool isOnlyFavorites) {
    _filter = _filter.copyWith(onlyFavorites: isOnlyFavorites);
    _repository.filter(_filter);
  }
}
