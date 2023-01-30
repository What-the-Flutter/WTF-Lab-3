import 'dart:io';

class ImageMessage {
  final File _file;

  ImageMessage({file}) : _file = file;

  File get file => _file;
}
