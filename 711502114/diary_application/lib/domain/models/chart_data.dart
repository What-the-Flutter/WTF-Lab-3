import 'package:equatable/equatable.dart';

class ChartData extends Equatable {
  final String dataX;
  final int favoritesY;
  final int labelY;
  final int totalY;

  const ChartData({
    required this.dataX,
    required this.favoritesY,
    required this.labelY,
    required this.totalY,
  });

  @override
  List<Object?> get props => [dataX, favoritesY, labelY, totalY];
}
