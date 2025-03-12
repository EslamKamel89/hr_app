import 'package:hr/core/api_service/api_consumer.dart';
import 'package:hr/core/api_service/end_points.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/handle_exception.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/models/company_model.dart';

class CompanyFormController {
  ApiConsumer api = serviceLocator();
  Future<ApiResponseModel<CompanyModel>> basic({
    required CompanyModel company,
  }) async {
    final t = prt(
      'basic - CompanyFormController - ${company.companyName} - ${company.id == null ? 'Create' : 'Update'}',
    );
    try {
      dynamic response;
      if (company.id == null) {
        response = await api.post(
          EndPoint.companiesIndex,
          data: company.toJson(),
        );
      } else {
        response = await api.patch(
          '${EndPoint.companiesIndex}/${company.id}',
          data: company.toJson(),
        );
      }
      CompanyModel companyModel = CompanyModel.fromJson(
        company.id != null ? response['companyBasic'] : response,
      );

      return pr(
        ApiResponseModel(response: ResponseEnum.success, data: companyModel),
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
}
