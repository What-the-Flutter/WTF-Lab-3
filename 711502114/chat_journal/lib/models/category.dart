import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Category extends Equatable {
  final IconData icon;
  final String title;

  Category(this.icon, this.title);

  Category copyWith({IconData? icon, String? title}) {
    return Category(icon ?? this.icon, title ?? this.title);
  }

  @override
  List<Object?> get props => [icon, title];
}
