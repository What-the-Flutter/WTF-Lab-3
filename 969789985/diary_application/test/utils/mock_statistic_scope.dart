import 'package:mockito/annotations.dart';
import 'package:diary_application/src/feature/cubit/statistic/statistic_cubit.dart';
import 'package:diary_application/src/core/domain/repository/statistic/api_statistic_repository.dart';

@GenerateMocks([StatisticCubit, StatisticState, ApiStatisticRepository])
import 'mock_statistic_scope.mocks.dart';