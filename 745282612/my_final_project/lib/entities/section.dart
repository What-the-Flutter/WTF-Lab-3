import 'package:flutter/material.dart';

class SectionField {
  static final String id = 'id';
  static final String iconSection = 'icon';
  static final String titleSection = 'title';
}

class Section {
  final int? id;
  final IconData iconSection;
  final String titleSection;

  Section({
    this.id,
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
}
