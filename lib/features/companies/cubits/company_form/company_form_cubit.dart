import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/models/company_contact_model.dart';
import 'package:hr/features/companies/models/company_model.dart';

part 'company_form_state.dart';

class CompanyFormCubit extends Cubit<CompanyFormState> {
  final CompanyFormController controller = serviceLocator();
  CompanyFormCubit()
    : super(CompanyFormState(company: ApiResponseModel(response: ResponseEnum.initial)));
  Future basic() async {
    final t = prt('basic - CompanyFormCubit');
    if (state.company?.data == null) {
      pr('Error" company model cant be null', t);
      return;
    }
    emit(
      state.copyWith(
        company: state.company?.copyWith(errorMessage: null, response: ResponseEnum.loading),
      ),
    );
    pr('Loading....', t);
    final companyRes = await controller.basic(company: (state.company?.data)!);
    pr(companyRes, t);
    emit(state.copyWith(company: companyRes));
  }

  void changeTab(int tab) {
    emit(state.copyWith(currentTab: tab));
  }
}
