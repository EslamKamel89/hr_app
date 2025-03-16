import 'package:bloc/bloc.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/models/company_bank_model.dart';

class CompanyBankCubit extends Cubit<ApiCrudResponseModel<CompanyBankModel>> {
  CompanyFormController controller = serviceLocator();
  CompanyBankCubit() : super(ApiCrudResponseModel.initial());
  // Future contactShow(BuildContext context) async {
  //   final t = prt('contactShow - CompanyFormCubit');
  //   final company = getCompany(context);
  //   if (company == null || company.id == null) {
  //     pr('Error" company basic data cant be null', t);
  //     return;
  //   }
  //   emit(
  //     state.copyWith(
  //       showResponse: ResponseEnum.loading,
  //       upsertResponse: ResponseEnum.initial,
  //       data: null,
  //       errorMessage: null,
  //     ),
  //   );
  //   pr('Loading....', t);
  //   final contactRes = await controller.contactShow(company.id!);
  //   pr(contactRes, t);
  //   if (!isClosed) {
  //     emit(contactRes);
  //   }
  // }

  // Future contactUpsert(
  //   BuildContext context,
  //   CompanyContactModel contact,
  // ) async {
  //   final t = prt('contactUpsert - CompanyFormCubit');
  //   final company = getCompany(context);
  //   if (company == null || company.id == null) {
  //     pr('Error" company basic data cant be null', t);
  //     return;
  //   }
  //   emit(
  //     state.copyWith(
  //       upsertResponse: ResponseEnum.loading,
  //       showResponse: ResponseEnum.initial,
  //       data: null,
  //       errorMessage: null,
  //     ),
  //   );
  //   pr('Loading....', t);
  //   final contactRes = await controller.contactUpsert(company.id!, contact);
  //   pr(contactRes, t);
  //   emit(contactRes);
  // }
}
