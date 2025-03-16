import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_legal_model.dart';

class CompanyLegalCubit extends Cubit<ApiCrudResponseModel<CompanyLegalModel>> {
  CompanyFormController controller = serviceLocator();
  CompanyLegalCubit() : super(ApiCrudResponseModel.initial());
  Future legalShow(BuildContext context) async {
    final t = prt('legalShow - CompanyLegalCubit');
    final company = getCompany(context);
    if (company == null || company.id == null) {
      pr('Error" company basic data cant be null', t);
      return;
    }
    emit(
      state.copyWith(
        showResponse: ResponseEnum.loading,
        upsertResponse: ResponseEnum.initial,
        data: null,
        errorMessage: null,
      ),
    );
    pr('Loading....', t);
    final legalRes = await controller.legalShow(company.id!);
    pr(legalRes, t);
    if (!isClosed) {
      emit(legalRes);
    }
  }

  Future legalUpsert(BuildContext context, CompanyLegalModel legalModel) async {
    final t = prt('legalUpsert - CompanyLegalCubit');
    final company = getCompany(context);
    if (company == null || company.id == null) {
      pr('Error" company basic data cant be null', t);
      return;
    }
    emit(
      state.copyWith(
        upsertResponse: ResponseEnum.loading,
        showResponse: ResponseEnum.initial,
        data: null,
        errorMessage: null,
      ),
    );
    pr('Loading....', t);
    final legalRes = await controller.legalUpsert(company.id!, legalModel);
    pr(legalRes, t);
    emit(legalRes);
  }
}
