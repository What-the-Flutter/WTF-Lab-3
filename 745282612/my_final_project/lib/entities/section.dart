import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SectionField {
  static final String id = 'id';
  static final String iconSection = 'icon';
  static final String titleSection = 'title';
}

class Section extends Equatable {
  final int id;
  final IconData iconSection;
  final String titleSection;

  Section({
    required this.id,
    required this.iconSection,
    required this.titleSection,
  });

  Map<String, dynamic> toMap() {
    return {
      '${SectionField.id}': id,
      '${SectionField.iconSection}': iconSection.codePoint,
      '${SectionField.titleSection}': titleSection.toString(),
    };
  }

  static Section fromJson(Map<dynamic, dynamic> map) {
    return Section(
      id: map['${SectionField.id}'],
      iconSection: IconData(map['${SectionField.iconSection}'], fontFamily: 'MaterialIcons'),
      titleSection: map['${SectionField.titleSection}'],
    );
  }

  Section copyWith({
    int? id,
    IconData? iconSection,
    String? titleSection,
  }) {
    return Section(
      id: id ?? this.id,
      iconSection: iconSection ?? this.iconSection,
      titleSection: titleSection ?? this.titleSection,
    );
  }

  @override
  List<Object?> get props => [
        id,
        iconSection,
        titleSection,
      ];
}
