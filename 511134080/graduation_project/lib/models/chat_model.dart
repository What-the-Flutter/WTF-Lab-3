import 'package:flutter/material.dart';
import 'package:graduation_project/models/event_card_model.dart';

class ChatModel {
  Key id;
  Icon icon;
  String title;
  String lastEventTitle = 'No events. Click here to create one.';

  var allCards = <EventCardModel>[];
  var favouriteCards = <EventCardModel>[];
  var selectedCards = <EventCardModel>[];

  ChatModel({
    required this.icon,
    required this.title,
    required this.id,
  });
}
