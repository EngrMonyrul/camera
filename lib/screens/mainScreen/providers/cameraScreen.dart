import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreenProvider with ChangeNotifier {
  late File _image;
  String _imagePath = '';

  File get pickedImage => _image;
  String get imagePath => _imagePath;

  Future cameraImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final _cameraImagePath = File(image.path);
    _image = _cameraImagePath;
    _imagePath = image.path;
    print('Image Saved In - $_image');
    notifyListeners();
  }

  Future galleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final _galleryImagePath = File(image.path);
    _image = _galleryImagePath;
    print('Image In - $_image');
    notifyListeners();
  }

  Future saveToGallery() async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(_imagePath);
    File('${directory.path}/$name');
    notifyListeners();
  }
}
