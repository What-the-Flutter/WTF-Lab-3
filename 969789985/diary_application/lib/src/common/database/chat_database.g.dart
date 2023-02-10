// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_database.dart';

// ignore_for_file: type=lint
class $ChatTableTable extends ChatTable
    with TableInfo<$ChatTableTable, ChatTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _chatTitleMeta =
      const VerificationMeta('chatTitle');
  @override
  late final GeneratedColumn<String> chatTitle = GeneratedColumn<String>(
      'chat_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chatIconMeta =
      const VerificationMeta('chatIcon');
  @override
  late final GeneratedColumn<int> chatIcon = GeneratedColumn<int>(
      'chat_icon', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned =
      GeneratedColumn<bool>('is_pinned', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_pinned" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _isArchiveMeta =
      const VerificationMeta('isArchive');
  @override
  late final GeneratedColumn<bool> isArchive =
      GeneratedColumn<bool>('is_archive', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_archive" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _creationDateMeta =
      const VerificationMeta('creationDate');
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
      'creation_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, chatTitle, chatIcon, isPinned, isArchive, creationDate];
  @override
  String get aliasedName => _alias ?? 'chat_table';
  @override
  String get actualTableName => 'chat_table';
  @override
  VerificationContext validateIntegrity(Insertable<ChatTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_title')) {
      context.handle(_chatTitleMeta,
          chatTitle.isAcceptableOrUnknown(data['chat_title']!, _chatTitleMeta));
    } else if (isInserting) {
      context.missing(_chatTitleMeta);
    }
    if (data.containsKey('chat_icon')) {
      context.handle(_chatIconMeta,
          chatIcon.isAcceptableOrUnknown(data['chat_icon']!, _chatIconMeta));
    } else if (isInserting) {
      context.missing(_chatIconMeta);
    }
    if (data.containsKey('is_pinned')) {
      context.handle(_isPinnedMeta,
          isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));
    } else if (isInserting) {
      context.missing(_isPinnedMeta);
    }
    if (data.containsKey('is_archive')) {
      context.handle(_isArchiveMeta,
          isArchive.isAcceptableOrUnknown(data['is_archive']!, _isArchiveMeta));
    } else if (isInserting) {
      context.missing(_isArchiveMeta);
    }
    if (data.containsKey('creation_date')) {
      context.handle(
          _creationDateMeta,
          creationDate.isAcceptableOrUnknown(
              data['creation_date']!, _creationDateMeta));
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chatTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}chat_title'])!,
      chatIcon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_icon'])!,
      isPinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!,
      isArchive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archive'])!,
      creationDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}creation_date'])!,
    );
  }

  @override
  $ChatTableTable createAlias(String alias) {
    return $ChatTableTable(attachedDatabase, alias);
  }
}

