import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hr/core/api_service/api_consumer.dart';
import 'package:hr/core/api_service/end_points.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/heleprs/snackbar.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/auth/controllers/params/register_params.dart';
import 'package:hr/features/auth/helpers/auth_helpers.dart';
import 'package:hr/features/auth/models/user_model.dart';

class AuthController {
  ApiConsumer api = serviceLocator();

  Future<ApiResponseModel<UserModel?>> register({
    required RegisterParams params,
  }) async {
    final t = prt('register - AuthController');
    try {
      final response = await api.post(EndPoint.register, data: params.toJson());
      UserModel user = UserModel.fromJson(response['user']);
      user.accessToken = response['access_token'];
      AuthHelpers.cacheUser(user);
      return pr(
        ApiResponseModel(response: ResponseEnum.success, data: user),
        t,
      );
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = jsonEncode(e.response?.data ?? 'Unknown error occured');
      }
      showSnackbar('Error', errorMessage, true);
      return pr(
        ApiResponseModel(
          errorMessage: errorMessage,
          response: ResponseEnum.failed,
        ),
        t,
      );
    }
  }
}
