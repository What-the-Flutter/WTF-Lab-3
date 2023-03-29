import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../json_kit.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final String id;
  final String title;
  final int icon;

  @BooleanConverter()
  final bool isCustom;

  Category({
    String? id,
    required this.title,
    required this.icon,
    required this.isCustom,
  }) : id = id ?? const Uuid().v4();

  factory Category.fromJson(JsonMap json) => _$CategoryFromJson(json);

  JsonMap toJson() => _$CategoryToJson(this);

  Category copyWith({
    String? id,
    String? title,
    int? icon,
    bool? isCustom,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        isCustom: isCustom ?? this.isCustom,
      );
}
