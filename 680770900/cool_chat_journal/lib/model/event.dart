/// Contains information about event.
class Event { 
  String text;

  bool isFavorite;
  DateTime changeTime = DateTime.now();

  Event(this.text, {this.isFavorite = false});

}
