import 'package:bloc/bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/companies_controller.dart';
import 'package:hr/features/companies/models/company_model.dart';

class CompaniesIndexCubit extends Cubit<ApiResponseModel<List<CompanyModel>>> {
  CompaniesController controller = serviceLocator();
  CompaniesIndexCubit()
    : super(ApiResponseModel(response: ResponseEnum.initial));
  Future index() async {
    final t = prt('index - CompaniesIndexCubit');
    emit(
      pr(state.copyWith(errorMessage: null, response: ResponseEnum.loading), t),
    );
    emit(pr(await controller.index(), t));
  }
}
