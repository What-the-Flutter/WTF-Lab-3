/// Contains information about event.
class Event { 
  String _text;

  bool isFavorite;
  DateTime changeTime = DateTime.now();

  String get text => _text;
  set text(String value) {
    _text = value;
    changeTime = DateTime.now();
  } 

  Event(this._text, {this.isFavorite = false});

}
