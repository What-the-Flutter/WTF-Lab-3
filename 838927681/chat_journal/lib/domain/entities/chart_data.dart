import 'package:equatable/equatable.dart';

class ChartData extends Equatable {
  final String dateX;
  final int totalY;

  final int favoritesY;
  final int labelY;

  const ChartData({
    required this.dateX,
    required this.favoritesY,
    required this.labelY,
    required this.totalY,
  });

  @override
  List<Object?> get props => [dateX, totalY, favoritesY, labelY];
}