class ChatTableData extends DataClass implements Insertable<ChatTableData> {
  final int id;
  final String chatTitle;
  final int chatIcon;
  final bool isPinned;
  final bool isArchive;
  final DateTime creationDate;
  const ChatTableData(
      {required this.id,
      required this.chatTitle,
      required this.chatIcon,
      required this.isPinned,
      required this.isArchive,
      required this.creationDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_title'] = Variable<String>(chatTitle);
    map['chat_icon'] = Variable<int>(chatIcon);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['is_archive'] = Variable<bool>(isArchive);
    map['creation_date'] = Variable<DateTime>(creationDate);
    return map;
  }

  ChatTableCompanion toCompanion(bool nullToAbsent) {
    return ChatTableCompanion(
      id: Value(id),
      chatTitle: Value(chatTitle),
      chatIcon: Value(chatIcon),
      isPinned: Value(isPinned),
      isArchive: Value(isArchive),
      creationDate: Value(creationDate),
    );
  }

  factory ChatTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatTableData(
      id: serializer.fromJson<int>(json['id']),
      chatTitle: serializer.fromJson<String>(json['chatTitle']),
      chatIcon: serializer.fromJson<int>(json['chatIcon']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      isArchive: serializer.fromJson<bool>(json['isArchive']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chatTitle': serializer.toJson<String>(chatTitle),
      'chatIcon': serializer.toJson<int>(chatIcon),
      'isPinned': serializer.toJson<bool>(isPinned),
      'isArchive': serializer.toJson<bool>(isArchive),
      'creationDate': serializer.toJson<DateTime>(creationDate),
    };
  }

  ChatTableData copyWith(
          {int? id,
          String? chatTitle,
          int? chatIcon,
          bool? isPinned,
          bool? isArchive,
          DateTime? creationDate}) =>
      ChatTableData(
        id: id ?? this.id,
        chatTitle: chatTitle ?? this.chatTitle,
        chatIcon: chatIcon ?? this.chatIcon,
        isPinned: isPinned ?? this.isPinned,
        isArchive: isArchive ?? this.isArchive,
        creationDate: creationDate ?? this.creationDate,
      );
  @override
  String toString() {
    return (StringBuffer('ChatTableData(')
          ..write('id: $id, ')
          ..write('chatTitle: $chatTitle, ')
          ..write('chatIcon: $chatIcon, ')
          ..write('isPinned: $isPinned, ')
          ..write('isArchive: $isArchive, ')
          ..write('creationDate: $creationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, chatTitle, chatIcon, isPinned, isArchive, creationDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatTableData &&
          other.id == this.id &&
          other.chatTitle == this.chatTitle &&
          other.chatIcon == this.chatIcon &&
          other.isPinned == this.isPinned &&
          other.isArchive == this.isArchive &&
          other.creationDate == this.creationDate);
}

class ChatTableCompanion extends UpdateCompanion<ChatTableData> {
  final Value<int> id;
  final Value<String> chatTitle;
  final Value<int> chatIcon;
  final Value<bool> isPinned;
  final Value<bool> isArchive;
  final Value<DateTime> creationDate;
  const ChatTableCompanion({
    this.id = const Value.absent(),
    this.chatTitle = const Value.absent(),
    this.chatIcon = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isArchive = const Value.absent(),
    this.creationDate = const Value.absent(),
  });
  ChatTableCompanion.insert({
    this.id = const Value.absent(),
    required String chatTitle,
    required int chatIcon,
    required bool isPinned,
    required bool isArchive,
    required DateTime creationDate,
  })  : chatTitle = Value(chatTitle),
        chatIcon = Value(chatIcon),
        isPinned = Value(isPinned),
        isArchive = Value(isArchive),
        creationDate = Value(creationDate);
  static Insertable<ChatTableData> custom({
    Expression<int>? id,
    Expression<String>? chatTitle,
    Expression<int>? chatIcon,
    Expression<bool>? isPinned,
    Expression<bool>? isArchive,
    Expression<DateTime>? creationDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatTitle != null) 'chat_title': chatTitle,
      if (chatIcon != null) 'chat_icon': chatIcon,
      if (isPinned != null) 'is_pinned': isPinned,
      if (isArchive != null) 'is_archive': isArchive,
      if (creationDate != null) 'creation_date': creationDate,
    });
  }

  ChatTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? chatTitle,
      Value<int>? chatIcon,
      Value<bool>? isPinned,
      Value<bool>? isArchive,
      Value<DateTime>? creationDate}) {
    return ChatTableCompanion(
      id: id ?? this.id,
      chatTitle: chatTitle ?? this.chatTitle,
      chatIcon: chatIcon ?? this.chatIcon,
      isPinned: isPinned ?? this.isPinned,
      isArchive: isArchive ?? this.isArchive,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chatTitle.present) {
      map['chat_title'] = Variable<String>(chatTitle.value);
    }
    if (chatIcon.present) {
      map['chat_icon'] = Variable<int>(chatIcon.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (isArchive.present) {
      map['is_archive'] = Variable<bool>(isArchive.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatTableCompanion(')
          ..write('id: $id, ')
          ..write('chatTitle: $chatTitle, ')
          ..write('chatIcon: $chatIcon, ')
          ..write('isPinned: $isPinned, ')
          ..write('isArchive: $isArchive, ')
          ..write('creationDate: $creationDate')
          ..write(')'))
        .toString();
  }
}

class $MessageIntoTableTable extends MessageIntoTable
    with TableInfo<$MessageIntoTableTable, MessageIntoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageIntoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _messageIdMeta =
      const VerificationMeta('messageId');
  @override
  late final GeneratedColumn<int> messageId = GeneratedColumn<int>(
      'message_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, chatId, messageId];
  @override
  String get aliasedName => _alias ?? 'message_into_table';
  @override
  String get actualTableName => 'message_into_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MessageIntoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta));
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageIntoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageIntoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      messageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}message_id'])!,
    );
  }

  @override
  $MessageIntoTableTable createAlias(String alias) {
    return $MessageIntoTableTable(attachedDatabase, alias);
  }
}

class MessageIntoTableData extends DataClass
    implements Insertable<MessageIntoTableData> {
  final int id;
  final int chatId;
  final int messageId;
  const MessageIntoTableData(
      {required this.id, required this.chatId, required this.messageId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_id'] = Variable<int>(chatId);
    map['message_id'] = Variable<int>(messageId);
    return map;
  }

  MessageIntoTableCompanion toCompanion(bool nullToAbsent) {
    return MessageIntoTableCompanion(
      id: Value(id),
      chatId: Value(chatId),
      messageId: Value(messageId),
    );
  }

  factory MessageIntoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageIntoTableData(
      id: serializer.fromJson<int>(json['id']),
      chatId: serializer.fromJson<int>(json['chatId']),
      messageId: serializer.fromJson<int>(json['messageId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chatId': serializer.toJson<int>(chatId),
      'messageId': serializer.toJson<int>(messageId),
    };
  }

  MessageIntoTableData copyWith({int? id, int? chatId, int? messageId}) =>
      MessageIntoTableData(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        messageId: messageId ?? this.messageId,
      );
  @override
  String toString() {
    return (StringBuffer('MessageIntoTableData(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('messageId: $messageId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, chatId, messageId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageIntoTableData &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.messageId == this.messageId);
}

class MessageIntoTableCompanion extends UpdateCompanion<MessageIntoTableData> {
  final Value<int> id;
  final Value<int> chatId;
  final Value<int> messageId;
  const MessageIntoTableCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.messageId = const Value.absent(),
  });
  MessageIntoTableCompanion.insert({
    this.id = const Value.absent(),
    required int chatId,
    required int messageId,
  })  : chatId = Value(chatId),
        messageId = Value(messageId);
  static Insertable<MessageIntoTableData> custom({
    Expression<int>? id,
    Expression<int>? chatId,
    Expression<int>? messageId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (messageId != null) 'message_id': messageId,
    });
  }

  MessageIntoTableCompanion copyWith(
      {Value<int>? id, Value<int>? chatId, Value<int>? messageId}) {
    return MessageIntoTableCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      messageId: messageId ?? this.messageId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<int>(messageId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageIntoTableCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('messageId: $messageId')
          ..write(')'))
        .toString();
  }
}

class $MessageTableTable extends MessageTable
    with TableInfo<$MessageTableTable, MessageTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _messageTextMeta =
      const VerificationMeta('messageText');
  @override
  late final GeneratedColumn<String> messageText = GeneratedColumn<String>(
      'message_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sendDateMeta =
      const VerificationMeta('sendDate');
  @override
  late final GeneratedColumn<DateTime> sendDate = GeneratedColumn<DateTime>(
      'send_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _imagePathsMeta =
      const VerificationMeta('imagePaths');
  @override
  late final GeneratedColumnWithTypeConverter<MessageImages, String>
      imagePaths = GeneratedColumn<String>('image_paths', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MessageImages>(
              $MessageTableTable.$converterimagePaths);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumnWithTypeConverter<MessageTags, String> tags =
      GeneratedColumn<String>('tags', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MessageTags>($MessageTableTable.$convertertags);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite =
      GeneratedColumn<bool>('is_favorite', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_favorite" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns =>
      [id, messageText, sendDate, imagePaths, tags, isFavorite];
  @override
  String get aliasedName => _alias ?? 'message_table';
  @override
  String get actualTableName => 'message_table';
  @override
  VerificationContext validateIntegrity(Insertable<MessageTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_text')) {
      context.handle(
          _messageTextMeta,
          messageText.isAcceptableOrUnknown(
              data['message_text']!, _messageTextMeta));
    } else if (isInserting) {
      context.missing(_messageTextMeta);
    }
    if (data.containsKey('send_date')) {
      context.handle(_sendDateMeta,
          sendDate.isAcceptableOrUnknown(data['send_date']!, _sendDateMeta));
    } else if (isInserting) {
      context.missing(_sendDateMeta);
    }
    context.handle(_imagePathsMeta, const VerificationResult.success());
    context.handle(_tagsMeta, const VerificationResult.success());
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      messageText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message_text'])!,
      sendDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}send_date'])!,
      imagePaths: $MessageTableTable.$converterimagePaths.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}image_paths'])!),
      tags: $MessageTableTable.$convertertags.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $MessageTableTable createAlias(String alias) {
    return $MessageTableTable(attachedDatabase, alias);
  }

  static TypeConverter<MessageImages, String> $converterimagePaths =
      const ImagesConverter();
  static TypeConverter<MessageTags, String> $convertertags =
      const TagsConverter();
}

class MessageTableData extends DataClass
    implements Insertable<MessageTableData> {
  final int id;
  final String messageText;
  final DateTime sendDate;
  final MessageImages imagePaths;
  final MessageTags tags;
  final bool isFavorite;
  const MessageTableData(
      {required this.id,
      required this.messageText,
      required this.sendDate,
      required this.imagePaths,
      required this.tags,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_text'] = Variable<String>(messageText);
    map['send_date'] = Variable<DateTime>(sendDate);
    {
      final converter = $MessageTableTable.$converterimagePaths;
      map['image_paths'] = Variable<String>(converter.toSql(imagePaths));
    }
    {
      final converter = $MessageTableTable.$convertertags;
      map['tags'] = Variable<String>(converter.toSql(tags));
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  MessageTableCompanion toCompanion(bool nullToAbsent) {
    return MessageTableCompanion(
      id: Value(id),
      messageText: Value(messageText),
      sendDate: Value(sendDate),
      imagePaths: Value(imagePaths),
      tags: Value(tags),
      isFavorite: Value(isFavorite),
    );
  }

  factory MessageTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageTableData(
      id: serializer.fromJson<int>(json['id']),
      messageText: serializer.fromJson<String>(json['messageText']),
      sendDate: serializer.fromJson<DateTime>(json['sendDate']),
      imagePaths: serializer.fromJson<MessageImages>(json['imagePaths']),
      tags: serializer.fromJson<MessageTags>(json['tags']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageText': serializer.toJson<String>(messageText),
      'sendDate': serializer.toJson<DateTime>(sendDate),
      'imagePaths': serializer.toJson<MessageImages>(imagePaths),
      'tags': serializer.toJson<MessageTags>(tags),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  MessageTableData copyWith(
          {int? id,
          String? messageText,
          DateTime? sendDate,
          MessageImages? imagePaths,
          MessageTags? tags,
          bool? isFavorite}) =>
      MessageTableData(
        id: id ?? this.id,
        messageText: messageText ?? this.messageText,
        sendDate: sendDate ?? this.sendDate,
        imagePaths: imagePaths ?? this.imagePaths,
        tags: tags ?? this.tags,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('MessageTableData(')
          ..write('id: $id, ')
          ..write('messageText: $messageText, ')
          ..write('sendDate: $sendDate, ')
          ..write('imagePaths: $imagePaths, ')
          ..write('tags: $tags, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, messageText, sendDate, imagePaths, tags, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageTableData &&
          other.id == this.id &&
          other.messageText == this.messageText &&
          other.sendDate == this.sendDate &&
          other.imagePaths == this.imagePaths &&
          other.tags == this.tags &&
          other.isFavorite == this.isFavorite);
}

class MessageTableCompanion extends UpdateCompanion<MessageTableData> {
  final Value<int> id;
  final Value<String> messageText;
  final Value<DateTime> sendDate;
  final Value<MessageImages> imagePaths;
  final Value<MessageTags> tags;
  final Value<bool> isFavorite;
  const MessageTableCompanion({
    this.id = const Value.absent(),
    this.messageText = const Value.absent(),
    this.sendDate = const Value.absent(),
    this.imagePaths = const Value.absent(),
    this.tags = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  MessageTableCompanion.insert({
    this.id = const Value.absent(),
    required String messageText,
    required DateTime sendDate,
    required MessageImages imagePaths,
    required MessageTags tags,
    required bool isFavorite,
  })  : messageText = Value(messageText),
        sendDate = Value(sendDate),
        imagePaths = Value(imagePaths),
        tags = Value(tags),
        isFavorite = Value(isFavorite);
  static Insertable<MessageTableData> custom({
    Expression<int>? id,
    Expression<String>? messageText,
    Expression<DateTime>? sendDate,
    Expression<String>? imagePaths,
    Expression<String>? tags,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageText != null) 'message_text': messageText,
      if (sendDate != null) 'send_date': sendDate,
      if (imagePaths != null) 'image_paths': imagePaths,
      if (tags != null) 'tags': tags,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  MessageTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? messageText,
      Value<DateTime>? sendDate,
      Value<MessageImages>? imagePaths,
      Value<MessageTags>? tags,
      Value<bool>? isFavorite}) {
    return MessageTableCompanion(
      id: id ?? this.id,
      messageText: messageText ?? this.messageText,
      sendDate: sendDate ?? this.sendDate,
      imagePaths: imagePaths ?? this.imagePaths,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageText.present) {
      map['message_text'] = Variable<String>(messageText.value);
    }
    if (sendDate.present) {
      map['send_date'] = Variable<DateTime>(sendDate.value);
    }
    if (imagePaths.present) {
      final converter = $MessageTableTable.$converterimagePaths;
      map['image_paths'] = Variable<String>(converter.toSql(imagePaths.value));
    }
    if (tags.present) {
      final converter = $MessageTableTable.$convertertags;
      map['tags'] = Variable<String>(converter.toSql(tags.value));
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageTableCompanion(')
          ..write('id: $id, ')
          ..write('messageText: $messageText, ')
          ..write('sendDate: $sendDate, ')
          ..write('imagePaths: $imagePaths, ')
          ..write('tags: $tags, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $TagsTableTable extends TagsTable
    with TableInfo<$TagsTableTable, TagsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tagTitleMeta =
      const VerificationMeta('tagTitle');
  @override
  late final GeneratedColumn<String> tagTitle = GeneratedColumn<String>(
      'tag_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagIconMeta =
      const VerificationMeta('tagIcon');
  @override
  late final GeneratedColumn<int> tagIcon = GeneratedColumn<int>(
      'tag_icon', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, tagTitle, tagIcon];
  @override
  String get aliasedName => _alias ?? 'tags_table';
  @override
  String get actualTableName => 'tags_table';
  @override
  VerificationContext validateIntegrity(Insertable<TagsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag_title')) {
      context.handle(_tagTitleMeta,
          tagTitle.isAcceptableOrUnknown(data['tag_title']!, _tagTitleMeta));
    } else if (isInserting) {
      context.missing(_tagTitleMeta);
    }
    if (data.containsKey('tag_icon')) {
      context.handle(_tagIconMeta,
          tagIcon.isAcceptableOrUnknown(data['tag_icon']!, _tagIconMeta));
    } else if (isInserting) {
      context.missing(_tagIconMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tagTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_title'])!,
      tagIcon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_icon'])!,
    );
  }

  @override
  $TagsTableTable createAlias(String alias) {
    return $TagsTableTable(attachedDatabase, alias);
  }
}

class TagsTableData extends DataClass implements Insertable<TagsTableData> {
  final int id;
  final String tagTitle;
  final int tagIcon;
  const TagsTableData(
      {required this.id, required this.tagTitle, required this.tagIcon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag_title'] = Variable<String>(tagTitle);
    map['tag_icon'] = Variable<int>(tagIcon);
    return map;
  }

  TagsTableCompanion toCompanion(bool nullToAbsent) {
    return TagsTableCompanion(
      id: Value(id),
      tagTitle: Value(tagTitle),
      tagIcon: Value(tagIcon),
    );
  }

  factory TagsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagsTableData(
      id: serializer.fromJson<int>(json['id']),
      tagTitle: serializer.fromJson<String>(json['tagTitle']),
      tagIcon: serializer.fromJson<int>(json['tagIcon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tagTitle': serializer.toJson<String>(tagTitle),
      'tagIcon': serializer.toJson<int>(tagIcon),
    };
  }

  TagsTableData copyWith({int? id, String? tagTitle, int? tagIcon}) =>
      TagsTableData(
        id: id ?? this.id,
        tagTitle: tagTitle ?? this.tagTitle,
        tagIcon: tagIcon ?? this.tagIcon,
      );
  @override
  String toString() {
    return (StringBuffer('TagsTableData(')
          ..write('id: $id, ')
          ..write('tagTitle: $tagTitle, ')
          ..write('tagIcon: $tagIcon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tagTitle, tagIcon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagsTableData &&
          other.id == this.id &&
          other.tagTitle == this.tagTitle &&
          other.tagIcon == this.tagIcon);
}

class TagsTableCompanion extends UpdateCompanion<TagsTableData> {
  final Value<int> id;
  final Value<String> tagTitle;
  final Value<int> tagIcon;
  const TagsTableCompanion({
    this.id = const Value.absent(),
    this.tagTitle = const Value.absent(),
    this.tagIcon = const Value.absent(),
  });
  TagsTableCompanion.insert({
    this.id = const Value.absent(),
    required String tagTitle,
    required int tagIcon,
  })  : tagTitle = Value(tagTitle),
        tagIcon = Value(tagIcon);
  static Insertable<TagsTableData> custom({
    Expression<int>? id,
    Expression<String>? tagTitle,
    Expression<int>? tagIcon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagTitle != null) 'tag_title': tagTitle,
      if (tagIcon != null) 'tag_icon': tagIcon,
    });
  }

  TagsTableCompanion copyWith(
      {Value<int>? id, Value<String>? tagTitle, Value<int>? tagIcon}) {
    return TagsTableCompanion(
      id: id ?? this.id,
      tagTitle: tagTitle ?? this.tagTitle,
      tagIcon: tagIcon ?? this.tagIcon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tagTitle.present) {
      map['tag_title'] = Variable<String>(tagTitle.value);
    }
    if (tagIcon.present) {
      map['tag_icon'] = Variable<int>(tagIcon.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsTableCompanion(')
          ..write('id: $id, ')
          ..write('tagTitle: $tagTitle, ')
          ..write('tagIcon: $tagIcon')
          ..write(')'))
        .toString();
  }
}

abstract class _$ChatDatabase extends GeneratedDatabase {
  _$ChatDatabase(QueryExecutor e) : super(e);
  late final $ChatTableTable chatTable = $ChatTableTable(this);
  late final $MessageIntoTableTable messageIntoTable =
      $MessageIntoTableTable(this);
  late final $MessageTableTable messageTable = $MessageTableTable(this);
  late final $TagsTableTable tagsTable = $TagsTableTable(this);
  late final ChatDao chatDao = ChatDao(this as ChatDatabase);
  late final MessageIntoDao messageIntoDao =
      MessageIntoDao(this as ChatDatabase);
  late final MessageDao messageDao = MessageDao(this as ChatDatabase);
  late final TagsDao tagsDao = TagsDao(this as ChatDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [chatTable, messageIntoTable, messageTable, tagsTable];
}
