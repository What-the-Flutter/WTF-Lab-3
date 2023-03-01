import 'package:flutter/material.dart';
import 'package:graduation_project/entities/event_card.dart';

class ChatModel {
  Key id;

  var allCards = <Widget>[];
  var favouriteCards = <EventCard>[];
  var selectedCards = <EventCard>[];

  ChatModel({required this.id});
}
