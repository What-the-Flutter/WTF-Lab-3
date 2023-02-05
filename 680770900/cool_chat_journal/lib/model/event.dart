/// Contains information about event.   
class Event { 
  dynamic content;

  bool isImage;
  bool isFavorite;
  DateTime changeTime = DateTime.now();

  Event(this.content, {this.isFavorite = false, this.isImage = false});
}
