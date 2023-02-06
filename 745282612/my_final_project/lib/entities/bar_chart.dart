import 'package:equatable/equatable.dart';

class BarChartData extends Equatable {
  final String dateX;
  final int totalY;
  final int bookmarksY;
  final int labelsY;
  final int answersY;

  BarChartData({
    required this.labelsY,
    required this.bookmarksY,
    required this.dateX,
    required this.totalY,
    required this.answersY,
  });

  @override
  List<Object?> get props => [
        dateX,
        totalY,
        bookmarksY,
        answersY,
        labelsY,
      ];
}
