import 'package:graduation_project/models/event_card_model.dart';

class ChatModel {
  dynamic id;
  final int iconId;
  String title;
  String lastEventTitle = 'No events. Click here to create one.';

  var allCards = <EventCardModel>[];
  var favouriteCards = <EventCardModel>[];
  var selectedCards = <EventCardModel>[];

  ChatModel({
    required this.iconId,
    required this.title,
    required this.id,
  });
}
