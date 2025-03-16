// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hr/core/enums/response_type.dart';

class ApiResponseModel<T> {
  T? data;
  String? errorMessage;
  ResponseEnum? response;
  ApiResponseModel({
    this.data,
    this.errorMessage,
    this.response = ResponseEnum.initial,
  });

  ApiResponseModel<T> copyWith({
    T? data,
    String? errorMessage,
    ResponseEnum? response,
  }) {
    return ApiResponseModel<T>(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      response: response ?? this.response,
    );
  }

  ApiResponseModel.initial() {
    response = ResponseEnum.initial;
  }
  ApiResponseModel<T> modify({
    T? data,
    String? errorMessage,
    ResponseEnum? response,
  }) {
    return ApiResponseModel<T>(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      response: response ?? this.response,
    );
  }

  @override
  String toString() =>
      'ApiResponseModel(data: $data, errorMessage: $errorMessage, response: $response)';
}

class ApiCrudResponseModel<T> {
  T? data;
  String? errorMessage;
  ResponseEnum? showResponse;
  ResponseEnum? upsertResponse;
  ApiCrudResponseModel({
    this.data,
    this.errorMessage,
    this.showResponse = ResponseEnum.initial,
    this.upsertResponse = ResponseEnum.initial,
  });

  ApiCrudResponseModel<T> copyWith({
    T? data,
    String? errorMessage,
    ResponseEnum? showResponse,
    ResponseEnum? upsertResponse,
  }) {
    return ApiCrudResponseModel<T>(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      showResponse: showResponse ?? this.showResponse,
      upsertResponse: upsertResponse ?? this.upsertResponse,
    );
  }

  ApiCrudResponseModel.initial() {
    showResponse = ResponseEnum.initial;
    upsertResponse = ResponseEnum.initial;
  }
  @override
  String toString() =>
      'ApiResponseModel(data: $data, errorMessage: $errorMessage, response: $showResponse)';
}
