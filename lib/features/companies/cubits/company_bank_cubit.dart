import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/heleprs/print_helper.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/features/companies/controllers/company_form_controller.dart';
import 'package:hr/features/companies/helpers/get_company.dart';
import 'package:hr/features/companies/models/company_bank_model.dart';

class CompanyBankCubit extends Cubit<ApiCrudResponseModel<CompanyBankModel>> {
  CompanyFormController controller = serviceLocator();
  CompanyBankCubit() : super(ApiCrudResponseModel.initial());
  Future bankShow(BuildContext context) async {
    final t = prt('bankShow - CompanyFormCubit');
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
    final bankRes = await controller.bankShow(company.id!);
    pr(bankRes, t);
    if (!isClosed) {
      emit(bankRes);
    }
  }

  Future bankUpsert(BuildContext context, CompanyBankModel bankModel) async {
    final t = prt('bankUpsert - CompanyFormCubit');
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
    final bankRes = await controller.bankUpsert(company.id!, bankModel);
    pr(bankRes, t);
    emit(bankRes);
  }
}
