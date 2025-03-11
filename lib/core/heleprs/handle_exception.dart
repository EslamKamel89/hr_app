import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hr/core/heleprs/snackbar.dart';

String handeException(Object e) {
  String errorMessage = e.toString();
  if (e is DioException) {
    errorMessage = jsonEncode(e.response?.data ?? 'Unknown error occured');
  }
  showSnackbar('Error', errorMessage, true);
  return errorMessage;
}
