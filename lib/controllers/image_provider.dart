import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageProvider extends ChangeNotifier {
  File? image;

  selectedImage({
    required ImageSource source,
  }) async {
    final takenImage = await ImagePicker().pickImage(source: source);
    image = File(takenImage!.path);

    notifyListeners();
  }
}
