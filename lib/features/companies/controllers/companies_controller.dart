import 'package:hr/core/api_service/api_consumer.dart';
import 'package:hr/core/api_service/end_points.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/handle_exception.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/models/company_model.dart';

class CompaniesController {
  ApiConsumer api = serviceLocator();

  Future<ApiResponseModel<List<CompanyModel>>> index() async {
    final t = prt('index - CompaniesController');
    try {
      final response = await api.get(EndPoint.companiesIndex);
      List<CompanyModel> companies =
          (response['companies'] as List)
              .map((json) => CompanyModel.fromJson(json))
              .toList();

      return pr(
        ApiResponseModel(response: ResponseEnum.success, data: companies),
        t,
      );
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(
        ApiResponseModel(
          errorMessage: errorMessage,
          response: ResponseEnum.failed,
        ),
        t,
      );
    }
  }

  Future<ApiResponseModel> delete(int id) async {
    final t = prt('delete - CompaniesController');
    try {
      final response = await api.delete('${EndPoint.companiesIndex}/$id');
      pr(response, t);
      return pr(ApiResponseModel(response: ResponseEnum.success), t);
    } catch (e) {
      String errorMessage = handeException(e);
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
