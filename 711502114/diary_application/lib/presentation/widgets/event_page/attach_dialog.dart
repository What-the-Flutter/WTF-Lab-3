import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class AttachDialog {
  final BuildContext context;
  final AppLocalizations? local;
  final void Function(String? path) pathAction;

  AttachDialog(this.context, this.local, this.pathAction);

  Future<void> open() async {
    final info = local?.attachDialogInfo ?? '';
    final cancel = local?.cancel ?? '';
    final gallery = local?.gallery ?? '';
    final camera = local?.camera ?? '';
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(info, style: const TextStyle(fontSize: 24)),
        ),
        actions: <Widget>[
          _initButton(cancel, _close),
          _initButton(gallery, () => _pick(ImageSource.gallery)),
          _initButton(camera, () => _pick(ImageSource.camera)),
        ],
      ),
    ));
  }

  TextButton _initButton(String text, void Function() action) {
    return TextButton(
      onPressed: action,
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  void _close() {
    Navigator.of(context).pop(false);
  }

  void _pick(ImageSource imageSource) async {
    final _picker = ImagePicker();
    final photo = await _picker.pickImage(source: imageSource);
    pathAction(photo?.path);

    _close();
  }
}
