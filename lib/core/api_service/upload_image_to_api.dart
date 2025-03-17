import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

Future<MultipartFile> uploadXFileImageToApi(XFile image) async {
  return await MultipartFile.fromFile(image.path, filename: image.path.split('/').last);
}

Future<MultipartFile?> uploadFileImageToApi(File? image) async {
  if (image == null) return null;
  return await MultipartFile.fromFile(image.path, filename: image.path.split('/').last);
}
