import 'package:bloc/bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/models/company_main_department_model/company_main_department_model.dart';

class CompanyDepartmentsIndexCubit
    extends Cubit<ApiResponseModel<List<CompanyMainDepartmentModel>>> {
  CompanyFormController controller = serviceLocator();
  CompanyDepartmentsIndexCubit() : super(ApiResponseModel(response: ResponseEnum.initial));

  Future index(int companyId) async {
    final t = prt('index - CompanyDepartmentsIndexCubit');
    emit(pr(state.copyWith(errorMessage: null, response: ResponseEnum.loading), t));
    emit(pr(await controller.companyDepartmentsIndex(companyId), t));
  }

  void resetState() {
    emit(ApiResponseModel(response: ResponseEnum.initial));
  }
}
