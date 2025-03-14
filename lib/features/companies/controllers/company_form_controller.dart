import 'package:hr/core/api_service/api_consumer.dart';
import 'package:hr/core/api_service/end_points.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/handle_exception.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/heleprs/snackbar.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/models/company_contact_model.dart';
import 'package:hr/features/companies/models/company_main_department_model/company_main_department_model.dart';
import 'package:hr/features/companies/models/company_main_department_model/compoany_sub_department_model.dart';
import 'package:hr/features/companies/models/company_model.dart';

class CompanyFormController {
  ApiConsumer api = serviceLocator();
  Future<ApiResponseModel<CompanyModel>> basic({required CompanyModel company}) async {
    final t = prt(
      'basic - CompanyFormController - ${company.companyName} - ${company.id == null ? 'Create' : 'Update'}',
    );
    try {
      dynamic response;
      if (company.id == null) {
        response = await api.post(EndPoint.companiesIndex, data: company.toJson());
      } else {
        response = await api.put(
          '${EndPoint.companiesIndex}/${company.id}',
          data: company.toJson(),
        );
      }
      CompanyModel companyModel = CompanyModel.fromJson(
        company.id != null ? response['companyBasic'] : response,
      );
      showSnackbar('Success', '${company.companyName} Updated Successfully', false);
      return pr(ApiResponseModel(response: ResponseEnum.success, data: companyModel), t);
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }

  Future<ApiCrudResponseModel<CompanyContactModel>> contactShow(int companyId) async {
    final t = prt('contactShow - CompanyFormController ');
    try {
      final response = await api.get('${EndPoint.companyContact}/$companyId');
      CompanyContactModel companyContactModel = CompanyContactModel.fromJson(response['contact']);
      // showSnackbar('Success', 'Data Saved Successfully', false);
      return pr(
        ApiCrudResponseModel(showResponse: ResponseEnum.success, data: companyContactModel),
        t,
      );
    } catch (e) {
      // String errorMessage = handeException(e);
      return pr(
        ApiCrudResponseModel(errorMessage: 'No data found', showResponse: ResponseEnum.failed),
        t,
      );
    }
  }

  Future<ApiCrudResponseModel<CompanyContactModel>> contactUpsert(
    int companyId,
    CompanyContactModel contact,
  ) async {
    final t = prt('contactUpsert - CompanyFormController ');
    try {
      final response = await api.put(
        '${EndPoint.companyContact}/$companyId',
        data: contact.toJson(),
      );
      CompanyContactModel companyContactModel = CompanyContactModel.fromJson(response['contact']);
      showSnackbar('Success', 'Data Saved Successfully', false);
      return pr(
        ApiCrudResponseModel(upsertResponse: ResponseEnum.success, data: companyContactModel),
        t,
      );
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(
        ApiCrudResponseModel(errorMessage: errorMessage, upsertResponse: ResponseEnum.failed),
        t,
      );
    }
  }

  Future<ApiResponseModel<List<CompanyMainDepartmentModel>>> companyDepartmentsIndex(
    int companyId,
  ) async {
    final t = prt('companyDepartmentIndex - CompanyFormController ');
    try {
      final response = await api.get('${EndPoint.companyMainDepartment}/$companyId');
      List<CompanyMainDepartmentModel> departments =
          (response['main_departments'] as List<dynamic>)
              .map((e) => CompanyMainDepartmentModel.fromJson(e as Map<String, dynamic>))
              .toList();
      // showSnackbar('Success', 'Data Saved Successfully', false);
      return pr(ApiResponseModel(response: ResponseEnum.success, data: departments), t);
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }

  Future<ApiResponseModel<CompanyMainDepartmentModel>> upsertMainDepartment(
    CompanyMainDepartmentModel model,
  ) async {
    final t = prt('upsertMainDepartment - CompanyFormController ');
    try {
      final dynamic response;
      if (model.id == null) {
        response = await api.post(EndPoint.companyMainDepartment, data: model.toJson());
      } else {
        response = await api.put(
          '${EndPoint.companyMainDepartment}/${model.id}',
          data: model.toJson(),
        );
      }
      CompanyMainDepartmentModel department = CompanyMainDepartmentModel.fromJson(
        response[model.id == null ? 'main_department' : 'company_main_department'],
      );
      showSnackbar('Success', 'Data Saved Successfully', false);
      return pr(ApiResponseModel(response: ResponseEnum.success, data: department), t);
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }

  Future<ApiResponseModel<String>> deleteMainDepartment(CompanyMainDepartmentModel model) async {
    final t = prt('deleteMainDepartment - CompanyFormController ');
    try {
      final response = await api.delete('${EndPoint.companyMainDepartment}/${model.id}');

      String message = response['message'];
      showSnackbar('Success', message, false);
      return pr(ApiResponseModel(response: ResponseEnum.success, data: message), t);
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }

  Future<ApiResponseModel<CompanySubDepartmentModel>> upsertSubDepartment(
    CompanySubDepartmentModel model,
  ) async {
    final t = prt('upsertSubDepartment - CompanyFormController ');
    try {
      final dynamic response;
      if (model.subDeptId == null) {
        response = await api.post(EndPoint.companySubDepartment, data: model.toJson());
      } else {
        response = await api.put(
          '${EndPoint.companySubDepartment}/${model.subDeptId}',
          data: model.toJson(),
        );
      }
      CompanySubDepartmentModel subDepartment = CompanySubDepartmentModel.fromJson(
        response['sub_department'],
      );
      showSnackbar('Success', 'Data Saved Successfully', false);
      return pr(ApiResponseModel(response: ResponseEnum.success, data: subDepartment), t);
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }

  Future<ApiResponseModel<String>> deleteSubDepartment(int subDeptId) async {
    final t = prt('deleteSubDepartment - CompanyFormController ');
    try {
      final response = await api.delete('${EndPoint.companySubDepartment}/$subDeptId');

      String message = response['message'];
      showSnackbar('Success', message, false);
      return pr(ApiResponseModel(response: ResponseEnum.success, data: message), t);
    } catch (e) {
      String errorMessage = handeException(e);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }
}
